<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Multiselect Dropdown that loads the GoogleChrome dialog-polyfill so the native `<dialog>`-based dropdown works in browsers released before ~2022.

---

`multiselect_dropdown_polyfill` is a small glue submodule. Its only logic is a
`hook_preprocess_HOOK` (`multiselect_dropdown_polyfill_preprocess_multiselect_dropdown`)
that, whenever a multiselect dropdown attaches the `multiselect_dropdown/element` library,
also attaches `multiselect_dropdown_polyfill/polyfill`. That library bundles the
`dialog-polyfill` npm package (its `vendor` sub-library ships
`node_modules/dialog-polyfill/dist/dialog-polyfill.esm.js` + CSS) plus a small init script
and CSS, extending `<dialog>` support to browsers from ~2019. It depends only on the parent
`multiselect_dropdown` module. There is no configuration, no permissions, and no Drush —
enabling it is the entire setup. Enable it only if you must support browsers without native
`<dialog>`; modern browsers do not need it.

---

- Support the multiselect dropdown in browsers released ~2019–2021 without native `<dialog>`.
- Add dialog-polyfill automatically to every multiselect dropdown on the site.
- Provide fallback dialog behavior for older enterprise/locked-down browser fleets.
- Ship the polyfill only where needed by enabling the submodule per environment.
- Avoid patching the parent module to add a polyfill.
- Keep the polyfill CSS/JS scoped to pages that actually render a multiselect dropdown.
- Remove the polyfill overhead on modern-only sites by leaving the submodule disabled.
- Bundle the vendored dialog-polyfill library so no external CDN is required.
- Guarantee the dropdown opens/closes correctly on legacy Safari and Edge versions.
- Ensure field-widget multiselect dropdowns work for editors on older admin machines.
- Ensure exposed-filter (BEF) multiselect dropdowns work for site visitors on old browsers.
- Meet a client requirement to support a minimum browser baseline older than 2022.
- Load the polyfill via the standard Drupal library system (attached in a preprocess hook).
- Provide modal/backdrop behavior in browsers whose native `<dialog>` is incomplete.
- Turn the polyfill on or off simply by enabling/disabling the submodule (no config).
- Roll the polyfill out to a staging environment to test old-browser support before production.
- Keep the parent module lean by isolating the extra JS/CSS weight in an optional submodule.
