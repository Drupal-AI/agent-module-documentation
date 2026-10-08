<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# lb_claro — theming

The module is essentially a styling layer over Layout Builder. It works in three moves, all in
`lb_claro.module`.

## 1. CSS libraries attached to Layout Builder forms (`hook_form_alter`)

`lb_claro.libraries.yml` defines four libraries, each a single theme-weighted CSS file
(`{ weight: 1000 }` so they load after theme CSS):

| Library | File |
|---|---|
| `lb_claro/layout_builder` | `css/layout-builder.css` |
| `lb_claro/off_canvas` | `css/off-canvas.css` |
| `lb_claro/media_library` | `css/media-library.css` |
| `lb_claro/entity_forms` | `css/entity-forms.css` |

`lb_claro_form_alter()` attaches these — plus core `claro/global-styling`,
`claro/claro.drupal.dialog`, `claro/media_library.theme` — to any form whose form object is a
Layout Builder `OverridesEntityForm` or `DefaultsEntityForm`, or whose form id is
`layout_layout_builder_form`. That last form (the layout-library save form) additionally gets the
CSS class `layout-builder-form` on its wrapper.

## 2. Stripping conflicting CSS on Layout Builder routes (`hook_css_alter`)

`lb_claro_css_alter()` runs only when the current route matches `^layout_builder\.` (regex). On
those routes it:

- Removes **all** Claro CSS files except an allowlist it keeps: `base/variables.css`,
  `components/toolbar.module.css`, `state/toolbar.menu.css`, `theme/toolbar.theme.css`,
  `theme/toolbar.icons.theme.css`, `components/icon-link.css`, `components/dialog.css`,
  `theme/media-library.css`.
- Removes Stable/Stable9 `layout_builder/layout-builder.css` and the six
  `core/dialog/off-canvas.*` reset/base/table/form/button/details stylesheets.
- Removes core jQuery UI `dialog.css` and `theme.css`.

The point is to clear the resets and defaults so the module's own stylesheets style the tray and
canvas without a reset fight. (See the comment block in `css/off-canvas.css` referencing core
issue #2952390 — CKEditor in off-canvas — as the reason the reset file is dropped.)

## 3. Media-library template overrides (`hook_theme_registry_alter`)

`lb_claro_theme_registry_alter()` re-points several media-library theme hooks at Claro's **own**
templates (using `\Drupal::service('extension.list.theme')->getPath('claro')`), so the media
library inside Layout Builder renders with Claro markup:

| Theme hook | Template | Path (under Claro) |
|---|---|---|
| `views_view__media_library__widget` | `views-view--media-library` | `templates/media-library` |
| `views_view__media_library__widget_table` | `views-view--media-library` | `templates/media-library` |
| `views_view_unformatted__media_library` | `views-view-unformatted--media-library` | `templates/media-library` |
| `media_library_wrapper` | `media-library-wrapper` | `templates/classy/media-library` |
| `container__media_library_content` | `container--media-library-content` | `templates/classy/media-library` |
| `media__media_library` | `media--media-library` | `templates/media-library` |

The first three are cloned from the existing `views_view` / `views_view_unformatted` registry
entries and then re-templated; the rest just override `template` + `path` on the existing hook.

## Overriding in your own theme

- The four CSS libraries are ordinary assets — override or extend them from your theme with
  `libraries-override` / `libraries-extend` in your theme's `.info.yml`, or ship your own weighted
  CSS that loads after them.
- To re-take control of the media-library templates, provide your own template suggestions in your
  theme (your theme's `hook_theme_registry_alter` or template files run after module-level ones for
  path resolution, and theme templates win over module templates for the same suggestion).
- No dedicated theme hooks or render elements are defined by this module beyond the registry
  re-pointing above; there is no `templates/` directory shipped in the module itself.
