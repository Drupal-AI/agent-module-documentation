<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Title HTML — configuration

## Install / enable

`drush en title_html`. On install the module imports (`config/install/`):

- `title_html.settings` → `title_text_format: title`.
- `filter.format.title` — the bundled **"Title"** text format (`format: title`).
- `field.storage.node.title_html` — a `text_long` field storage (`id: node.title_html`,
  cardinality 1, translatable), enforced-dependency on module `title_html`.

No per-content-type field is created at install; that happens when you enable the feature on a
content type (see [../fields/title-field.md](../fields/title-field.md)).

## Settings form

- Route `title_html_settings` → **`/admin/config/content/title-html`**, form
  `Drupal\title_html\Form\TitleHTMLSettingsForm` (extends `ConfigFormBase`), requirement
  `_permission: 'administer content types'`. Menu link `title_html.settings` under
  *Configuration → Content authoring* (`system.admin_config_content`).
- Single field **Text format** (`title_text_format`) — a `select` populated from
  `filter_formats()` (every text format on the site). Saved to config `title_html.settings`
  key `title_text_format`. Default is the bundled `title` format.
- This value is consumed by the widget: `TitleTextareaWidget::formElement()` sets the title
  field element's `#format` and `#allowed_formats` to `[$title_text_format]`, so editors of the
  title field are locked to the configured format.

## The bundled `title` text format

`config/install/filter.format.title.yml` enables one filter, `filter_html`, with:

```
allowed_html: '<em> <strong> <i> <abbr> <sub> <sup> <u> <s> <a href> <ul> <li> <ol> <blockquote> <img src alt data-entity-type data-entity-uuid>'
filter_html_help: true
filter_html_nofollow: false
```

`filter_html` runs the value through core's XSS-safe allow-list filter (strips tags/attributes
outside the list, neutralises event handlers and dangerous URL schemes). This is the format the
render sink (`check_markup`) applies by default.

## Config schema

`config/schema/title_html.schema.yml` defines only `title_html.content_type_settings.*`
(the deprecated config entity — see below). The `title_html.settings` object itself has **no
explicit schema entry**.

## Legacy config entity + update hook

- `content_type_settings` (`src/Entity/ContentTypeSettings.php`, config prefix
  `content_type_settings`, admin permission `administer site configuration`) is deprecated. Its
  own docblock says it can be deleted once the update has run everywhere.
- `title_html_update_10001()` (`title_html.install`) loads every `ContentTypeSettings`, moves its
  `html_title_field` onto the matching `NodeType` third-party setting
  (`title_html:html_title_field`), and deletes the old entity. Current code reads the setting from
  the node type, not this entity.

## Maintenance-mode service swap

`TitleHtmlServiceProvider::alter()` re-classes core's `maintenance_mode_subscriber` to
`TitleHtmlMaintenanceModeSubscriber`, whose `getSiteMaintenanceMessage()` builds the message with
`html_entity_decode($site_name)` (so a formatted site name renders cleanly in the maintenance
message). No config.
