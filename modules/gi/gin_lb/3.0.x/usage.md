<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gin Layout Builder re-skins Drupal's Layout Builder UI — and the off-canvas dialogs and Media Library it opens — with the Gin admin theme's look, even when Layout Builder is being edited inside a front-end theme.

---

The problem it solves is that Layout Builder's editing UI renders in the **front-end** theme, so a site using Gin for admin still gets an unstyled Layout Builder. Gin Layout Builder fixes that without switching themes: a `gin_lb.context_validator` service decides whether the current request is a Layout Builder route (route name matching `/^(layout_builder\.([^.]+\.)?)/`) and whether the active theme is one it should style (it deliberately does **nothing** when Gin or a Gin sub-theme is already active). When both hold, `hook_page_attachments()` attaches the module's CSS/JS libraries, `hook_form_alter()` flags known Layout Builder and Media Library forms with `#gin_lb_form` and a `glb-form` class, and `hook_theme_suggestions_alter()` appends a `__gin_lb` suffix to every theme suggestion on those elements so ~35 bundled `*--gin-lb.html.twig` templates take over. To avoid colliding with the front-end theme, every bundled style is prefixed `glb-`; a Twig function `glb_classes()` rewrites element classes to their `glb-`-prefixed equivalents where a prefixed style exists, and `hook_css_alter()` strips core's off-canvas and Claro component CSS that would otherwise fight it. A small settings form at `/admin/config/gin_lb/settings` (route `gin_lb.gin_lb_settings_form`, config object `gin_lb.settings`) controls how Toastify is loaded, whether the region preview is on by default, whether Layout Builder's "Discard changes" and "Revert to defaults" buttons are hidden, and whether saving a layout keeps you on the edit page. Two alter hooks (`hook_gin_lb_show_toolbar_alter`, `hook_gin_lb_is_layout_builder_route_alter`) let other modules extend the route detection — needed for things like Page Manager. It defines no plugins, no permissions and no Drush commands, and the optional `gin_lb_plus` submodule layers a more opinionated block/section picker on top.

---

- Give Layout Builder the Gin admin look on a site whose front-end theme is Olivero or a custom theme.
- Make the Layout Builder off-canvas "Add block" / "Configure section" dialogs readable instead of unstyled.
- Style the Media Library modal that Layout Builder opens from inside a front-end theme.
- Hide Layout Builder's "Discard changes" button from editors who should not use it.
- Hide the "Revert to defaults" button on a per-site basis.
- Keep the editor on the layout edit page after saving instead of bouncing to the entity view.
- Restore Layout Builder's default post-save redirect by switching `save_behavior` to `default`.
- Turn on Layout Builder's region preview by default for every editor.
- Load Toastify from a CDN, from a Composer-installed copy, or not at all on a CSP-restricted site.
- Serve Toastify locally instead of a CDN to satisfy a strict Content Security Policy.
- Avoid the front-end theme's own CSS bleeding into the layout editing UI via the `glb-` class prefix.
- Prevent core off-canvas CSS from overriding the Gin dialog styling.
- Extend route detection so Layout Builder embedded in Page Manager is styled too, with `hook_gin_lb_is_layout_builder_route_alter()`.
- Suppress the Gin toolbar on a specific embedded Layout Builder screen with `hook_gin_lb_show_toolbar_alter()`.
- Override one of the module's `*--gin-lb.html.twig` templates in your own theme to tweak a widget.
- Stop a custom front-end theme's `hook_theme_suggestions_alter()` from fighting the module (early-return on `$variables['element']['#gin_lb_form']`).
- Ship a consistent admin editing experience across Layout Builder, Media Library and CKEditor dialogs.
- Style Section Library's "add section/template to library" forms, which the module lists explicitly.
- Give the layout editing screen Gin's dark-mode-aware look without changing the site's admin theme.
- Apply Gin styling to Views exposed filters inside the Media Library widget.
- Use `glb_classes()` in a custom Twig template to opt an element into the prefixed styles.
- Detect from code whether the current request is a Layout Builder route via `gin_lb.context_validator`.
- Determine whether a given form ID is one the module styles, using `isLayoutBuilderFormId()`.
- Skip the module's work entirely on sites already using Gin as their front-end theme (it self-disables).
- Pair with `gin_lb_plus` to get a tabbed, icon-driven block and section picker.
- Roll the settings out through configuration management by exporting `gin_lb.settings`.
