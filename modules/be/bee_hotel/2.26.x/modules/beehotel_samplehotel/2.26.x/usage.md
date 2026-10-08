Bee Hotel Sample Hotel builds a complete working demo hotel (content, BAT units, Commerce products) in one step for evaluation or training.

---

Enable this submodule and its hook_install runs SampleHotelInstall->install(), which delegates to SampleHotelInstallDrupal, SampleHotelInstallBat and SampleHotelInstallCommerce to create everything a working Bee Hotel property needs: unit nodes, BAT units and availability events, and Commerce products/variations/stores. hook_uninstall calls the corresponding teardown. It is meant for demos, evaluation and learning the moving parts, not for production data. Depends on bee_hotel; also attaches a helper library on the vertical calendar page.

---

- Spin up a complete demo hotel with one module enable.
- Create sample unit nodes ready to book.
- Provision BAT units and availability events for the demo.
- Create Commerce products, variations and a store for the units.
- Tear the sample data down again on uninstall.
- Learn how Bee Hotel wires Drupal, BAT and Commerce together.
- Give evaluators a working booking flow immediately.
- Provide a training sandbox for staff.
