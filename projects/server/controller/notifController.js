import InvoiceHeader from "../models/InvoiceHeaderModel.js";
import { transporter } from "../helper/nodemailer.js";
import { handlebarOptions } from "../helper/handlebars.js";
import hbs from "nodemailer-express-handlebars";
import { createPdf } from "../helper/createPdf.js";
import Users from "../models/UserModel.js";
import { toCurrency } from "../helper/toCurrency.js";
import InvoiceDetail from "../models/InvoiceDetailModel.js";
import Products from "../models/ProductModel.js";
import { createInvoiceHtml } from "../helper/createHtml.js";
import Address from "../models/AddressModel.js";
import moment from "moment";

export const sendOrderNotif = async (req, res) => {
  try {
    // console.log(req.body);
    const result = await InvoiceHeader.findOne({
      include: [
        {
          model: Users,
          attributes: ["first_name", "last_name", "email", "phone"],
        },
        { model: Address },
        {
          model: InvoiceDetail,
          include: [{ model: Products, attributes: ["name"] }],
        },
      ],
      where: { invoice_id: req.body.invoice_id },
    });

    let data = {
      invoice_id: result.invoice_id,
      name: `${result.user.first_name} ${result.user.last_name}`,
      phone: result.user.phone,
      email: result.user.email,
      address: result.address.address,
      date: moment(result.createdAt).format("DD MMM YYYY"),
      grand_total: toCurrency(result.grand_total),
      items: "",
    };
    let subTotal = 0;
    await result.invoice_details.forEach((item) => {
      subTotal += item.price * item.qty;
      data.items += `<tr>
                        <td class="service">${
                          result.invoice_details.indexOf(item) + 1
                        }</td>
                        <td class="service">${item.product.name}</td>
                        <td>${toCurrency(item.price)}</td>
                        <td>${item.qty}</td>
                        <td>${toCurrency(item.price * item.qty)}</td>
                    </tr>`;
    });
    data.subTotal = toCurrency(subTotal);
    data.shipping = toCurrency(result.grand_total - subTotal);

    const pdfFile = await createPdf(createInvoiceHtml(data));

    const context = {
      name: result.user.first_name,
      invoice_id: result.invoice_id,
      amount: toCurrency(result.grand_total),
    };

    const mail = {
      from: `RAMU <kuperhubid@gmail.com>`,
      to: result.user.email,
      subject: `New Invoice from RAMU`,
      template: "invoice",
      context,
      attachments: [
        {
          filename: "invoice.pdf",
          content: pdfFile,
          // cid: 'uniq-mailtrap.png'
        },
      ],
    };

    transporter.use("compile", hbs(handlebarOptions));
    transporter.sendMail(mail);

    res.status(200).send(true);
  } catch (error) {
    console.log(error);
    res.status(500).send(error);
  }
};
