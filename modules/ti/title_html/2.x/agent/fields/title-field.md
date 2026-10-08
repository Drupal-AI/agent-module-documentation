<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Title HTML — the HTML title field, widget, and render mechanism

All logic lives in `title_html.module` and `src/CopyTitle.php`. There is no field-type or
formatter plugin; the module reuses core's `text_long` field and alters display via preprocess.

## Enabling on a content type

`hook_form_node_type_form_alter()` adds a **Title HTML Settings** details group with an
**Enable Title HTML Field** checkbox (default = whether third-party setting
`title_html:html_title_field` is set). `title_html_content_type_form_submit()` (prepended to the
node-type form submit) reacts to a change:

- **On enable:** `CopyTitle::createTitleHtmlField('node', $bundle)` creates a `FieldConfig` from
  the `node.title_html` storage — label = the entity's title-field label, `required: TRUE`,
  `settings.allowed_formats: ['title']`. Then it:
  - sets the form-display component `title_html` to widget `text_textarea`, weight 0;
  - **removes the `title` component** from the node form display (hides the plain title);
  - removes `title_html` from the default and teaser view displays (it is rendered via the title
    field preprocess, not as an ordinary field);
  - runs a batch (`CopyTitle::copyTitles('node', $bundle, 'title')`) copying each existing node's
    `title` into `title_html->value` with `format = 'title'`;
  - stores `title_html:html_title_field = 'title_html'` on the node type.
- **On disable:** `CopyTitle::deleteTitleHtmlField('node', $bundle)` deletes the `FieldConfig`
  and the third-party setting is cleared.

`title_html_field_config_delete()` also clears the third-party setting if the `title_html`
FieldConfig is deleted directly.

## Widget

`TitleTextareaWidget` (`@FieldWidget id="title_text_textarea"`, extends core
`text\...\TextareaWidget`; note the form-display code above assigns type `text_textarea`, and the
widget also declares itself for `string`/`text_long`). `formElement()` forces the element's
`#format` and `#allowed_formats` to the single format from `title_html.settings:title_text_format`
(default `title`), so the editor cannot pick another format for the title field.

## CKEditor(4) plugin

`src/Plugin/CKEditorPlugin/TitleHTML.php` (`@CKEditorPlugin id="title_html"`) is a contextual,
configurable CKEditor 4 plugin loading `plugin/plugin.js`. Its per-format settings
(`title_html_enable`, `disable_enter_key`, `disable_shift_enter_key`, `disable_elementspath`,
`autoGrow_minHeight`) are applied in `title_html_editor_js_settings_alter()`: sets editor height
350px, binds Enter / Shift+Enter to `doNothing` when disabled (to suppress `<p>`/`<br>`), and can
remove the `elementspath` plugin. This targets legacy CKEditor 4 (the `ckeditor` module);
CKEditor 5 sites simply use the textarea widget + text format.

## Render mechanism (the display sink)

`title_html_preprocess_field__node__title(&$variables)`:

1. loads the node's type and its `title_html:html_title_field` setting; no-ops if unset;
2. for each item: sets
   `content['#context']['value'] = Markup::create(check_markup($field->value, $field->format))`
   and `content['#template'] = '{{ value }}'`.

So the title field is rendered as the `title_html` field value passed through
`check_markup($value, $format)` — Drupal's text-format filter pipeline. The applied format is the
one stored on the field item (locked to `title_text_format` by the widget; the copy batch stores
`title`). Empty/unknown formats fall back to core's fallback (escaping) format.

`title_html_preprocess_block__system_branding_block()` sets the site name to
`strip_tags(html_entity_decode(...))` so the branding block stays plain.

## Plain-title synchronisation

`title_html_entity_presave()` (nodes only): when a `title_html` value is present it writes
`$entity->setTitle(html_entity_decode(strip_tags($value)))`. The base `title` property therefore
always holds a plain-text form used by the HTML `<title>`, breadcrumbs, menu links, admin content
lists, and search — only the node-page title field display shows the formatted markup.

## `CopyTitle` static helpers (`src/CopyTitle.php`)

- `createTitleHtmlField($entity_type, $bundle)` — create the per-bundle field (returns the field,
  or FALSE if it already exists).
- `copyTitles($entity_type, $type, $format, &$context)` — batch op; entity-query (accessCheck
  FALSE) in pages of 10, copying `label()` into `title_html->value` with the given format.
- `finishedCopying(...)` — status message.
- `deleteTitleHtmlField($entity_type, $bundle)` — delete the per-bundle field.

These helpers are entity-type-agnostic, which is how the `commerce_title_html` submodule reuses
them for products/variations/stores.
