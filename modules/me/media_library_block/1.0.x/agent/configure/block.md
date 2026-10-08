# The Media Library Block plugin

## Plugin & derivatives

- Base block plugin id: `media_library_block`, category *Media*, `deriver =
  MediaLibraryBlockDeriver`.
- The deriver reads `entity_type.bundle.info` for `media` and produces **one derivative per media
  bundle**, id `media_library_block:<bundle>`, `admin_label` = the bundle label.
- Place a derivative like any block (Block layout UI at `admin/structure/block`, or Layout Builder).

## Block form (`blockForm`)

| Field | `#type` | Notes |
|---|---|---|
| `media` | `media_library` | Restricted to `#allowed_bundles => [<bundle>]`, `#cardinality => 1`, required. Provided by the `media_library_form_element` contrib module. |
| `view_mode` | `select` | Options from `entityDisplayRepository->getViewModeOptionsByBundle('media', <bundle>)`. |

`blockSubmit` stores the **first** selected media id (the element can return a comma-separated list like
`3,6,12` even at cardinality 1, so it does `explode(',', $value)[0]`) and the chosen view mode.

## Configuration keys (`defaultConfiguration`)

```php
[
  'media' => '',          // selected media entity id (string)
  'view_mode' => 'default',
]
```

## Render & access (`build`)

- Loads the media via `entityTypeManager->getStorage('media')->load($id)`.
- Calls `$media->access('view', NULL, TRUE)`; **renders only if allowed**. If access is denied the
  block builds empty (access cacheability still merged in).
- Renders through the `media` view builder in the configured view mode (`getViewmode()`, falls back to
  `full`), then merges cacheable metadata from the media, the render array, and the access result.

## Config dependencies (`calculateDependencies`)

Adds dependencies on: the selected media entity, `core.entity_view_display.media.<bundle>.<view_mode>`,
and `media.type.<bundle>` — so the block placement exports/imports cleanly.
