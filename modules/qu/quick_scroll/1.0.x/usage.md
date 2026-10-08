<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a "scroll to top" button so visitors can quickly jump back to the top of long pages.

The module is intentionally tiny: a single hook implementation (`QuickScrollHooks::preprocessHtml`, `hook_preprocess_html()`) attaches the `quick_scroll/quick_scroll` asset library to every page. That library ships the button's JavaScript (`js/quick_scroll.js`) and CSS (`css/quick_scroll.css`) and depends on `core/drupal` and `core/once`. Hook logic is registered via the modern `#[Hook]` attribute and a service (`Drupal\quick_scroll\Hook\QuickScrollHooks`).

There is nothing to configure — enable the module and the button appears site-wide. It has no routes, permissions, services beyond the hook object, or settings. Styling/positioning is adjusted by overriding the module's CSS in your theme.
---
A lightweight site-wide scroll-to-top button.
---
- Enable the module to add a scroll-to-top button on all pages.
- Help visitors return to the top of long articles quickly.
- Improve mobile UX on lengthy listing pages.
- Provide a consistent back-to-top control across the site.
- Override `css/quick_scroll.css` in your theme to restyle the button.
- Reposition the button via theme CSS overrides.
- Add a back-to-top affordance without writing JavaScript.
- Use the `quick_scroll/quick_scroll` library on custom pages.
- Rely on `core/once` to avoid duplicate button binding.
- Give long documentation pages an easy top navigation.
- Enhance blog/news pages with a return-to-top button.
- Disable the button site-wide by uninstalling the module.
- Keep the button behavior consistent with core Drupal JS APIs.
- Improve accessibility of long single-page layouts.
- Add the control to search-results pages automatically.
- Provide a quick-scroll button on forum/thread pages.
- Attach the feature globally via `hook_preprocess_html`.
- Ship a no-config UI enhancement to editors.
- Restyle button color/size to match brand via CSS.
- Remove the button on specific pages by conditionally unsetting the library in a subtheme.