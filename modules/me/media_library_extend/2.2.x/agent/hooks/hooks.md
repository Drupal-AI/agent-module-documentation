<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks

The module does not ship a `.api.php`. The one alter hook it invites comes from the plugin
manager's `alterInfo('media_library_source_info')`:

## `hook_media_library_source_info_alter(array &$definitions)`
Alter discovered `MediaLibrarySource` plugin definitions before they are cached. Each
`$definitions[$id]` is the annotation data (`id`, `label`, `class`, `source_types`, plus any
extra annotation keys). Use it to add/remove source types, relabel, or inject custom
annotation keys (the annotation class notes extra keys may be defined this way).

```php
function my_module_media_library_source_info_alter(array &$definitions) {
  if (isset($definitions['lorem_picsum'])) {
    $definitions['lorem_picsum']['source_types'][] = 'oembed:video';
  }
}
```

## Theme hooks (`hook_theme`, in the `.module`)
For overriding markup rather than behaviour (see [theming via templates]):
- `media_library_pane` (template `media-library-pane.html.twig`) — pane wrapper; preprocess
  moves `filters`/`content`/`actions` and the form ids to the root.
- `media_library_pane_content` (template `media-library-pane-content.html.twig`) — the
  paged preview grid (`result_count`, `previews`, `pager`, `form_selection`).
- `media_library_result_preview` (template `media-library-result-preview.html.twig`) —
  a single result (`id`, `label`, `preview`).

No other invoke/alter hooks are defined by this module.
