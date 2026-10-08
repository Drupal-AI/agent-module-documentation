<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sticky makes any element on your site stay visible while the page scrolls by applying the Sticky JS library (stickyjs.com) to a CSS/DOM selector you configure — typically a header, footer, or main menu.

---

The module is a thin Drupal wrapper around the third-party **garand/sticky** jQuery plugin. It exposes a single admin settings form at `/admin/config/system/sticky` (route `sticky.sticky_settings_form`, permission `administer sticky`) whose values are stored in the `sticky.settings` config object. On every page `sticky_page_attachments()` asks the `sticky.manager` service (`StickyManager::getJsSettings()`) for those settings, pushes them into `drupalSettings.sticky`, and attaches the `sticky/sticky` library — which in turn depends on the external library file at `/libraries/sticky/jquery.sticky.js` that you must download and place yourself. The site-wide **DOM selector** (default `.menu--main`) decides which element becomes sticky; the remaining options mirror the plugin's parameters: `top_spacing` / `bottom_spacing` (px gaps), `class_name` (added when stuck, default `is-sticky`), `wrapper_class_name` (default `sticky-wrapper`), `center`, `get_width_from`, `width_from_wrapper`, `responsive_width`, and `z_index` (default `auto`). It is a global, single-selector configuration — there is no per-page or per-block UI, no plugin types, no Drush, and no dependencies on other Drupal modules. Because the actual behavior is delivered by the JS library, the element you target must exist in the rendered markup and the library must be installed.

---

- Keep the main navigation menu fixed to the top of the viewport while users scroll.
- Make a site header stay visible on scroll for persistent branding/navigation.
- Pin a footer or call-to-action bar to the bottom of the page.
- Turn a sidebar block into a sticky element that follows the scroll.
- Add a small gap below a fixed admin/toolbar with `top_spacing` so the sticky element clears it.
- Keep a promotional banner visible as the user reads down a long page.
- Make a table of contents stick alongside long-form content.
- Target any element by CSS selector (`.header-wrapper`, `#footer`, `.menu--main`).
- Apply a custom "stuck" state class (`class_name`, default `is-sticky`) for theming when the element is fixed.
- Style the generated placeholder wrapper via `wrapper_class_name` (default `sticky-wrapper`).
- Horizontally center the sticky element with the `center` option.
- Constrain the sticky element's width to match its wrapper (`width_from_wrapper`).
- Derive the sticky element's width from another element with `get_width_from`.
- Recalculate widths on window resize for responsive layouts (`responsive_width`).
- Control stacking order over other page elements with `z_index`.
- Add a bottom gap before the element unsticks near the page end (`bottom_spacing`).
- Provide a persistent shopping or search bar on a storefront.
- Keep a language switcher or utility bar always reachable.
- Configure the whole behavior via exported `sticky.settings` config for deployment.
- Change the sticky target per environment by overriding the DOM selector in settings.
- Restrict who can change sticky behavior with the `administer sticky` permission.
- Make a cookie-consent or notice bar remain on screen until dismissed.
- Give editors a no-code way to pin a themed element by asking a developer to set the selector once.
