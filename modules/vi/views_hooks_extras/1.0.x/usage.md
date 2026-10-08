<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
views_hooks_extras is a developer helper that re-dispatches core Views hooks as extra, more specific hook names keyed by View ID (and optionally display ID), so modules can target a single view/display without a wall of `if ($view->id() === ...)` conditionals.
---
For each supported core hook, the module implements the standard hook and then calls `Drupal::moduleHandler()->invokeAll()` on generated names of the form `hook_extra_views_VIEW_ID_<suffix>` and, when a display can be inferred, `hook_extra_views_VIEW_ID__DISPLAY_ID_<suffix>` (display ID is snake-cased, e.g. `page-1` → `page_1`). Name generation lives in `HookNames::generate()/generateByString()` with string helpers in `Strings`. Reference-passed arguments are preserved (e.g. `&$args` for pre_view, `&$output` for post_render, `&$rows` for preview_info_alter), so implementations can alter them just like the native hook.

Supported hooks: `views_query_substitutions`, `views_pre_view`, `views_pre_build`, `views_post_build`, `views_pre_execute`, `views_pre_render`, `views_post_render`, `views_query_alter`, `views_preview_info_alter`. It only requires Views, adds no routes, permissions, services, or config, and runs entirely within the normal Views execution path — it merely fans core hook invocations out to view-specific hook names your modules implement.
---
- Alter a single view without checking `$view->id()` everywhere
- Target one specific display of a view with its own hook
- Implement `hook_extra_views_<id>_pre_view` for one view
- Implement a display-scoped `hook_extra_views_<id>__page_1_query_alter`
- Modify the query for just one view via `_query_alter` extra hook
- Change pre-view arguments (`&$args`) for a single view
- Adjust `&$output` in post_render for one view only
- Tweak preview info rows (`&$rows`) for a specific view
- Swap query substitutions per view
- Keep custom module hook implementations small and readable
- Avoid brittle conditional logic in shared Views hooks
- Snake-case display IDs automatically in hook names (page-1 → page_1)
- Register both view-wide and display-specific handlers
- Document available extras via the bundled `.api.php`
- Fan out `views_pre_build` / `post_build` per view
- Provide targeted `views_pre_execute` / `views_pre_render` logic
- Organize view-specific behaviour across multiple modules cleanly
