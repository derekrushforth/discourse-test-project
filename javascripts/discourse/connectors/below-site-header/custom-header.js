export default {
  setupComponent(args, component) {
    component.setProperties({
      didInsertElement() {
        this._super(...arguments)

        console.log('custom-header')
      },
    })
  },
}