<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mautic Paragraph (mautic_paragraph) — agent index

Integrates a **Mautic** (open-source marketing automation) server with Drupal and exposes Mautic
**forms** as embeddable content. On install it ships a **`mautic` paragraph type** and a
**`mautic_block` custom-block type**, each with a title, a rich-text body and a "Form" field whose
allowed values are fetched live from Mautic. A field formatter renders the chosen form as a
`<script src="{mautic_base_url}/form/generate.js?id={form_id}">` tag (client-side inject).
Package `Custom`. Core `^10.2 || ^11`. License GPL-2.0-or-later. Version 1.2.0 (doc dir `1.x`).

- **Install/enable, the settings form, connector plugins & config objects** →
  [config/settings.md](config/settings.md)
- **The paragraph/block types, fields, the form-list formatter & autocomplete widget** →
  [fields/mautic-form-field.md](fields/mautic-form-field.md)

## Dependencies

- Hard (info.yml): core **`options`** and **`text`**.
- Soft: **`paragraphs`** and core **`block_content`** — not declared as hard deps. The paragraph
  type + its fields live in `config/optional/` and are installed by
  `hook_modules_installed()` **when `paragraphs` is enabled**; the block type + its fields are in
  `config/install/`.
- Composer: **`mautic/api-library:^3.0`** (with two patches in `composer.json extra.patches`,
  incl. one adding Two-Legged OAuth2 client-credentials support).

## What it provides (from source)

- **Entities/bundles** (config): paragraph type `mautic`, block_content type `mautic_block`.
  Fields on the paragraph: `field_mautic_title` (string), `field_mautic_text` (text_default),
  `field_mautic_formid` (**list_integer**), `field_mautic_layout` (hidden list). Block fields:
  `field_mautic_block_title`, `field_mautic_block_text`, `field_mautic_block_formid`.
- **Field formatter** `mautic_form_list` (id, label "Mautic Formid list"),
  `src/Plugin/Field/FieldFormatter/MauticFormatter.php` — `field_types = { list_integer }`.
- **Field widget** `autocomplete_mautic` (label "Autocomplete mautic forms list"),
  `src/Plugin/Field/FieldWidget/AutocompleteWidget.php` — `field_types = { list_integer }`.
- **Plugin type** `mautic_paragraph_connector` (annotation
  `src/Annotation/MauticParagraphConnector.php`, manager `MauticParagraphConnectorPluginManager`,
  base `MauticParagraphConnectorPluginBase`). Two connectors: **`basic_auth`** and **`oauth`**.
- **Service** `mautic_paragraph_api` (`src/MauticParagraphApi.php`) — thin façade delegating to the
  active connector (`getApiClient`, `getStatus`, `getList`, `getServerUri`, `getFormTitle`).
- **Config form** `MauticSettingsForm` at route `mautic_paragraph.route_settings`
  (**`/admin/config/services/mautic`**), permission **`administer mautic_paragraph`**.
- **Controller** `FormAutocompleteController::handleAutocomplete` at route
  `mautic_paragraph.autocomplete.forms` (**`/admin/mautic_paragraph/autocomplete/forms`**, JSON,
  permission `access content`).
- **Hooks** (`mautic_paragraph.module`): `hook_theme` (2 templates), `hook_ENTITY_TYPE_view_alter`
  (adds layout class + library on `mautic` paragraphs), several
  `hook_field_widget_*_form_alter` (attach admin colorpicker lib), `hook_modules_installed`,
  and the allowed-values callback `mautic_paragraph_form_list()`.
- **Config object** `mautic_paragraph.settings` (schema `config/schema/*`): `connector`, `limit`,
  `cache`, `connector_config` (plugin-typed).

## Embed mechanism (from source)

`MauticFormatter::viewElements()` reads the admin-configured Mautic base URL via
`mauticParagraphApi->getServerUri()` and, per field value, builds a render array with
`#theme => 'mautic_field_formatter'`, `#id => $item->value` (the list_integer form id) and
`#base_url`. The template `templates/mautic-field-formatter.html.twig` is exactly:
`<script type="text/javascript" src="{{ base_url }}/form/generate.js?id={{ id }}"></script>`.
`base_url` comes from admin config (resolved through `Url::fromUri()`), and `id` is a
`list_integer` value chosen by the editor from the Mautic form list — both Twig-autoescaped.
