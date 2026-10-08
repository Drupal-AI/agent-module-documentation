# Programmatic API — provider manager & field value

## The provider manager — `video.provider_manager`

`Drupal\video\ProviderManager` (extends `DefaultPluginManager`, implements
`ProviderManagerInterface`, `MapperInterface`).

```php
/** @var \Drupal\video\ProviderManager $pm */
$pm = \Drupal::service('video.provider_manager');

$options = $pm->getProvidersOptionList();          // ['youtube' => 'YouTube', ...]
$defs    = $pm->loadDefinitionsFromOptionList($allowed);  // filter by a checkbox map

// Which provider handles a URL? Returns ['definition' => …, 'matches' => …] or FALSE.
$match = $pm->loadApplicableDefinitionMatches($defs, 'https://youtu.be/abc123');
$id    = $match['matches']['id'];                  // captured video id

// Instantiate the provider for a stored file (used by the embed formatter):
$provider = $pm->loadProviderFromStream($scheme, $file, $metadata, $settings);
$render   = $provider->renderEmbedCode($formatter_settings);
```

Definitions carry `regular_expressions`, `mimetype`, and `stream_wrapper` (see
[plugins/video.md](../plugins/video.md)).

## The field value

The `video` field type extends core `Drupal\file\Plugin\Field\FieldType\FileItem`, so items
expose a `target_id` (the referenced `file` entity id) plus a `data` string column holding
serialized provider match metadata for embeds. Read/set it like any file field item:

```php
$node->set('field_video', ['target_id' => $file->id(), 'data' => serialize($matches)]);
```

For **embeds**, the file URI uses the provider scheme, e.g. `youtube://<id>`; for **uploads**
it is a normal `public://` / `private://` path. `VideoItem::generateSampleValue()` produces a
random `.mp4` sample.

## Stream wrappers

The module registers read-only stream wrappers for each provider scheme (`youtube`, `vimeo`,
`dailymotion`, `vine`, `instagram`, `facebook`) via tagged services in `video.services.yml`.
`VideoRemoteStreamWrapper` is the shared base. `video_file_access()`
(`hook_ENTITY_TYPE_access`) grants `view` on files stored under a provider scheme to anyone
with `access content`.

## Theme

`hook_theme()` defines `video_player_formatter` (variables: `items`, `player_attributes`),
rendered by `templates/video-player-formatter.html.twig` for the HTML5 formatters.

## Migration

`Drupal\video\Plugin\migrate\field\VideoItem` (`@MigrateField id = "video"`, `core = {7}`)
maps Drupal 7 `video` widgets/formatters into the D10/D11 field.
