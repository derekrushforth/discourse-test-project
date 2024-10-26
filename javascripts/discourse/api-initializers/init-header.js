import { apiInitializer } from "discourse/lib/api";
import Header from "../components/header";

export default apiInitializer("1.14.0", (api) => {
  api.renderInOutlet("above-site-header", Header);
});
