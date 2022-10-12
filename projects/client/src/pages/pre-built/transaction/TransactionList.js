import React, { useState, useEffect } from "react";
import Head from "../../../layout/head/Head";
import FormData from "form-data";
import Content from "../../../layout/content/Content";
import {
  Block,
  BlockHead,
  BlockTitle,
  BlockBetween,
  BlockHeadContent,
  Icon,
  Row,
  Col,
  Button,
  DataTableHead,
  DataTableBody,
  DataTableRow,
  DataTableItem,
  PaginationComponent,
} from "../../../components/Component";
import {
  Card,
  DropdownItem,
  UncontrolledDropdown,
  DropdownMenu,
  DropdownToggle,
  Badge,
  Input,
  FormGroup,
  Form,
} from "reactstrap";
import axios from "axios";
import { API_URL } from "../../../constants/API";
import { Modal, ModalBody } from "reactstrap";

const TransactionList = () => {
  const user = JSON.parse(window.localStorage.getItem("profile"));
  const userAddress = JSON.parse(window.localStorage.getItem("address"));
  const [payment, setPayment] = useState({
    invoice_id: null,
    bank: "",
    account_name: "",
    amount: null,
  });
  const [image, setImage] = useState("");
  const [paymentData, setPaymentData] = useState("");
  const [view, setView] = useState({
    edit: false,
    add: false,
    details: false,
    payment: false,
  });
  const [onSearchText, setSearchText] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const [itemPerPage] = useState(7);
  const [invoices, setInvoices] = useState([]);
  const [asc, setAsc] = useState(false);
  const [dateRange, setDateRange] = useState(["", null]);
  const [startDate, endDate] = dateRange;
  const [totalInvoices, setTotalInvoices] = useState(0);
  const [errMsg, setErrMsg] = useState("");
  const [invoiceDetails, setInvoiceDetails] = useState("");

  // GET ALL INVOICE DATA
  const getInvoices = async (page) => {
    try {
      const response = await axios.post(
        `${API_URL}/invoices/getInvoicesByUserId`,
        {
          page,
          perPage: itemPerPage,
          invoice_id: onSearchText,
          user_id: user.id,
          asc,
          startDate,
          endDate,
        }
      );

      const tempInvoiceDetails = response.data.invoices.map(
        ({ invoice_details }) => invoice_details
      );

      setInvoices(response.data.invoices);
      setInvoiceDetails(tempInvoiceDetails);
      setTotalInvoices(response.data.count);

      // console.log(paymentData);
    } catch (error) {
      console.log(error);
    }
  };

  // CONVERT PRICE TO CURRENCY TYPE
  const toCurrency = (data) => {
    const locale = new Intl.NumberFormat("id-ID", {
      style: "currency",
      currency: "IDR",
      maximumSignificantDigits: 9,
    });
    return locale.format(data);
  };

  // GET IMAGE URL
  const getImageUrl = (image) => {
    return `${API_URL}/products/${image}`;
  };

  useEffect(() => {
    getInvoices(1);
    getPayment();
  }, [itemPerPage, asc, startDate, endDate]);

  // OnChange function to get the input data
  const onInputChange = (e) => {
    setPayment({ ...payment, [e.target.name]: e.target.value });
  };

  const onInputImage = (e) => {
    setImage(e.target.files[0]);
  };

  // SUBMIT PAYMENT
  const submitPayment = async () => {
    try {
      if (!payment.bank) return setErrMsg("Please choose your bank");
      if (!payment.account_name)
        return setErrMsg("Please insert your account name");
      if (!payment.amount) return setErrMsg("Please insert amount");
      if (!image) return setErrMsg("Receipt image is required");

      let form = new FormData();
      form.append("image", image);
      for (let key in payment) {
        form.append(key, payment[key]);
      }
      console.log(form);

      await axios.post(`${API_URL}/payment/add-payment-receipt`, form);
      setView({ payment: false });
    } catch (error) {
      console.log(error);
    }
  };

  // GET PAYMENT
  const getPayment = async () => {
    try {
      const response = await axios.get(`${API_URL}/payment/get-payment`);

      const tempPaymentData = response.data.response.map(
        ({ invoice_id }) => invoice_id
      );

      setPaymentData(tempPaymentData);
    } catch (error) {
      console.log(error);
    }
  };

  // function to close the form modal
  const onFormCancel = () => {
    setView({ details: false, payment: false });
  };

  // CONFIRM PAYMENT
  const confirmPayment = async () => {
    try {
      setView({ payment: true });
    } catch (error) {
      console.log(error);
    }
  };

  // toggle function to view product details
  const toggle = (type) => {
    setView({
      edit: type === "edit" ? true : false,
      add: type === "add" ? true : false,
      details: type === "details" ? true : false,
    });
  };

  // Get current list, pagination
  const indexOfLastItem = currentPage * itemPerPage;
  const indexOfFirstItem = indexOfLastItem - itemPerPage;
  const currentItems = invoices.slice(indexOfFirstItem, indexOfLastItem);

  return (
    <React.Fragment>
      <Head title="Transaction List"></Head>
      <Content>
        <BlockHead size="sm">
          <BlockBetween>
            <BlockHeadContent>
              <BlockTitle>Transactions</BlockTitle>
            </BlockHeadContent>
          </BlockBetween>
        </BlockHead>
        <Block>
          <Card>
            <div className="card-inner-group">
              <div className="card-inner p-0">
                <DataTableBody>
                  <DataTableHead>
                    <DataTableRow>
                      <span>ID</span>
                    </DataTableRow>
                    <DataTableRow size="sm">
                      <span>Products</span>
                    </DataTableRow>
                    <DataTableRow>
                      <span>Total Price</span>
                    </DataTableRow>
                    <DataTableRow>
                      <span>Payment</span>
                    </DataTableRow>
                    <DataTableRow size="md">
                      <span>Address</span>
                    </DataTableRow>
                    <DataTableRow size="md">
                      <span>Status</span>
                    </DataTableRow>
                    <DataTableRow className="nk-tb-col-tools"></DataTableRow>
                  </DataTableHead>
                  {invoices.length > 0 ? (
                    invoices.map((item) => {
                      return (
                        <DataTableItem key={item.id}>
                          <DataTableRow>
                            <b className="tb-sub">{item.invoice_id}</b>
                          </DataTableRow>
                          <DataTableRow size="sm">
                            <span className="tb-product">
                              <img
                                src={getImageUrl(
                                  item.invoice_details[0].product.image
                                )}
                                alt="product"
                                className="thumb"
                              />
                              {item.invoice_details.length > 0 ? (
                                <span className="title">
                                  {item.invoice_details[0].product.name}{" "}
                                  <i
                                    style={{
                                      fontSize: "75%",
                                      fontWeight: "lighter",
                                    }}
                                  >
                                    +{item.invoice_details.length - 1}{" "}
                                    {item.invoice_details.length - 1 === 1
                                      ? "product"
                                      : "products"}
                                  </i>
                                </span>
                              ) : (
                                `${item.invoice_details[0].product.name}`
                              )}
                            </span>
                          </DataTableRow>

                          <DataTableRow>
                            <span className="tb-sub">
                              {toCurrency(item.grand_total)}
                            </span>
                          </DataTableRow>
                          <DataTableRow>
                            {paymentData.includes(item.invoice_id) ? (
                              <Button
                                disabled
                                color="primary"
                                size="sm"
                                className="btn btn-dim"
                              >
                                Receipt Submitted
                              </Button>
                            ) : (
                              <Button
                                onClick={() => {
                                  confirmPayment();
                                  setPayment({ invoice_id: item.invoice_id });
                                }}
                                color="primary"
                                size="sm"
                                className="btn btn-dim"
                              >
                                Confirm Payment
                              </Button>
                            )}
                          </DataTableRow>
                          <DataTableRow size="md">
                            <span className="tb-sub">
                              {userAddress[0].name}
                            </span>
                          </DataTableRow>
                          <DataTableRow size="md">
                            <span className="tb-odr-status">
                              <Badge
                                color={
                                  item.status === "Completed"
                                    ? "success"
                                    : item.status === "Paid"
                                    ? "success"
                                    : item.status === "Waiting for payment"
                                    ? "warning"
                                    : item.status === "Processing Order"
                                    ? "primary"
                                    : "danger"
                                }
                                className="badge-dot"
                              >
                                {item.status}
                              </Badge>
                            </span>
                          </DataTableRow>
                          <DataTableRow className="nk-tb-col-tools">
                            <ul className="nk-tb-actions gx-1 my-n1">
                              <li className="mr-n1">
                                <UncontrolledDropdown>
                                  <DropdownToggle
                                    tag="a"
                                    href="#more"
                                    onClick={(ev) => ev.preventDefault()}
                                    className="dropdown-toggle btn btn-icon btn-trigger"
                                  >
                                    <Icon name="more-h"></Icon>
                                  </DropdownToggle>
                                  <DropdownMenu right>
                                    <ul className="link-list-opt no-bdr">
                                      <li>
                                        <DropdownItem
                                          tag="a"
                                          href="#view"
                                          onClick={(ev) => {
                                            ev.preventDefault();

                                            toggle("details");
                                          }}
                                        >
                                          <Icon name="eye"></Icon>
                                          <span>View Transaction</span>
                                        </DropdownItem>
                                      </li>
                                    </ul>
                                  </DropdownMenu>
                                </UncontrolledDropdown>
                              </li>
                            </ul>
                          </DataTableRow>
                        </DataTableItem>
                      );
                    })
                  ) : (
                    <div className="card-inner">
                      <div className="text-left">
                        <span className="text-silent">No transaction yet</span>
                      </div>
                    </div>
                  )}
                </DataTableBody>
              </div>
            </div>
          </Card>
        </Block>

        <Modal
          isOpen={view.details}
          toggle={() => onFormCancel()}
          className="modal-dialog-centered"
          size="lg"
        >
          <ModalBody>
            <a href="#cancel" className="close">
              {" "}
              <Icon
                name="cross-sm"
                onClick={(ev) => {
                  ev.preventDefault();
                  onFormCancel();
                }}
              ></Icon>
            </a>
            <div className="nk-modal-head">
              <h4 className="nk-modal-title title">
                Transaction <small className="text-primary">{}</small>
              </h4>
            </div>
            {invoiceDetails.length > 0 ? (
              invoiceDetails.map((item) => {
                return (
                  <div key={item.id} className="nk-tnx-details mt-sm-3">
                    <Row className="gy-3">
                      <Col lg={6}>
                        <span>{item.invoice_id}</span>
                        <span className="sub-text">Product Name</span>
                        <span className="caption-text">
                          {item[0].product.name}
                        </span>
                      </Col>
                      <Col lg={6}>
                        <span className="sub-text">Product Price</span>
                        <span className="caption-text">
                          {toCurrency(item[0].price)}
                        </span>
                      </Col>
                      <Col lg={6}>
                        <span className="sub-text">Quantity</span>
                        <span className="caption-text">{item[0].qty}</span>
                      </Col>
                    </Row>
                    <hr></hr>
                  </div>
                );
              })
            ) : (
              <div className="card-inner">
                <div className="text-center">
                  <span className="text-silent">No transaction yet</span>
                </div>
              </div>
            )}
          </ModalBody>
        </Modal>

        <Modal
          isOpen={view.payment}
          toggle={() => onFormCancel()}
          className="modal-dialog-centered"
          size="sm"
        >
          <ModalBody>
            <div className="nk-modal-head">
              <div>
                <a href="#cancel" className="close">
                  {" "}
                  <Icon
                    name="cross-sm"
                    onClick={(ev) => {
                      ev.preventDefault();
                      onFormCancel();
                      setErrMsg("");
                    }}
                  ></Icon>
                </a>
                <div className="nk-modal-head">
                  <h4 className="nk-modal-title title">
                    Confirm Payment
                    <small className="text-primary"> </small>
                  </h4>
                </div>
                <div className="nk-tnx-details mt-md-2">
                  <Col>
                    <div>
                      <ul>
                        <li
                          style={{
                            display: "flex",
                            justifyContent: "space-between",
                          }}
                          className="py-1"
                        >
                          <span>Bank</span>
                          <span>
                            <Form encType="multipart/form-data">
                              <FormGroup>
                                <Input
                                  onChange={(e) => onInputChange(e)}
                                  type="select"
                                  name="bank"
                                  required
                                  // title={errMsg.bank}
                                >
                                  <option id="bri" value="BNI">
                                    Bank BRI
                                  </option>
                                  <option id="bca" value="BCA">
                                    Bank BCA
                                  </option>
                                  <option id="mandiri" value="MANDIRI">
                                    Bank Mandiri
                                  </option>
                                  <option id="bni" value="BNI">
                                    Bank BNI
                                  </option>
                                  <option id="cimb" value="CIMB">
                                    Bank CIMB
                                  </option>
                                  <option id="btn" value="BTN">
                                    Bank BTN
                                  </option>
                                </Input>
                              </FormGroup>
                            </Form>
                          </span>
                        </li>
                        <li
                          style={{
                            display: "flex",
                            justifyContent: "space-between",
                          }}
                          className="py-1"
                        >
                          <span>Account Name</span>
                          <span>
                            <Form encType="multipart/form-data">
                              <FormGroup>
                                <Input
                                  pattern="[A-Za-z]"
                                  style={{ width: "131px" }}
                                  name="account_name"
                                  onChange={(e) => {
                                    onInputChange(e);
                                  }}
                                  required
                                ></Input>
                              </FormGroup>
                            </Form>
                          </span>
                        </li>
                        <li
                          className="py-1"
                          style={{
                            display: "flex",
                            justifyContent: "space-between",
                          }}
                        >
                          <span>Amount</span>
                          <span>
                            <Form encType="multipart/form-data">
                              <FormGroup>
                                <Input
                                  type="number"
                                  style={{ width: "131px" }}
                                  placeholder="ex: 2000000"
                                  name="amount"
                                  onKeyPress={(event) => {
                                    if (!/[0-9]/.test(event.key)) {
                                      event.preventDefault();
                                    }
                                  }}
                                  onChange={(e) => {
                                    onInputChange(e);
                                  }}
                                  required
                                ></Input>
                              </FormGroup>
                            </Form>
                          </span>
                        </li>
                        <li
                          style={{
                            display: "flex",
                            justifyContent: "space-between",
                          }}
                          className="py-1"
                        >
                          <span>Upload Receipt</span>
                          <span>
                            <Form encType="multipart/form-data">
                              <FormGroup>
                                <input
                                  type="file"
                                  id="img"
                                  name="image"
                                  accept="image/*"
                                  style={{
                                    width: "131px",
                                    textDecoration: "underline",
                                    fontStyle: "italic",
                                    cursor: "pointer",
                                  }}
                                  onChange={(e) => {
                                    onInputImage(e);
                                  }}
                                  required
                                  // title={errMsg.image}
                                ></input>
                              </FormGroup>
                            </Form>
                          </span>
                        </li>
                      </ul>
                    </div>
                  </Col>
                  {errMsg === "" ? (
                    <div className="text-white text-center font-italic">.</div>
                  ) : (
                    <div className="text-danger text-center font-italic">
                      {errMsg}
                    </div>
                  )}
                  <div className="text-center mt-3">
                    <Button
                      className="toggle d-none d-md-inline"
                      color="primary"
                      onClick={() => submitPayment()}
                    >
                      Submit
                    </Button>
                  </div>
                </div>
              </div>
            </div>
          </ModalBody>
        </Modal>

        {view.add && <div className="toggle-overlay" onClick={toggle}></div>}
      </Content>
    </React.Fragment>
  );
};

export default TransactionList;
