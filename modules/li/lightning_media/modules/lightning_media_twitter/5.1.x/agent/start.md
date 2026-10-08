<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Twitter (`lightning_media_twitter`) — agent index

Glue submodule of Lightning Media over contrib **Media Entity Twitter**. **No routes, no
permissions, no services, no settings form (`configure` = null), no config schema, no Drush,
no plugin types.** Dependencies: `lightning_media`, `media_entity_twitter`.

## What the hooks do

```php
function lightning_media_twitter_media_source_info_alter(array &$sources) {
  $sources['twitter']['input_match'] = [
    'constraint' => 'TweetEmbedCode',
    'field_types' => ['string', 'string_long'],
  ];
  $sources['twitter']['preview'] = TRUE;                       // live preview on the media form
  $sources['twitter']['forms']['media_library_add'] = AddByUrlForm::class;
  Override::pluginClass($sources['twitter'], Twitter::class);   // adds InputMatchInterface
}
```

Plus:

- `hook_theme_registry_alter()` — repoints the `media_entity_twitter_tweet` theme hook at
  **this** module's `templates/` directory (only if it currently points at
  `media_entity_twitter/templates`).
- `hook_preprocess_media_entity_twitter_tweet()` — renders
  `media_entity_twitter/images/icons/twitter.png` (180×180) into a `placeholder` variable so
  embedded tweets are visible inside CKEditor.
- `lightning_media_twitter.install` only declares `hook_update_last_removed(): 8003`.

Validation classes: `Plugin\Validation\Constraint\TweetEmbedCodeConstraint` and
`TweetEmbedCodeConstraintValidator` (the constraint named in `input_match`).

## Configuration it installs (`config/install/`, i.e. always)

| Config | Value |
|---|---|
| `media.type.tweet` | label **Tweet**, source `twitter`, source field `embed_code` |
| `field.field.media.tweet.embed_code` | instance of the parent module's shared `media.embed_code` (`string_long`) storage |
| `field.field.media.tweet.field_media_in_library` | "Show in media library" boolean |
| `core.entity_form_display.media.tweet.{default,media_library}` | form displays |
| `core.entity_view_display.media.tweet.{default,embedded,thumbnail}` | view displays |
| `core.entity_view_display.media.tweet.media_library` (optional) | media library display |

```bash
drush config:get media.type.tweet
drush php:eval '
  $t = \Drupal\media\Entity\MediaType::load("tweet");
  print $t->getSource()->getPluginId() . " / " . $t->getSource()->getConfiguration()["source_field"] . "\n";
'   # => twitter / embed_code
```

Create a Tweet media item:

```php
use Drupal\media\Entity\Media;
Media::create(['bundle' => 'tweet', 'name' => 'Launch tweet'])
  ->set('embed_code', 'https://twitter.com/drupal/status/1234567890')
  ->save();
```

Note `embed_code` is **shared** with the Instagram media type — both are instances of the
same `media.embed_code` field storage installed by the parent module.

Parent module API (input matching, preview, `MediaHelper`):
[`../../../../5.1.x/agent/api/media-helper.md`](../../../../5.1.x/agent/api/media-helper.md).
