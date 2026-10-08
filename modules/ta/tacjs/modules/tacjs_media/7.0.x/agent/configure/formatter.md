# The `tacjs_oembed` field formatter

TacJS Media adds one field formatter and nothing else:

| Property | Value |
|---|---|
| Plugin id | `tacjs_oembed` |
| Label | "oEmbed content (TacJS integration)" |
| Class | `Drupal\tacjs_media\Plugin\Field\FieldFormatter\TacJSOEmbedFormatter` (extends core `OEmbedFormatter`) |
| Field types | `link`, `string`, `string_long` |

## Select it (UI)

On the entity's *Manage display* (e.g. `/admin/structure/media/manage/remote_video/display` or a
node bundle's display) set the video/oEmbed field's **Format** to *oEmbed content (TacJS
integration)*, then **Save**. It shares core oEmbed's settings (max width/height).

## Where it is stored / set it from code

The choice lives in the `entity_view_display` config as the field component's `type`:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');                 // or media.remote_video.default
$component = $vd->getComponent('field_video');     // an oEmbed/link/string field
$component['type'] = 'tacjs_oembed';
$vd->setComponent('field_video', $component)->save();
```

Read it back: `drush cget core.entity_view_display.node.article.default content.field_video.type`.

## What it renders

`viewElements()` calls the parent oEmbed formatter, then for each `iframe` element:

- changes `#tag` from `iframe` to `div`;
- removes `src`;
- adds a provider class — `youtube_player`, `vimeo_player`, or `dailymotion_player`;
- adds a `videoID` attribute parsed from the source URL.

tarteaucitron.js then builds the actual player **only after the visitor consents** to that
provider. So you must also enable the matching service (youtube / vimeo / dailymotion) in TacJS
(`tacjs.settings.services.<name>.status = true`) for the video to become playable.
