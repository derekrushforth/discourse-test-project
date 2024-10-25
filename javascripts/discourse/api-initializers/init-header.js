import { apiInitializer } from "discourse/lib/api";
import CustomHeader from "../components/custom-header";

export default apiInitializer("1.14.0", (api) => {
  api.renderInOutlet("above-site-header", CustomHeader);
});
