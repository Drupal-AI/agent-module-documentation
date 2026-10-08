<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `bp_media` bundle — fields, values, wiring

No settings form (`configure: null`). Everything is config imported from `config/optional/`.

## Fields

| Field | Type | Label | Storage owner |
|---|---|---|---|
| `bp_media` | `entity_reference` → `media` | Media | bp_media |
| `bp_header` | `string` | Header | parent |
| `bp_link` | `link` | Link | parent |
| `bp_width` | `list_string` | Width | parent |
| `bp_background` | `list_string` | Background | parent |
| `bp_margin` | `list_string` | Margin | parent |
| `bp_padding` | `list_string` | Padding | parent |

### The `bp_media` field — the one thing unique to this submodule

`field.storage.paragraph.bp_media`:

```yaml
type: entity_reference
settings: { target_type: media }
cardinality: 1
```

`field.field.paragraph.bp_media.bp_media`:

```yaml
settings:
  handler: 'default:media'
  handler_settings:
    target_bundles:
      image: image
      remote_video: remote_video
    sort: { field: _none, direction: ASC }
    auto_create: false
    auto_create_bundle: image
```

So out of the box editors may only reference **Image** and **Remote video** media. The config
file also declares hard dependencies on `media.type.image` and `media.type.remote_video`,
which is why the bundle appears only on sites that have those two media types.

To allow another media type:

```bash
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("paragraph", "bp_media", "bp_media");
  $s = $f->getSetting("handler_settings");
  $s["target_bundles"]["document"] = "document";
  $f->setSetting("handler_settings", $s)->save();'
```

### `bp_link` instance settings

`link_type: 17` (internal + external), `title: 0` — **link text is disabled**, because the
template uses the URL only, wrapping the rendered media in the anchor.

### Shared list values

- `bp_width`: `paragraph--width--tiny|narrow|medium|wide|full`
- `bp_margin`: `"mt-1 mb-1"`, `"mt-3 mb-3"`, `"mt-5 mb-5"`, `mt-1`, `mt-3`, `mt-5`, `mb-1`, `mb-3`, `mb-5`
- `bp_padding`: `"pt-1 pb-1"`, `"pt-3 pb-3"`, `"pt-5 pb-5"`, `pt-1`, `pt-3`, `pt-5`, `pb-1`, `pb-3`, `pb-5`
- `bp_background`: 58 values, e.g. `paragraph--color paragraph--color--primary`,
  `paragraph--color paragraph--color--rgba-black-slight`, `paragraph--color--transparent`

## Form display (`paragraph.bp_media.default`)

| Field | Widget | Weight |
|---|---|---|
| `bp_background` | `options_select` | 0 |
| `bp_width` | `options_select` | 1 |
| `bp_header` | `string_textfield` (size 60) | 2 |
| `bp_media` | **`media_library_widget`** | 3 |
| `bp_link` | `link_default` | 4 |
| `bp_margin` | `options_select` | 5 |
| `bp_padding` | `options_select` | 6 |

Hidden: `created`, `status`. A `field_group` third-party setting collects
`bp_background`, `bp_margin`, `bp_padding`, `bp_width` into a collapsed **Styles**
`details` group (`weight: 6`, `open: false`).

## View display (`paragraph.bp_media.default`)

All labels hidden. Formatters:

| Field | Formatter |
|---|---|
| `bp_media` | `entity_reference_entity_view` (`view_mode: default`, `link: false`) |
| `bp_link` | `link_separate` |
| `bp_header` | `string` |
| `bp_background`, `bp_width`, `bp_margin`, `bp_padding` | `list_key` |

`list_key` matters: it prints the **stored value** (the CSS class), which is exactly what the
Twig template reads back out of `content.*`.

## Make the bundle available to editors

```bash
drush php:eval '
  $f = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_page_content");
  $s = $f->getSetting("handler_settings");
  $s["target_bundles"]["bp_media"] = "bp_media";
  $f->setSetting("handler_settings", $s)->save();'
```

## Read the live configuration

```bash
drush cget field.field.paragraph.bp_media.bp_media settings.handler_settings.target_bundles
drush cget core.entity_form_display.paragraph.bp_media.default content.bp_media
drush cget core.entity_view_display.paragraph.bp_media.default content.bp_media
```

## Create a media paragraph programmatically

```php
use Drupal\media\Entity\Media;
use Drupal\paragraphs\Entity\Paragraph;

$media = Media::create(['bundle' => 'remote_video', 'name' => 'Intro video',
  'field_media_oembed_video' => 'https://www.youtube.com/watch?v=xxxxxxxxxxx']);
$media->save();

$p = Paragraph::create([
  'type' => 'bp_media',
  'bp_media' => ['target_id' => $media->id()],
  'bp_header' => 'Watch the intro',
  'bp_width' => 'paragraph--width--wide',
  'bp_link' => ['uri' => 'https://example.com/watch'],
  'bp_margin' => 'mt-3 mb-3',
]);
$p->save();
```
