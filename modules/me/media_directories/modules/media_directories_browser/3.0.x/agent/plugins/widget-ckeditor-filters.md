<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field widget, CKEditor 5 plugins and filters

The module defines **no plugin types**; it provides five plugin instances.

## 1. Field widget `media_directories_browser_widget`

`Drupal\media_directories_browser\Plugin\Field\FieldWidget\MediaDirectoriesBrowserWidget`

```php
#[FieldWidget(
  id: 'media_directories_browser_widget',
  label: new TranslatableMarkup('Media Directories Browser Widget'),
  field_types: ['entity_reference'],
  multiple_values: TRUE,
)]
```

It renders a `fieldset` with classes `media-directories-browser-field-widget`
`js-media-directories-browser-widget`, `data-cardinality` and `data-allowed-types` (from the
field's `handler_settings.target_bundles`), an **Add media** button that opens the Vue
browser in an off-canvas dialog, and a preview area. It attaches
`media_directories_browser/media_directories_browser_widget` +
`core/drupal.dialog.off_canvas`, mirrors core's MediaLibraryWidget cardinality messages
("One media item remaining." / "The maximum number of media items have been selected.") and
the empty-selection text, and preserves delta order (loading with `loadMultiple()` and
re-ordering by the saved id list). `massageFormValues()` turns the hidden comma-separated id
list back into field deltas.

```bash
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $d->setComponent("field_media", [
    "type" => "media_directories_browser_widget", "region" => "content", "weight" => 10,
  ])->save();'
```

Note the id collides *by name only* with `media_directories_ui`'s deprecated
`@EntityBrowserWidget(id = "media_directories_browser_widget")` — different plugin types, no
conflict.

## 2. CKEditor 5 plugin `media_directories_browser_media_directories_browser`

Class `…\Plugin\CKEditor5Plugin\MediaDirectoriesBrowser` (annotation-style). Ships **no JS
plugin classes** — it only rewrites core's `drupalMedia` config so the "Add media" dialog
becomes the Vue browser:

```php
$config['drupalMedia']['libraryURL'] = '/media-directories-browser';
$config['drupalMedia']['openDialog'] = ['func' => ['name' => 'Drupal.media_directories_browser.openDialog', 'invoke' => FALSE]];
```

`media_directories_browser.ckeditor5.yml` also sets `dialogSettings` (class
`media-directories-browser-ckeditor-modal`, 90% × 75%). Conditions: filter `media_embed` +
toolbar item `drupalMedia`. `elements: false` (adds no new HTML).

## 3. CKEditor 5 plugin `media_directories_browser_image_options`

Class `…\Plugin\CKEditor5Plugin\ImageOptions`. Declares
`<drupal-media data-image-style data-width data-height>` and requires core's `media_media`
plugin. `getDynamicPluginConfig()`:

- builds `mediaDirectoriesEditor.imageStyles` from **`media_directories_browser.settings:
  embed_image_styles`** — an explicit opt-in list, deliberately with **no "all styles"
  fallback**, so an empty list means no options;
- builds `mediaDirectoriesEditor.viewModes` from the editor's `media_media.
  allow_view_mode_override` plus the `media_embed` filter's `allowed_view_modes`;
- appends `'|'`, `'mediaImageSize'` and `'mediaImageSizeEdit'` to
  `drupalMedia.toolbar`.

Core's own view-mode dropdown is stripped from the toolbar by
`MediaDirectoriesBrowserHooks::editorJsSettingsAlter()` (it must happen there because
`getDynamicPluginConfig()` only sees this plugin's own static config).

## 4. CKEditor 5 plugin `media_directories_browser_media_file_link`

Class `…\Plugin\CKEditor5Plugin\MediaFileLink`, JS `mediaFileLink.MediaFileLink`, declares
`<a data-entity-uuid data-entity-type>`, condition: the `ckeditor5_link` plugin.
`getDynamicPluginConfig()` sets:

- `mediaFileLink.enabled` from `media_directories_browser.settings:
  enable_file_link_in_link_form` (default TRUE);
- `mediaFileLink.allowedBundles` from `MediaTypeService::getFileBasedBundles()` so the
  browser modal only offers media types that actually have a file.

This adds a file picker **inside the standard link form**. The separate toolbar *button* for
inserting file links is the `media_directories_file_link` submodule.

## 5. Filter `media_directories_default_view_mode`

`Drupal\media_directories_browser\Plugin\Filter\MediaDefaultViewMode`

```
id: media_directories_default_view_mode
title: "Media default view mode"
type: TYPE_TRANSFORM_REVERSIBLE
weight: 90
settings: { view_mode_mapping: [] }
```

`process()` early-returns unless the text contains `<drupal-media` and the mapping is
non-empty. It then XPath-selects
`//drupal-media[@data-entity-type="media" and normalize-space(@data-entity-uuid)!="" and not(@data-view-mode)]`,
loads each media by UUID and, if the mapping has an entry for that bundle, sets
`data-view-mode`. **Tags that already carry a `data-view-mode` are left alone.** It must run
**before** core's `media_embed` filter.

`settingsForm()` renders one select per media bundle, options from
`getViewModeOptionsByBundle('media', $bundle)`, with an empty option
*"- Use filter default -"*. Config schema:
`filter_settings.media_directories_default_view_mode` → `view_mode_mapping` (sequence of
strings keyed by bundle).

```bash
drush php:eval '
  $f = \Drupal\filter\Entity\FilterFormat::load("full_html");
  $f->setFilterConfig("media_directories_default_view_mode", [
    "status" => TRUE, "weight" => 0,
    "settings" => ["view_mode_mapping" => ["image" => "embedded", "document" => "default"]],
  ]);
  $f->setFilterConfig("media_embed", ["status" => TRUE, "weight" => 100]);
  $f->save();'
```
