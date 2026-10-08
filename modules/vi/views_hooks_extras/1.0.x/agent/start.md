<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# views_hooks_extras (views_hooks_extras) — agent index

**Re-dispatches core Views hooks as `hook_extra_views_VIEW_ID[__DISPLAY_ID]_<suffix>` so alterations can target one view/display.**

- **Version:** 1.0.x (info.yml: 1.0.0) · **Core:** `^8 || ^9 || ^10 || ^11` · **Depends:** `views`
- **How:** each core hook impl calls `Drupal::moduleHandler()->invokeAll()` on names from `HookNames::generate()`; display ID is snake-cased (`Strings::toSnakeCase`). Reference args (`&$args`, `&$output`, `&$rows`) preserved.
- **Supported:** `views_query_substitutions`, `views_pre_view`, `views_pre_build`, `views_post_build`, `views_pre_execute`, `views_pre_render`, `views_post_render`, `views_query_alter`, `views_preview_info_alter`.
- **API reference:** `views_hooks_extras.api.php`.
- **Security:** Pure developer API — no routes, permissions, services, config, or external I/O. Invokes only hook implementations already present in enabled modules; no security-relevant surface.

See [hooks/extra-hooks.md](hooks/extra-hooks.md)
