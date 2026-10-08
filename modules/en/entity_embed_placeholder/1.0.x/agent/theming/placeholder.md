<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The embed-preview placeholder (theming)

This module has no configuration — everything it does is in the theme layer. All behaviour is in
`entity_embed_placeholder.module`.

## Theme suggestions (only on the embed-preview route)

```php
// hook_theme_suggestions_node_alter / _media_alter
if (\Drupal::routeMatch()->getRouteName() === 'embed.preview') {
  $suggestions[] = 'node__embed_preview';   // or 'media__embed_preview'
}
```

So the placeholder templates are used **only** when Entity Embed renders its in-editor preview
(route `embed.preview`) — never on the front-end display of a node/media.

## Theme hooks & templates

```php
// hook_theme()
'node__embed_preview'  => ['template' => 'node--embed-preview',  'base hook' => 'node',
                          'library' => 'entity_embed_placeholder/embed-preview'],
'media__embed_preview' => ['template' => 'media--embed-preview', 'base hook' => 'media'],
```

Templates (`templates/`):

- `node--embed-preview.html.twig`
  ```twig
  <div class="embedded-entity-placeholder contextual-region">
    <h2>{{ label }} </h2>
    <p>({{ node.type.entity.label }})</p>
  </div>
  ```
- `media--embed-preview.html.twig` — same wrapper, uses `{{ name }}` and `{{ media_bundle_label }}`
  (that variable is set by `hook_preprocess_media()`:
  `$variables['media_bundle_label'] = $variables['media']->bundle->entity->label();`).

Note: the registered `library` key for `node__embed_preview` is
`entity_embed_placeholder/embed-preview`, but the module's `.libraries.yml` only defines the
`common` library — so that named library is effectively a no-op. The styling that actually applies
comes from `common`.

## CSS library

`entity_embed_placeholder/common` → `css/entity_embed_placeholder.css`, which styles
`.embedded-entity-placeholder` (grey box, `height: 220px`, centered, ellipsised heading). Via
`hook_library_info_alter()` this library is appended to Entity Embed's `entity_embed/entity_embed`
library dependencies, so it loads wherever Entity Embed's editor UI loads:

```php
if ($extension === 'entity_embed' && isset($libraries['entity_embed'])) {
  $libraries['entity_embed']['dependencies'][] = 'entity_embed_placeholder/common';
}
```

You can confirm this at runtime: the `entity_embed/entity_embed` library's dependencies include
`entity_embed_placeholder/common`.

## Overriding the placeholder

Three documented approaches (README):

1. **Override the template in a theme/module** — copy `node--embed-preview.html.twig` (or the media
   one) into your theme's `templates/` and edit it. Clear cache, and re-embed a fresh entity.
2. **Repoint the theme hook via `hook_theme_registry_alter()`** in a custom module:
   ```php
   function my_module_theme_registry_alter(&$theme_registry) {
     $path = \Drupal::service('extension.list.module')->getPath('my_module');
     $theme_registry['node__embed_preview']['path'] = $path . '/templates';
     $theme_registry['node__embed_preview']['template'] = 'node-embed-custom';
   }
   ```
3. **CKEditor stylesheet** — add a `ckeditor5-stylesheets` entry in your theme's `.info.yml` to
   restyle `.embedded-entity-placeholder` inside the editing surface.

There are no other extension points — no hooks invited, no config, no services.
