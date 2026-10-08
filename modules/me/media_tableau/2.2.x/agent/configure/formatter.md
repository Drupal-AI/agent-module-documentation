<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `media_tableau` field formatter

`MediaTableauEmbedFormatter` (id `media_tableau`, label "Remote Media - Tableau") formats a
**`string`** field holding a Tableau URL as an embedded `<tableau-viz>`. It extends Media
Remote's `MediaRemoteFormatterBase`, so the normal setup is a Media Remote media type whose
source string field uses this formatter on its view display.

## Settings (defaults)

| Key | Default | Meaning |
|---|---|---|
| `api_version` | `latest` | Tableau Embedding API library: `latest`, `3.6`, or `3.5` |
| `width` | `100%` | iframe width (any CSS unit) |
| `height` | `900px` | iframe height (any CSS unit) |
| `toolbar` | `0` | show the Tableau toolbar (bool) |

Stored in the view display: `core.entity_view_display.<entity>.<bundle>.<mode>` →
`content.<field>.type = media_tableau` and `content.<field>.settings.{api_version,width,height,toolbar}`.

## Set it on a display (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$vd->setComponent('field_tableau_url', [
  'type' => 'media_tableau',
  'label' => 'hidden',
  'settings' => ['api_version' => 'latest', 'width' => '100%', 'height' => '600px', 'toolbar' => 1],
])->save();
```

```bash
drush cget core.entity_view_display.node.article.default content.field_tableau_url
```

## What it renders

- The value must match the allowed-host regex
  `^(<host1>|<host2>|...)/(.*/)?(app/profile/.*/viz/.*|views/.*)`; non-matching values render nothing.
- `app/profile/<name>/viz/<id>` URLs are rewritten by `formatUrl()` to `<host>/views/<id>`.
- Output is the `media_tableau` theme hook (`templates/media-tableau.html.twig`): a
  `<tableau-viz src="...">` inside `.tableauViz-wrapper > .tableauViz-container`; when `toolbar`
  is off it adds `toolbar="hidden"`.
- The formatter attaches library `media_tableau/media_tableau_embedding.<api_version>` (the
  external Tableau Embedding API JS) plus the responsive CSS/JS.
