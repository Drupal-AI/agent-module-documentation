<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Title HTML (title_html) — agent index

Lets a content type's node **title carry inline HTML** by storing the title in a separate
formatted `text_long` field (`title_html`) and rendering it through the text-format filter
pipeline. Package **Field**. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version dir **2.x**
(installed 2.1.3). Functional deps: **node**, **text**, **filter** (info.yml declares none;
`field.storage` enforces node+text, rendering uses `filter`'s `check_markup`). Submodule
**`commerce_title_html`**.

## What it provides (from source)

- **No new entities/permissions/services/Drush.** One config-form route, one config object, one
  bundled text format, one field storage, plus procedural hooks in `title_html.module`.
- **Settings route** `title_html_settings` → `/admin/config/content/title-html`
  (`_form: TitleHTMLSettingsForm`, `_permission: 'administer content types'`). Menu link
  `title_html.settings` under `system.admin_config_content`.
- **Config object** `title_html.settings` — single key `title_text_format` (default `title`).
  Schema in `config/schema/title_html.schema.yml` (only defines the legacy
  `content_type_settings.*` config-entity; the `.settings` object has no explicit schema).
- **Bundled text format** `filter.format.title` — `filter_html` on with allowed_html
  `<em> <strong> <i> <abbr> <sub> <sup> <u> <s> <a href> <ul> <li> <ol> <blockquote> <img src alt …>`.
- **Field storage** `node.title_html` (`text_long`, cardinality 1). Per-bundle `FieldConfig` is
  created on demand (not shipped).
- **Plugins:** CKEditor(4) plugin `title_html` (`src/Plugin/CKEditorPlugin/TitleHTML.php`) and
  field widget `title_text_textarea` (`src/Plugin/Field/FieldWidget/TitleTextareaWidget.php`,
  extends core `TextareaWidget`).
- **Legacy config entity** `content_type_settings` (`src/Entity/ContentTypeSettings.php`) —
  deprecated; `title_html_update_10001()` migrates it into node-type third-party settings.
- **Service alter:** `TitleHtmlServiceProvider` swaps core's `maintenance_mode_subscriber` for
  `TitleHtmlMaintenanceModeSubscriber` (strips tags from site name in the maintenance message).

## How it works (from source)

- Enable per content type on the node-type form (`hook_form_node_type_form_alter` +
  `title_html_content_type_form_submit`): creates the `title_html` FieldConfig via
  `CopyTitle::createTitleHtmlField()` (label = title field label, `allowed_formats: ['title']`,
  required), sets the `title_text_textarea` widget, hides the plain `title` widget, batch-copies
  existing titles (`CopyTitle::copyTitles`, format `title`), and stores the field name in
  `$node_type` third-party setting `title_html:html_title_field`.
- **Render sink:** `title_html_preprocess_field__node__title()` replaces the title field value
  with `Markup::create(check_markup($value, $format))` and template `{{ value }}`. The markup is
  therefore filtered by the field item's text format.
- **Plain-text sync:** `hook_entity_presave` writes `setTitle(html_entity_decode(strip_tags($value)))`
  back onto the base `title` property, so `<title>`, breadcrumbs, menus, and admin lists stay
  plain. Branding block gets `strip_tags` too.
- Disabling re-runs the submit handler → `CopyTitle::deleteTitleHtmlField()` and clears the
  third-party setting. `title_html_field_config_delete()` clears the setting if the field is
  deleted directly.

## Solution docs

- Settings, the bundled `title` format, and how enable/disable works →
  [config/settings.md](config/settings.md)
- The `title_html` field, its widget, the render/preprocess mechanism, and `CopyTitle` →
  [fields/title-field.md](fields/title-field.md)
- Commerce integration (products/variations/stores) → the `commerce_title_html` submodule docs
  under `modules/commerce_title_html/2.x/`.
