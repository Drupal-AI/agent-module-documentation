<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Instagram (`lightning_media_instagram`) — agent index

Glue submodule of Lightning Media over contrib **Media Entity Instagram**. **No routes, no
permissions, no services, no settings form (`configure` = null), no config schema, no Drush,
no plugin types.** Dependencies: `lightning_media`, `media_entity_instagram`.

## The one hook

```php
function lightning_media_instagram_media_source_info_alter(array &$sources) {
  $source = &$sources['oembed:instagram'];
  $source['input_match'] = [
    'constraint' => 'InstagramEmbedCode',
    'field_types' => ['string', 'string_long'],
  ];
  $source['preview'] = TRUE;                                   // live preview on the media form
  $source['forms']['media_library_add'] = AddByUrlForm::class; // "Add via URL" in the media library
  Override::pluginClass($source, Instagram::class);            // adds InputMatchInterface

  // Back-compat: alias the pre-3.x plugin ID during database updates only.
  if (Drupal::service('kernel') instanceof UpdateKernel) {
    $sources['instagram'] = $source;
  }
}
```

The source plugin ID is **`oembed:instagram`** (it was plain `instagram` before Media Entity
Instagram 3.x — the `UpdateKernel` branch above only exists so old update hooks do not fatal).
`lightning_media_instagram.install` only declares `hook_update_last_removed(): 8003`.

Validation classes: `Plugin\Validation\Constraint\InstagramEmbedCodeConstraint` and
`InstagramEmbedCodeConstraintValidator`.

## Configuration it installs

`config/install/` (always):

| Config | Value |
|---|---|
| `media.type.instagram` | label **Instagram**, source `oembed:instagram`, source field `embed_code` |
| `field.field.media.instagram.embed_code` | instance of the parent module's shared `media.embed_code` (`string_long`) storage |
| `field.field.media.instagram.field_media_in_library` | "Show in media library" boolean |
| `core.entity_form_display.media.instagram.{default,media_library}` | form displays |
| `core.entity_view_display.media.instagram.{default,embedded,thumbnail}` | view displays |

`config/optional/`: `core.entity_view_display.media.instagram.media_library`.

```bash
drush config:get media.type.instagram
drush php:eval '
  $t = \Drupal\media\Entity\MediaType::load("instagram");
  print $t->getSource()->getPluginId() . " / " . $t->getSource()->getConfiguration()["source_field"] . "\n";
'   # => oembed:instagram / embed_code
```

Create an Instagram media item:

```php
use Drupal\media\Entity\Media;
Media::create(['bundle' => 'instagram', 'name' => 'Campaign post'])
  ->set('embed_code', 'https://www.instagram.com/p/XXXXXXXXXXX/')
  ->save();
```

`embed_code` is **shared** with the Tweet media type — both are instances of the same
`media.embed_code` field storage installed by the parent module. Saving an oEmbed-backed
item fetches the remote resource and thumbnail, so it needs outbound network access.

Parent module API (input matching, preview, `MediaHelper`):
[`../../../../5.1.x/agent/api/media-helper.md`](../../../../5.1.x/agent/api/media-helper.md).
