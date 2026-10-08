<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FPDI Print (fpdi_print) — agent index

Generates a **PDF from a View**, optionally overlaying the view's field data onto an **existing PDF
template** (FPDI stamping) or filling an **AcroForm** template (FPDM). Package `Views`. Core
`^9.3 || ^10 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.1.19 (doc dir `1.x`).

- **The Views area link, the print route, YAML positions & template stamping** →
  [views/print-area.md](views/print-area.md)
- **Global settings form + `fpdi_print.settings` config object/schema** →
  [config/settings.md](config/settings.md)
- **The `fpdi_print.print_builder` service, positions array & `hook_fpdi_print_views_alter`** →
  [api/print-builder.md](api/print-builder.md)

## Dependencies

- **PHP/Composer libraries only** (no Drupal module deps in `.info.yml`): `tecnickcom/tcpdf ^6.11`,
  `setasign/fpdi ^2.6`, `tmw/fpdm ^2.9`. Installed via `composer require drupal/fpdi_print`.
- `src/Renderer/ViewRenderer.php` references `entity_print` classes/services that are **not**
  declared as dependencies and **not** defined in `fpdi_print.services.yml`
  (`fpdi_print.asset_renderer`, `fpdi_print.filename_generator`) — that renderer is dormant/dead
  code (registered as the `view` entity's `fpdi_print` handler in `FpdiPrintHooks::entityTypeAlter`)
  and is not exercised by the module's own route.

## What it provides (from source)

- **Views area handler** `FpdiPrintViewsLink` (id `fpdi_print_views_link`,
  `src/Plugin/views/area/FpdiPrintViewsLink.php`, extends `TokenizeAreaPluginBase`). Registered for
  the generic `views` table as area `area_fpdi_print_views` (`FpdiPrintViewsHooks::viewsData`) and,
  via `FpdiPrintHooks::viewsDataAlter`, as a per-entity **field** `fpdi_print_<entity_type>` ("Print
  link"). Renders a `#type => link` to the print route.
- **Routes** (`fpdi_print.routing.yml`):
  - `fpdi_print.view` — `pdf/view/{view_name}/{display_id}/{option_id}` →
    `ViewPrintController::viewPrint`; access via `ViewPrintController::checkAccess`
    (`access content` **and** `$view->access($display_id)`). Streams the PDF.
  - `fpdi_print.settings` — `admin/config/content/fpdi-print` (SettingsForm), perm
    `administer fpdi print`.
  - `fpdi_print.validate` — `/fpdi-print/validate` (ValidateForm; template+YAML preview), perm
    `administer fpdi print`.
- **Services** (`fpdi_print.services.yml`): `fpdi_print.print_builder` (`PrintBuilder` — builds the
  PDF), `fpdi_print.form_fields` (`FormFields` — reads AcroForm field names from a template),
  `FpdiPrintViewsHooks` (autowired).
- **PDF engine** `src/Pdf.php` — `Pdf extends setasign\Fpdi\Tcpdf\Fpdi` (TCPDF+FPDI), with custom
  `Header()`/`Footer()` (logo, title/slogan, HTML header/footer, "Page n/N").
- **Config**: object `fpdi_print.settings` (schema in `config/schema/fpdi_print.schema.yml`; no
  `config/install` defaults). **No `hook_permission`/permissions.yml** — the `administer fpdi print`
  permission used by two routes is referenced but never defined, so `provides_permissions` is false.
- **Hooks** (`src/Hook/`, attribute-based): `help`, `views_data`, `views_data_alter`,
  `entity_type_alter`. Alter hook for integrators: `hook_fpdi_print_views_alter(&$positions, $view,
  $filePdfTemplate)`.
- **Libraries** (`fpdi_print.libraries.yml`): admin-UI only — Ace editor, pdf.js, js-yaml,
  jQuery-UI (all external CDN) + `js/pdfi.js` for the YAML/position editor. No runtime library on the
  generated PDF.
