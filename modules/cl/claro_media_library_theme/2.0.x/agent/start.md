<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add Claro Media Library to Theme (claro_media_library_theme) — agent index

Injects **Claro's media library templates, preprocessing and CSS into the active theme's
registry**, so the library renders with full Claro styling even when opened outside the admin
theme. Depends on core `media_library`. Version **2.0.0-beta1** (beta), **not covered** by the
security advisory policy.

**It is a module, not a theme.** Despite the project name and `package: Theme`, the `.info.yml`
declares `type: module`. It ships no templates of its own — it points the active theme at
**core Claro's** template files.

**Core requirement is `^11.4` — pinned to a single minor.** Exceptionally tight; re-check at every
core update. (The `1.x` branch targets D8–D10; this `2.0.x` branch is D11.4+ only.)

## The symptom it fixes

The media-library modal's Twig templates and preprocessing live in **Claro**. Opened from an
admin-theme form it looks right. Opened from anything rendered in the **front-end theme** — an
inline entity form, a Layout Builder off-canvas dialog, front-end editing, a custom form on a
public page — those theme hooks are absent from the active theme's registry, the grid collapses
into an unstyled list, and the add form loses its layout. The common workaround is copying Claro's
templates into the front-end theme, which then drifts from core on every update. This module adds
them to the active theme's registry instead, so core stays the single source.

## Mechanism (all in `claro_media_library_theme.module`)

- Bootstraps by `require_once`-ing `core/themes/claro/claro.theme` (or the individual Claro hook
  classes) so Claro's functions/classes exist while Claro is not the active theme.
- `hook_theme_registry_alter()` registers Claro's media-library theme hooks (media,
  `media--media-library`, `media_library_wrapper`, `media_library_item` + `--small`/`--widget`,
  the media-library views templates, `fieldset--media-library-widget`, `links--media-library-menu`,
  the add-form `item_list`/`details`/`container` hooks) against Claro's template paths, guarded by a
  `templateExists()` `file_exists()` check; then a `force_claro_templates()` step `array_replace`s
  existing core hooks so they use Claro's templates and preprocess chains.
- `hook_library_info_alter()` appends the module's compatibility CSS library to the `media_library`
  `widget` / `view` / `ui` libraries.
- `hook_form_alter`, three `hook_form_FORM_ID_alter` (add / upload / oembed forms) and
  `hook_views_pre_render` attach the library and manually invoke Claro's own alter/preprocess —
  trying the procedural `claro_*` function first, else calling Drupal 11.4's `ClaroHooks` /
  `ClaroFormHooks` OOP hook-class methods.
- `css/claro_media_library_theme.css`: a handful of static rules (hide the compact-widget weight
  toggle, center previews, dialog spacing) for non-Claro active themes.

No configuration UI, no permissions, no services, no Drush commands. A candidate for removal if a
future core release moves the library's theming out of the admin theme. **Confirm the symptom is
actually present before installing** — it only appears where the library opens outside the admin
theme.

## Detail docs

- [theme/mechanism.md](theme/mechanism.md) — how the theme-registry injection and Claro-hook
  delegation work, and what to check when it breaks.
