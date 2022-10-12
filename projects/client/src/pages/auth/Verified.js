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
import { Link, useParams } from "react-router-dom";
import { useDispatch, useSelector } from "react-redux";
import { useEffect } from "react";
import { verifyUser } from "../../redux/actions/users";

const Verified = () => {
  const dispatch = useDispatch();
  const { uuid } = useParams();

  useEffect(() => {
    dispatch(verifyUser(uuid));
  }, []);

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
              <BlockTitle tag="h3">Your Account is Verified!</BlockTitle>
              <BlockDes className="">
                <p>Now you can login to your Ramu account</p>
                <div className="form-note-s2">
                  <Link to={`${process.env.PUBLIC_URL}/auth-login`}>
                    <strong>Click here for log in</strong>
                  </Link>
                </div>
              </BlockDes>
            </BlockContent>
          </BlockHead>
        </Block>
        <AuthFooter />
      </PageContainer>
    </React.Fragment>
  );
};
export default Verified;
