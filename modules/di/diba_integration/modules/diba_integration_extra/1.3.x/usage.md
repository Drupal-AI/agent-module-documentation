Diba integration extra is a dependency-only submodule that bundles legacy DiBa add-on modules (DiBa Carousel, Responsive Wrappers) which are not yet available for Drupal 11.

---

The submodule (`diba_integration_extra`) contains no PHP, routes, services or configuration — only an `info.yml` that declares dependencies on `diba_carousel` and `responsivewrappers`. Its purpose is to enable those legacy add-ons in one step on DiBa sites that still run Drupal 10. It is pinned to `core_version_requirement: ^10.3`, so unlike the rest of the project it cannot be installed on Drupal 11 or 12; it is intentionally left behind until its dependencies gain D11 support.

---

- Enable the DiBa legacy add-on stack (carousel, responsive wrappers) in a single step on a Drupal 10 site.
- Keep D10-only helper modules grouped so they are easy to identify and remove during a Drupal 11 upgrade.
- Provide the carousel/slider building block used on DiBa content pages (via diba_carousel).
- Add Bootstrap-style responsive wrapper utilities to content (via responsivewrappers).
- Document, for upgrade planning, which pieces of the DiBa platform are not yet Drupal 11 ready.
