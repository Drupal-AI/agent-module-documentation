<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NG Lightbox — agent index

Turns links whose path matches a pattern into core AJAX dialog links (`use-ajax` +
`data-dialog-type`). Depends on core `path_alias`.

- **Every setting, its default, the admin form and drush equivalents** →
  [configure/settings.md](configure/settings.md)
- **The `ng_lightbox` service, `hook_link_alter()`, the attributes added, renderer discovery** →
  [api/service-and-link-alter.md](api/service-and-link-alter.md)
- **Force the lightbox on/off per link** →
  [hooks/ajax-path-alter.md](hooks/ajax-path-alter.md)

Key facts:

- Config object `ng_lightbox.settings` (defaults from `config/install`):
  `patterns: ''`, `default_width: 700`, `lightbox_class: ''`, `skip_admin_paths: true`,
  `renderer: 'drupal_modal'`.
- Configure route `ng_lightbox.settings` → `/admin/config/media/ng-lightbox`,
  permission **`administer ng lightbox`** (`restrict access: true`).
- Service id `ng_lightbox` → `Drupal\ng_lightbox\NgLightbox`
  (`isNgLightboxEnabledPath(Url $url): bool`, `addLightbox(array &$link): void`).
- Renderer options come from the `ng_lightbox_renderers` container parameter, built by
  `NgLightboxPass` from services tagged `render.main_content_renderer` with an `ng_lightbox`
  attribute — core gives `drupal_modal` => "Core Modal" and `drupal_dialog` => "Core Dialog".
- Manual opt-in: add the class `ng-lightbox` to any anchor.
- No Drush commands, no plugins, no submodules. `patterns: ''` (the default) means the module
  lightboxes nothing until you configure it.
