<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redoc Field Formatter (redoc_field_formatter) — agent index

Renders an **OpenAPI/Swagger spec** (JSON or YAML) held in a **file** or **link** field as browsable
Redoc API documentation. It ships two field formatters, both labelled "Redoc UI": `redoc_ui` for
`file` fields (reads the uploaded spec's absolute URL) and `redoc_link_ui` for `link` fields (points at
a hosted spec). Both build a `<redoc spec-url=…>` element via the theme hook `redoc_ui_field_item`
(template `redoc-ui-field-item.html.twig`) and attach one library. There is **no settings page,
route, service, controller, form, permission, or drush command** — it is a pure display formatter;
choose the formatter under a field's **Manage display**.

The Redoc renderer is loaded as a single **external CDN script**,
`https://cdn.jsdelivr.net/npm/redoc@2.0.0/bundles/redoc.standalone.js` (declared `type: external`, no
local copy, no subresource-integrity hash). Operationally that means the page needs jsDelivr
reachable (fails offline/air-gapped), a strict `script-src` CSP must allow that host or the docs
silently do not render, and sites that need to vendor the library locally must override the library
definition. The spec itself is fetched **client-side by the Redoc script in the visitor's browser** —
the module never fetches it server-side.

- Depends on: `drupal:file`, `drupal:link` (core modules).
- Core: `^9.3 || ^10 || ^11`. Package: none declared. License: GPL-2.0-or-later. Version `3.1.0`.
- No configure route, no permissions, no services, no drush, no plugin types, **no config schema**
  (no `config/schema/`; formatter settings are inherited from the core file/link formatters).
- One library: `redoc_field_formatter/redoc_field_formatter.redoc` (external CDN, see above).

## What you'd do → where

- **Enable Redoc rendering on a file or link field / understand the two formatters, the template, the
  library, and setting a formatter from code** → [fields/formatters.md](fields/formatters.md)

## Key facts (real machine names)

- Field formatters: `redoc_ui` (`file`, class `RedocUIFormatter`, extends `FileFormatterBase`),
  `redoc_link_ui` (`link`, class `RedocUILinkFormatter`, extends core `LinkFormatter`) — both in
  `src/Plugin/Field/FieldFormatter/`.
- Theme hook: `redoc_ui_field_item` (registered in `redoc_field_formatter.module` `hook_theme()`,
  variables `field_name`, `delta`, `file_url`), template
  `templates/redoc-ui-field-item.html.twig`.
- Library: `redoc_field_formatter/redoc_field_formatter.redoc` →
  `cdn.jsdelivr.net/npm/redoc@2.0.0/bundles/redoc.standalone.js` (`type: external`).
- Injected service (file formatter): `file_url_generator` (`generateAbsoluteString()`).
- Hooks implemented: `hook_theme()`, `hook_help()` (route `help.page.redoc_field_formatter`).
- File fields must allow `json` / `yml` (or `yaml`) in **Allowed file extensions** to upload a spec.
