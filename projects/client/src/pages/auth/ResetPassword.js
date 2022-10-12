import React, { useEffect, useState } from "react";
import {
  Block,
  BlockContent,
  BlockDes,
  BlockHead,
  BlockTitle,
  Button,
  PreviewCard,
} from "../../components/Component";
import Logo from "../../images/logo.png";
import LogoDark from "../../images/logo-dark.png";
import { FormGroup, Spinner } from "reactstrap";
import PageContainer from "../../layout/page-container/PageContainer";
import Head from "../../layout/head/Head";
import AuthFooter from "./AuthFooter";
import { Link, useParams } from "react-router-dom";
import { Icon } from "../../components/Component";
import { useDispatch } from "react-redux";
import axios from "axios";

const ResetPassword = ({ history }) => {
  const dispatch = useDispatch();
  const { uuid } = useParams();
  const [passState, setPassState] = useState(false);
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [msg, setMsg] = useState("");

  // useEffect(() => {
  //   dispatch(resetPassUser(uuid.slice(1)));
  // });
  const ResetPassword = async (e) => {
    e.preventDefault();
    try {
      await axios.patch(`http://localhost:2000/users/reset-password/${uuid}`, {
        password: password,
      });
      history.push(`${process.env.PUBLIC_URL}/reset-password-success`);
    } catch (error) {
      if (error.response) {
        setMsg(error.response.data.msg);
      }
    }
  };

  return (
    <React.Fragment>
      <Head title="ResetPassword" />
      <PageContainer>
        <Block className="nk-block-middle nk-auth-body  wide-xs">
          <div className="brand-logo pb-4 text-center">
            <Link to={process.env.PUBLIC_URL + "/"} className="logo-link">
              <img
                className="logo-light logo-img logo-img-lg"
                src={Logo}
                alt="logo"
              />
              <img
                className="logo-dark logo-img logo-img-lg"
                src={LogoDark}
                alt="logo-dark"
              />
            </Link>
          </div>
          <PreviewCard className="card-bordered" bodyClass="card-inner-lg">
            <BlockHead>
              <BlockContent>
                <BlockTitle tag="h5">Insert new password</BlockTitle>
                <BlockDes>
                  <p>
                    Please insert your new password. Make sure it contains
                    number, symbol, uppercase and lowercase letter. At least 8
                    or more characters
                  </p>
                </BlockDes>
              </BlockContent>
            </BlockHead>
            <form onSubmit={ResetPassword}>
              <FormGroup>
                <div className="form-label-group">
                  <label className="form-label" htmlFor="default-01">
                    New Password
                  </label>
                </div>
                <div className="form-control-wrap">
                  <a
                    href="#password"
                    onClick={(ev) => {
                      ev.preventDefault();
                      setPassState(!passState);
                    }}
                    className={`form-icon lg form-icon-right passcode-switch ${
                      passState ? "is-hidden" : "is-shown"
                    }`}
                  >
                    <Icon name="eye" className="passcode-icon icon-show"></Icon>

                    <Icon
                      name="eye-off"
                      className="passcode-icon icon-hide"
                    ></Icon>
                  </a>
                  <input
                    type={passState ? "text" : "password"}
                    id="password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="Enter your new password"
                    className={`form-control-lg form-control ${
                      passState ? "is-hidden" : "is-shown"
                    }`}
                    required
                    pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*+`~'=?\|\]\[\(\)\-<>/]).{8,}"
                    title="Requires number, symbol, uppercase and lowercase letter. At least 8 or more characters"
                  />
                </div>
              </FormGroup>
              <FormGroup>
                <Button
                  type="submit"
                  color="primary"
                  size="lg"
                  className="btn-block"
                  onClick={() => {
                    ResetPassword();
                  }}
                >
                  {loading ? (
                    <Spinner size="sm" color="light" />
                  ) : (
                    "Confirm New Password"
                  )}
                </Button>
              </FormGroup>
            </form>
          </PreviewCard>
        </Block>
        <AuthFooter />
      </PageContainer>
    </React.Fragment>
  );
};
export default ResetPassword;
