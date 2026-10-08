<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Select A11y NG (select_a11y_ng) — agent index

**An accessible single/multiple-select form widget wrapping the Pidila `select-a11y` JS library.**

- **Version:** 1.1.x
- **Core:** ^10.3 || ^11 — no module dependencies (needs the JS lib `bordeaux-metropole/select-a11y` in `/libraries/select-a11y`)
- **Provides:** render element `@FormElement("select_a11y_ng")` (extends core Select) + `@FieldWidget` `SelectA11yNGWidget` (extends OptionsSelectWidget) for list_* and entity_reference fields. Config via `data-select-a11y-ng-config`, library `select_a11y_ng.widget`.
- **Submodules:** `select_a11y_ng_bef` (BEF filter/sort widgets), `select_a11y_ng_facets` (facets dropdown widget), `select_a11y_ng_webform` (Webform element swap).
- **No routes, no permissions, no controllers.** Configured per field on Manage form display (`placeholder`, `search`).

**Security:** No security findings. Pure form-element/widget — no routes/`_access`, no SQL/HTTP/deserialization/exec. Config is `Json::encode`d server-side; facets Twig output is auto-escaped; facets JS navigates to a server-generated facet URL (not user-supplied). No untrusted server-side sinks.
