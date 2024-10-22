import { apiInitializer } from 'discourse/lib/api'
import Derek from '../components/derek'
import HomeHeader from '../components/home-header'

export default apiInitializer('1.14.0', api => {
  // api.renderInOutlet('top-notices', Derek)
  api.renderInOutlet('above-site-header', HomeHeader)
})