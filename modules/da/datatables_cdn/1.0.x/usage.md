<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DataTables CDN

Provides Drupal libraries that pull the DataTables jQuery plugin from the public `cdn.datatables.net` CDN so other code/themes can attach interactive, sortable, paginated tables.

- Defines `datatables_cdn`, `datatables_responsive`, and a local `datatables` init library.
- The CSS/JS are declared as `type: external` pointing at datatables.net.
- Depends on core `jquery` (and declares a `ckeditor` module dependency).

---

## Installation & configuration

- Enable the module; there is no configuration UI.
- Attach `datatables_cdn/datatables` (or `datatables_cdn/datatables_cdn`) to a render array via `#attached['library']`.
- The responsive variant is `datatables_cdn/datatables_responsive`.
- The init script lives in `js/datatables.js`.
- No permissions, routes, or services are provided.
- Version pinned in the library file is DataTables 1.10.24 (info string version 1.10.14 label mismatch).

---

## Usage & behaviour / security note

- Because assets are loaded `external` from `cdn.datatables.net`, the browser fetches them directly from a third-party CDN.
- SECURITY NOTE (supply-chain, low danger): the external CSS/JS are declared **without Subresource Integrity (SRI)**; a compromised or MITM'd CDN could serve altered JavaScript that runs in your users' browsers.
- One CSS URL is protocol-relative (`//cdn.datatables.net/...`), inheriting the page scheme.
- Mitigation options: host DataTables locally instead of via CDN, or add an SRI hash, or use a CSP that restricts script sources.
- Functionally, attach the library and initialise `.datatables` tables per the DataTables docs.
- The `ckeditor` dependency is unusual for a table library — verify it is needed in your build.
- No server-side code executes; the module only registers libraries.
- Works for any theme/module that wants DataTables without bundling the assets.
- Keep the pinned CDN version updated for security fixes.
- No user input is processed server-side.
- The local `datatables` library depends on `core/drupal` and `datatables_cdn/datatables_cdn`.
- Use Views or custom markup to render the `<table>` the plugin enhances.
- Uninstall removes the library definitions.
- The info.yml `version` label (1.10.14) differs from the actual CDN URL version (1.10.24); verify the version you ship.
- Read: `datatables_cdn.libraries.yml`, `js/datatables.js`.
