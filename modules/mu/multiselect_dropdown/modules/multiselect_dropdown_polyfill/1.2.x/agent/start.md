<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multiselect Dropdown Dialog Polyfill — agent index

Trivial glue submodule. Enabling it is the whole setup — no config, no permissions, no
Drush, no plugins.

What it does:
- `multiselect_dropdown_polyfill_preprocess_multiselect_dropdown()`: when a multiselect
  dropdown attaches `multiselect_dropdown/element`, it also attaches
  `multiselect_dropdown_polyfill/polyfill`.
- Library `polyfill` (`multiselect_dropdown_polyfill.libraries.yml`) loads a small init
  JS/CSS plus a `vendor` sub-library that bundles
  `node_modules/dialog-polyfill/dist/dialog-polyfill.esm.js` + CSS (GoogleChrome
  dialog-polyfill), extending `<dialog>` support to ~2019-era browsers.
- Depends on parent `multiselect_dropdown` only.

Parent module: [../../../../1.2.x/agent/start.md](../../../../1.2.x/agent/start.md)

Enable only when you must support browsers lacking native `<dialog>`.
