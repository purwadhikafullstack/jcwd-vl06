import React from "react";
import {
  Block,
  BlockContent,
  BlockDes,
  BlockHead,
  BlockTitle,
} from "../../components/Component";
import Logo from "../../images/logo.png";
import LogoDark from "../../images/logo-dark.png";
import PageContainer from "../../layout/page-container/PageContainer";
import Head from "../../layout/head/Head";
import AuthFooter from "./AuthFooter";
import { Link } from "react-router-dom";

const SuccessSendLink = () => {
  return (
    <React.Fragment>
      <Head title="Success" />
      <PageContainer>
        <Block className="nk-block-middle nk-auth-body">
          <div className="brand-logo pb-5">
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
          <BlockHead>
            <BlockContent>
              <BlockTitle tag="h4">Link Sent!</BlockTitle>
              <BlockDes className="">
                <p>Please check your e-mail for your reset password link</p>
              </BlockDes>
            </BlockContent>
          </BlockHead>
          <div className="form-note-s2">
            <Link to={`${process.env.PUBLIC_URL}/`}>
              <strong>Back to Home</strong>
            </Link>
          </div>
        </Block>
        <AuthFooter />
      </PageContainer>
    </React.Fragment>
  );
};
export default SuccessSendLink;
