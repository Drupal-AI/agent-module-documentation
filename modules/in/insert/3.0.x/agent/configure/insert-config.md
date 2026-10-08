<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Insert

Insert has **two** configuration layers: one global config object, and one per-widget third-party
setting on each form-display component.

## 1. Global config object `insert.config`

Route `insert.config` → `/admin/config/content/insert` (permission `administer filters`). Form:
`Drupal\insert\Form\ConfigForm`. Shipped defaults (`config/install/insert.config.yml`):

```yaml
absolute: false                 # emit full base-URL prefixed links/img src
file_field_images_enabled: false# treat images uploaded to generic file fields as images
widgets:
  file: [file_generic]          # file-field widget plugin ids Insert attaches to
  image: [image_image]          # image-field widget plugin ids Insert attaches to
css_classes:
  file: []                      # extra classes added to inserted file links
  image: []                     # extra classes added to inserted images / image links
file_extensions:
  audio: [mp3]                  # extensions detected as audio (=> <audio>)
  video: [mp4]                  # extensions detected as video (=> <video>)
```

Read/set with drush:

```bash
drush cget insert.config
drush cset insert.config file_field_images_enabled true -y
# widgets/css_classes/file_extensions are sequences; edit via cset with a key path or config import
```

- `widgets.file` / `widgets.image` decide **which widget plugins** get the Insert fieldset. Add a
  contrib widget's plugin id here to enable Insert on it.
- `file_field_images_enabled: true` makes image styles selectable in the Insert settings of *file*
  widgets, so images uploaded to a generic file field can be inserted as `<img>`.

## 2. Per-widget setting: `third_party_settings.insert`

Enabled per field, per form mode, on **Manage form display**. Stored on the form-display component:

```
core.entity_form_display.<entity_type>.<bundle>.<form_mode>
  -> content.<field_name>.third_party_settings.insert
```

Keys (defaults from `INSERT_DEFAULT_SETTINGS`):

| Key | Meaning | Default |
|---|---|---|
| `styles` | map of **enabled** insert style names (`{name: name}`); may hold the special `<all>` key | `[]` (Insert disabled) |
| `default` | style selected by default / used when no styles enabled | `insert__auto` |
| `auto_image_style` | image style used by the AUTOMATIC option (image widgets) | `image` |
| `link_image` | image style the inserted image links to, or null | `null` |
| `width` | max insert width in px (HTML only, no resize) | `''` |
| `rotate` | show rotation controls (image widgets) | `false` |

**A field's Insert button only appears when `styles` is non-empty.** Available style names come from
`hook_insert_styles`: `insert__auto` (AUTOMATIC), `link` (Link to file), `audio`, `video`, `image`
(Original image), plus one entry per image style, plus any style a submodule adds
(`colorbox__<style>`, `responsive_image__<id>`, media view-mode ids).

### Via the UI

1. Go to the bundle's *Manage form display* (e.g. `/admin/structure/types/manage/article/form-display`).
2. Click the cog on the file/image field's row.
3. Under **Insert**, tick the styles to offer, pick a **Default style** (and, for images,
   automatic style / link-to / max width / rotation).
4. **Update**, then **Save**. The row summary then reads `Insert: <styles>` or `Insert: disabled`.

### Via drush php:eval (scriptable — file field, single save)

```php
$s = \Drupal::entityTypeManager()->getStorage('entity_form_display');
$fd = $s->load('node.article.default');
$c = $fd->getComponent('field_doc');                 // a file_generic widget
$c['third_party_settings']['insert'] = [
  'styles' => ['link' => 'link'], 'default' => 'insert__auto',
];
$fd->setComponent('field_doc', $c)->save();
```

For an **image** field on a site with `lightning_media_image`, set the `image_image` component,
`save()`, reload, set it again with the `insert` third-party settings, and `save()` again — the
first save is intercepted and swapped to `entity_browser_file`; the second is not (the field is no
longer "new"), so `image_image` + your Insert settings persist.

### Read it back

```bash
drush cget core.entity_form_display.node.article.default content.field_doc
# look for third_party_settings.insert.styles / .default
```

## Config schema

`config/schema/insert.schema.yml` defines only `insert.config` (the global object). The per-widget
`third_party_settings.insert` array has **no** dedicated third-party schema, so it is stored as-is.
