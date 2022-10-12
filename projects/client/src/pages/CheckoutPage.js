import React, { useState, useEffect } from "react";
import Head from "../layout/head/Head";
import Content from "../layout/content/Content";
import {
  Block,
  BlockHead,
  BlockTitle,
  BlockBetween,
  BlockHeadContent,
  Icon,
  Button,
  DataTableHead,
  DataTableBody,
  DataTableRow,
  DataTableItem,
  PaginationComponent,
  Row,
  Col,
} from "../components/Component";
import {
  Card,
  DropdownItem,
  UncontrolledDropdown,
  DropdownMenu,
  DropdownToggle,
  Badge,
  Dropdown,
  Input,
} from "reactstrap";
import ProductH from "../images/product/h.png";
import { Modal, ModalBody } from "reactstrap";
import axios from "axios";
import { API_URL } from "../constants/API";
import { useParams } from "react-router";

const CheckoutPage = () => {
  const user = JSON.parse(window.localStorage.getItem("profile"));
  const userAddress = JSON.parse(window.localStorage.getItem("address"));

  const [cartData, setCartData] = useState([]);
  const [data, setData] = useState(cartData);
  const [sm, updateSm] = useState(false);
  const [onSearchText, setSearchText] = useState("");
  const [categories, setCategories] = useState([]);
  const [sortBy, setSortBy] = useState({ name: true, asc: true });
  const [open, setOpen] = useState(false);
  const [shipment, setShipment] = useState(0);
  const [formData, setFormData] = useState({
    name: "",
    img: null,
    sku: "",
    price: 0,
    stock: 0,
    category: [],
    fav: false,
    check: false,
  });
  const [editId, setEditedId] = useState();
  const [view, setView] = useState({
    edit: false,
    add: false,
    details: false,
    deleted: false,
    proceedTransaction: false,
    courier: false,
    noAddress: false,
  });

  const [currentPage, setCurrentPage] = useState(1);
  const [itemPerPage] = useState(7);
  const [files, setFiles] = useState([]);

  const toggle = () => setOpen((prevState) => !prevState);

  // GET CATEGORIES
  const getCategories = async () => {
    try {
      const response = await axios.get(`${API_URL}/products/getCategories`);
      setCategories(response.data);
    } catch (error) {
      console.log(error);
    }
  };

  // GET CART DATA
  const getCart = async (page) => {
    try {
      const response = await axios.get(`${API_URL}/cart/cart-item/${user.id}`, {
        name: onSearchText,
        sortBy,
        page,
        perPage: itemPerPage,
      });

      const tempCart = [];

      for (let item of response.data) {
        tempCart.push({
          id: item.product.id,
          name: item.product.name,
          image: item.product.image,
          price: item.product.price,
          qty: item.qty,
          category: item.product.category.category,
          unit: item.product.unit,
        });
        // console.log(tempCart);
      }

      setCartData(tempCart.reverse());
    } catch (error) {
      console.log(error);
    }
  };

  useEffect(() => {
    getCart(user.id);
    getCategories();
    totalPrice();
  }, [onSearchText, sortBy]);

  // Changing state value when searching name
  useEffect(() => {
    if (onSearchText !== "") {
      const filteredObject = cartData.filter((item) => {
        return item.name.toLowerCase().includes(onSearchText.toLowerCase());
      });
      setCartData([...filteredObject]);
      console.log(filteredObject);
    } else {
      setCartData([...cartData]);
    }
  }, [onSearchText]);

  // CLOSING MODAL
  const onCloseModal = () => {
    setView({ deleted: false });
    setView({ proceedTransaction: false });
    setView({ noAddress: false });
  };

  // GET TOTAL PRICE
  const totalPrice = () => {
    let pricesArr = cartData.map(({ price }) => price);
    let qtyArr = cartData.map(({ qty }) => qty);

    let priceTotal = 0;
    for (let i = 0; i < pricesArr.length; i++) {
      priceTotal += pricesArr[i] * qtyArr[i];
    }

    return priceTotal;
  };

  // CONVERT PRICE TO CURRENCY TYPE
  const toCurrency = (data) => {
    const locale = new Intl.NumberFormat("id-ID", {
      style: "currency",
      currency: "IDR",
      maximumSignificantDigits: 8,
    });
    return locale.format(data);
  };

  // GET IMAGE URL
  const getImageUrl = (image) => {
    return `${API_URL}/products/${image}`;
  };

  // CHECKOUT CART
  const proceedTransaction = async () => {
    try {
      setView({ proceedTransaction: true });
      if (userAddress[0].name === "") {
        setView({ noAddress: true });
      }
    } catch (error) {
      console.log(error);
    }
  };

  // ADD INVOICE HEADER
  const invoice = async () => {
    const dateTime = new Date().toString();
    const invDate = dateTime.slice(4, 15).replace(/ /g, "").toUpperCase();
    const invTime = dateTime.slice(16, 24).replace(/:/g, "");
    try {
      const response = await axios.post(
        `${API_URL}/invoices/addInvoiceHeaders`,
        {
          invoice_id: `INV-${invTime}${user.id}`,
          user_id: user.id,
          grand_total: totalPrice() + shipment,
          address_id: userAddress[0].id,
        }
      );

      await cartData.map((item) => {
        axios.post(`${API_URL}/invoices/addInvoiceDetail`, {
          invoice_id: response.data.invoice_id,
          product_id: item.id,
          price: item.price,
          qty: item.qty,
        });
      });

      axios.post(`${API_URL}/invoices/sendNotif`, {
        invoice_id: response.data.invoice_id,
      });

      window.location.replace(`/user/transaction-list/${user.id}`);
    } catch (error) {
      console.log(error);
    }
  };

  const emptyCart = async () => {
    try {
      axios.post(`${API_URL}/cart/check-out-cart`, {
        user_id: user.id,
      });
    } catch (error) {
      console.log(error);
    }
  };

  // Get current list, pagination
  const indexOfLastItem = currentPage * itemPerPage;
  const indexOfFirstItem = indexOfLastItem - itemPerPage;
  const currentItems = cartData.slice(indexOfFirstItem, indexOfLastItem);

  // Change Page
  const paginate = (pageNumber) => {
    setCurrentPage(pageNumber);
    getCart(pageNumber);
  };

  return (
    <React.Fragment>
      <Head title="Checkout"></Head>
      <Content>
        <BlockHead size="sm">
          <BlockBetween>
            <BlockHeadContent>
              <BlockTitle>Checkout</BlockTitle>
              <div style={{ fontWeight: "bold", fontSize: "larger" }}>
                Shipment Address
              </div>
              <hr style={{ marginTop: "0" }}></hr>
              <div style={{ display: "flex" }}>
                <b>
                  {user.first_name} {user.last_name}
                </b>
                <div style={{ marginLeft: "3px" }}>
                  {" "}
                  ({userAddress[0].name})
                </div>
              </div>

              <div>{user.phone}</div>
              <div>{userAddress[0].address}</div>
              {/* <hr></hr>
              <Button
                className="toggle d-none d-md-inline-flex btn-sm"
                color="primary"
              >
                Change Address
              </Button> */}
            </BlockHeadContent>

            {/* RIGHT SIDE */}
            <BlockHeadContent>
              <div
                // style={{ marginTop: "60px" }}
                className="toggle-wrap nk-block-tools-toggle"
              >
                <div
                  className="toggle-expand-content"
                  style={{ display: sm ? "block" : "none" }}
                >
                  <ul className="nk-block-tools g-3">
                    <li>
                      <Dropdown
                        isOpen={userAddress ? open : !open}
                        toggle={toggle}
                        // style={{ color: "white" }}
                        color="primary"
                      >
                        <DropdownToggle
                          className="dropdown-toggle"
                          onClick={(ev) => {
                            ev.preventDefault();
                          }}
                        >
                          <div className="user-info  d-md-block">
                            <span
                              style={{ color: "white" }}
                              className="user-name dropdown-indicator"
                            >
                              Shipment
                            </span>
                          </div>
                        </DropdownToggle>
                        <DropdownMenu
                          right
                          className="dropdown-menu-md dropdown-menu-s1"
                          color="primary"
                        >
                          <div className="dropdown-inner">
                            <br></br>
                            <div
                              style={{ cursor: "pointer" }}
                              onClick={() => {
                                setShipment(20000);
                                toggle();
                              }}
                            >
                              <span className=" user-card sm sub-text">
                                {`JEN Regular (2-3 Days)`}
                              </span>
                              <div>Rp. 20.000</div>
                            </div>
                            <hr></hr>
                            <div
                              style={{ cursor: "pointer" }}
                              onClick={() => {
                                setShipment(26000);
                                toggle();
                              }}
                            >
                              <span className=" user-card sm sub-text">
                                {`SiLaju Regular (1-2 Days)`}
                              </span>
                              <div>Rp. 26.000</div>
                            </div>
                            <hr></hr>
                            <div
                              style={{ cursor: "pointer" }}
                              onClick={() => {
                                setShipment(19500);
                                toggle();
                              }}
                            >
                              <span className=" user-card sm sub-text">
                                {`Kirimaja Regular (3-4 Days)`}
                              </span>
                              <div>Rp. 19.500</div>
                            </div>
                            <br></br>
                          </div>
                        </DropdownMenu>
                      </Dropdown>
                    </li>
                    <li className="nk-block-tools-opt">
                      <Button
                        className="toggle d-none d-md-inline-flex"
                        color="primary"
                        onClick={() => proceedTransaction()}
                      >
                        <span>Proceed</span>
                      </Button>
                    </li>
                  </ul>
                  <div
                    style={{
                      fontWeight: "normal",
                      textAlign: "left",
                      paddingTop: "10px",
                    }}
                  >
                    <div style={{ display: "flex", alignItems: "center" }}>
                      Total Price:{" "}
                      <div style={{ fontWeight: "normal", marginLeft: "5px" }}>
                        {" "}
                        {toCurrency(totalPrice())} ({cartData.length} products)
                      </div>
                    </div>
                  </div>
                  <div
                    style={{
                      fontWeight: "normal",
                      textAlign: "left",
                    }}
                  >
                    <div style={{ display: "flex", alignItems: "center" }}>
                      Shipment:{" "}
                      <div style={{ fontWeight: "normal", marginLeft: "5px" }}>
                        {" "}
                        {toCurrency(shipment)}
                      </div>
                    </div>
                  </div>
                  {/* <div style={{ fontWeight: "normal", textAlign: "left" }}>
                    <div style={{ display: "flex", alignItems: "center" }}>
                      Total item:{" "}
                      <div style={{ fontWeight: "normal", marginLeft: "5px" }}>
                        {" "}
                        {cartData.length} items
                      </div>
                    </div>
                  </div> */}
                  <div
                    style={{
                      fontWeight: "normal",
                      textAlign: "left",
                      marginTop: "5px",
                    }}
                  >
                    <div style={{ display: "flex", alignItems: "center" }}>
                      Grand Total:{" "}
                      <div
                        style={{
                          fontSize: "large",
                          fontWeight: "bold",
                          marginLeft: "5px",
                          color: "#293822",
                        }}
                      >
                        {" "}
                        {toCurrency(totalPrice() + shipment)}
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </BlockHeadContent>
          </BlockBetween>
        </BlockHead>
        <Block>
          <Card>
            <div className="card-inner-group">
              <div className="card-inner p-0">
                <DataTableBody>
                  <DataTableHead>
                    <DataTableRow size="sm">
                      <span>Name</span>
                    </DataTableRow>
                    <DataTableRow>
                      <span>Price/unit</span>
                    </DataTableRow>
                    <DataTableRow>
                      <span>Quantity</span>
                    </DataTableRow>
                    <DataTableRow>
                      <span>Sub Total</span>
                    </DataTableRow>
                    <DataTableRow>
                      <span>Unit</span>
                    </DataTableRow>
                    <DataTableRow size="md">
                      <span>Category</span>
                    </DataTableRow>
                  </DataTableHead>
                  {currentItems.length > 0
                    ? currentItems.map((item) => {
                        // console.log(item);
                        return (
                          <DataTableItem key={item.id}>
                            <DataTableRow size="sm">
                              <span className="tb-product">
                                <img
                                  src={
                                    item.image
                                      ? getImageUrl(item.image)
                                      : ProductH
                                  }
                                  alt="product"
                                  className="thumb"
                                />
                                <span className="title">{item.name}</span>
                              </span>
                            </DataTableRow>
                            {/* <DataTableRow>
                              <span className="tb-sub">{item.sku}</span>
                            </DataTableRow> */}
                            <DataTableRow>
                              <span className="tb-sub">
                                {toCurrency(item.price)}
                              </span>
                            </DataTableRow>
                            <DataTableRow>
                              <div style={{ textAlign: "left" }}>
                                {item.qty}
                              </div>
                            </DataTableRow>
                            <DataTableRow>
                              <span className="tb-sub">
                                {toCurrency(item.price * item.qty)}
                              </span>
                            </DataTableRow>
                            <DataTableRow size="md">
                              <span className="tb-sub">{item.unit}</span>
                            </DataTableRow>
                            <DataTableRow size="md">
                              <span className="tb-sub">{item.category}</span>
                            </DataTableRow>
                          </DataTableItem>
                        );
                      })
                    : null}
                </DataTableBody>

                <div className="card-inner">
                  {currentItems.length > 0 ? (
                    <PaginationComponent
                      itemPerPage={itemPerPage}
                      totalItems={cartData.length}
                      paginate={paginate}
                      currentPage={currentPage}
                    />
                  ) : (
                    <div className="text-center">
                      <span className="text-silent">No products found</span>
                    </div>
                  )}
                </div>
              </div>
            </div>
          </Card>
        </Block>

        <Modal
          isOpen={view.proceedTransaction}
          toggle={() => onCloseModal()}
          className="modal-dialog-centered"
          size="sm"
        >
          <ModalBody>
            <div className="nk-modal-head">
              {shipment > 0 ? (
                <div>
                  <a href="#cancel" className="close">
                    {" "}
                    <Icon
                      name="cross-sm"
                      onClick={(ev) => {
                        ev.preventDefault();
                        onCloseModal();
                      }}
                    ></Icon>
                  </a>
                  <div className="nk-modal-head">
                    <h4 className="nk-modal-title title">
                      {/* Payment Method */}
                      Proceed Transaction
                      <small className="text-primary">
                        {" "}
                        {/* #{item.invoice_id} */}
                      </small>
                    </h4>
                  </div>
                  <div className="nk-tnx-details mt-md-2">
                    <Col>
                      <div className="text-smaller text-black">
                        Make sure all information are correct
                      </div>
                    </Col>
                    <div className="text-center mt-3">
                      <Button
                        className="toggle d-none d-md-inline"
                        color="primary"
                        onClick={() => {
                          invoice();
                          emptyCart();
                        }}
                      >
                        Confirm Transaction
                      </Button>
                    </div>
                  </div>
                </div>
              ) : (
                <div>
                  <h4 className="center text-danger">
                    <b>Yikes!</b>
                  </h4>
                  <b className="caption-text center">
                    Please select shipment service
                  </b>
                </div>
              )}
            </div>
          </ModalBody>
        </Modal>
        {userAddress[0].name === "" ? (
          <Modal
            isOpen={view.noAddress}
            toggle={() => onCloseModal()}
            className="modal-dialog-centered"
            size="sm"
          >
            <ModalBody>
              <div>
                <h4 className="center text-danger">
                  <b>Oops!</b>
                </h4>
                <b
                  style={{ textAlign: "center" }}
                  className="caption-text center"
                >
                  There's no main address yet.
                  <br></br>
                  You can set it on profile settings
                </b>
              </div>
            </ModalBody>
          </Modal>
        ) : null}
      </Content>
    </React.Fragment>
  );
};

export default CheckoutPage;
