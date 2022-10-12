import User from "../models/UserModel.js";
import bcrypt, { hash } from "bcrypt";
import { transporter } from "../helper/nodemailer.js";
import hbs from "nodemailer-express-handlebars";
import { handlebarOptions } from "../helper/handlebars.js";
import jwt from "jsonwebtoken";
import Address from "../models/AddressModel.js";

export const loginUser = async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await User.findOne({
      where: {
        email: email,
      },
      // include: {
      //   model: Address,
      // },
    });

    console.log(user);

    const id = user.id;
    const uuid = user.uuid;
    const first_name = user.first_name;
    const last_name = user.last_name;
    const is_verified = user.is_verified;
    const active_status = user.active_status;
    const phone = user.phone;

    if (user) {
      const validate = await bcrypt.compare(password, user.password);
      if (!validate) {
        res.status(400).send({ msg: "Password is incorrect!" });
      } else {
        const token = jwt.sign({ email: user.email }, process.env.JWT_KEY, {
          expiresIn: "1h",
        });
        res.status(200).json({
          id,
          uuid,
          email,
          phone,
          first_name,
          last_name,
          is_verified,
          active_status,
          token,
        });
      }
    }
  } catch (error) {
    res.status(404).json({ msg: "User Not Found!" });
  }
};

export const keepLoginUser = async (req, res) => {
  if (!req.session.userId) {
    return res.status(401).json({ msg: "Please Log In to your account" });
  }
  const user = await User.findOne({
    attributes: ["uuid", "email", "is_verified", "active_status"],
    where: {
      uuid: req.session.uuid,
    },
  });
  if (!user) return res.status(404).json({ msg: "User Not Found" });
  res.status(200).json(user);
};

export const logoutUser = async (req, res) => {
  req.session.destroy((err) => {
    if (err) return res.status(400).json({ msg: "Cannot Logout" });
    res.status(200).json({ msg: "You've been logged out" });
  });
};

export const getUser = async (req, res) => {
  try {
    const response = await User.findAll({
      attributes: [
        "id",
        "uuid",
        "first_name",
        "last_name",
        "email",
        "phone",
        "is_verified",
        "active_status",
      ],
      // include: { model: Address },
    });
    res.status(200).json(response);
  } catch (error) {
    res.status(500).json({ msg: error.message });
  }
};

export const deactUser = async (req, res) => {
  try {
    const uuid = await User.findOne({
      attributes: ["uuid"],
      where: {
        uuid: req.params.id,
      },
    });

    if (uuid) {
      await User.update(
        {
          active_status: false,
        },
        {
          where: { uuid: req.params.id },
        }
      );
    }
    res.status(201).json({ msg: "User Deactivated", uuid });
  } catch (error) {
    res.status(400).json({ msg: error.message });
  }
};

export const activateUser = async (req, res) => {
  try {
    const uuid = await User.findOne({
      attributes: ["uuid"],
      where: {
        uuid: req.params.id,
      },
    });

    if (uuid) {
      await User.update(
        {
          active_status: true,
        },
        {
          where: { uuid: req.params.id },
        }
      );
    }
    res.status(201).json({ msg: "User Activated", uuid });
  } catch (error) {
    res.status(400).json({ msg: error.message });
  }
};

export const createUser = async (req, res) => {
  const { first_name, last_name, email, password, phone } = req.body;
  const salt = await bcrypt.genSalt(10);
  const hashedPass = await bcrypt.hash(password, salt);

  try {
    const alreadyExistUser = await User.findOne({ where: { email } }).catch(
      (err) => {
        console.log("Error", err);
      }
    );

    if (alreadyExistUser) {
      return res.status(400).json({ msg: "Email already exists!" });
    }

    transporter.use("compile", hbs(handlebarOptions));

    const response = await User.create({
      first_name,
      last_name,
      email,
      password: hashedPass,
      phone,
      is_verified: false,
      active_status: true,
      include: { model: Address },
    });

    let mail = {
      from: "kuperhubid@gmail.com",
      to: email,
      subject: "RAMU Account Verification",
      template: "email",
      context: {
        user: first_name,
        uuid: response.uuid,
      },
    };

    transporter.sendMail(mail, (errMail, resMail) => {
      if (errMail) {
        console.log(errMail);
      }
    });

    res.status(201).json({ msg: "Account Registered!" });
  } catch (error) {
    res.status(400).json({ msg: error.message });
  }
};

export const verifyUser = async (req, res) => {
  try {
    const uuid = await User.findOne({
      attributes: ["uuid"],
      where: {
        uuid: req.params.id,
      },
    });

    if (uuid) {
      await User.update(
        {
          is_verified: true,
        },
        {
          where: { uuid: req.params.id },
        }
      );
    }
    res.status(201).json({ msg: "User Verified", uuid });
  } catch (error) {
    res.status(400).json({ msg: error.message });
  }
};

export const sendResetPassLink = async (req, res) => {
  const { email } = req.body;
  try {
    const user = await User.findOne({
      attributes: ["uuid", "email", "first_name"],
      where: {
        email: email,
      },
    });

    transporter.use("compile", hbs(handlebarOptions));

    if (!user)
      return res.status(404).json({ msg: "User with this email is not found" });

    let mail = {
      from: "kuperhubid@gmail.com",
      to: email,
      subject: "RAMU Account Reset Password",
      template: "resetPass",
      context: {
        user: user.first_name,
        uuid: user.uuid,
      },
    };

    transporter.sendMail(mail, (errMail, resMail) => {
      if (errMail) {
        console.log(errMail);
      }
    });
    res.status(201).json({ msg: "Reset Password Link Sent!", user });
  } catch (error) {
    res.status(400).json({ msg: error.message });
  }
};

export const resetPassUser = async (req, res) => {
  const { password } = req.body;
  const salt = await bcrypt.genSalt(10);
  const hashedPass = await bcrypt.hash(password, salt);

  try {
    const user = await User.findOne({
      attributes: ["uuid"],
      where: {
        uuid: req.params.id,
      },
    });

    if (user) {
      await User.update(
        {
          password: hashedPass,
        },
        {
          where: { uuid: req.params.id },
        }
      );
    }
    res.status(201).json({ msg: "Password Updated!" });
  } catch (error) {
    res.status(400).json({ msg: error.message });
  }
};
