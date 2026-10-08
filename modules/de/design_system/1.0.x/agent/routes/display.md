<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display route & controller

## Route
`design_system.design_system` (`design_system.routing.yml`):
- Path `/admin/design-system`, title `Design System`.
- `_controller: DesignSystemController::displayDesignSystem`.
- `requirements._permission: 'access design system'`.
- `options._admin_route: TRUE` (renders inside the admin theme).

## Controller
`src/Controller/DesignSystemController.php` (`DesignSystemController extends ControllerBase`).

- `displayDesignSystem()` returns a render array of a single `html_tag` `iframe`:
  `width: 100%`, `height: auto`, `seamless`, `frameborder: 0`,
  `style: 'height: calc(100vh - 250px);'`, and `src` from `designSystemUrl()`.
- `designSystemUrl()` reads `design_system.settings:design_system_url` and returns
  `Url::fromUri($url)->setAbsolute()->toString()`.

The iframe `src` is the administrator-configured URL (set via the settings form, which requires
`administer site configuration`); the browser loads it client-side. It is not derived from the
request, so a viewer with `access design system` cannot change what is embedded.

## Menu / toolbar
- `design_system.links.menu.yml` adds `design_system.admin_design_system` under `system.admin`
  (weight 10, wrapper class `design-system`) pointing at this route, plus the settings-form link
  under `system.admin_config_ui`.
- `hook_page_attachments()` (`design_system.module`) attaches `design_system/admin_toolbar_icon`
  on every page and, when `gin_toolbar` is enabled and active, `design_system/gin_admin_toolbar_icon`
  (icon CSS in `css/admin_toolbar_icon.css` / `css/gin_admin_toolbar_icon.css`).

## Operating
- Grant `access design system` to roles that should view the embedded page.
- Ensure the target design system permits framing (X-Frame-Options / CSP `frame-ancestors`) if it
  is on another origin, or the iframe will be blocked by the browser.
