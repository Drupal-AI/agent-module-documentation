Chosen Library is the helper submodule of Chosen that declares the Chosen JavaScript/CSS library and provides a Drush command to download the third-party assets.

---

Chosen Library (`chosen_lib`) exists so the main Chosen module (and integrations such as Better Exposed Filters) can depend on a single canonical library definition rather than each declaring its own. It registers the `chosen` and `chosen.css` asset libraries pointing at the Chosen 3.1.3 (`noli42/chosen`) files, wherever they are installed under `libraries/`. Because the Chosen JS is a third-party library that is not always shipped with the module, `chosen_lib` adds a Drush command, `chosen:plugin`, that downloads and extracts the library to the correct location. It has no configuration UI and no dependencies on other contrib modules; it is enabled automatically as a dependency of Chosen. Site builders rarely interact with it directly beyond running the download command during setup or deployment.

---

- Provide the canonical Chosen JS/CSS library definition for other modules to depend on.
- Download the Chosen library to `libraries/` with `drush chosen:plugin`.
- Install the Chosen assets on a headless/CI server without manual file copying.
- Pin the Chosen library version (3.1.3) used across a site.
- Let Better Exposed Filters reuse the same Chosen library.
- Keep the third-party JS out of the module package and fetch it on deploy.
- Re-download the library after a version bump.
- Serve Chosen JS and CSS as proper Drupal asset libraries with dependencies.
- Share one library definition between the main module and submodules.
- Attach the Chosen library to a custom render element via `chosen_lib/chosen`.
- Ensure aggregation/caching works by using a declared library instead of inline script.
- Automate library provisioning in a Composer/Drush deployment pipeline.
- Verify the library is present before enabling Chosen features.
- Provide the base Chosen CSS (`chosen.css`) separately from JS.
- Support multiple installation profiles that all need the Chosen assets.
