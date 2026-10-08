<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Link Destination lets site builders flag menu links so they automatically carry a `destination` query parameter — taking it from the current page's own `destination` parameter if present, otherwise setting it to the current page URL — so that after the link's action (e.g. login, edit) the user is returned to where they were.

For YAML-defined links, adding `destination: true` to the link definition is picked up by `hook_menu_links_discovered_alter()`, which stores `options.menu_link_destination = TRUE`. For `menu_link_content` links, a form alter adds an "Add a destination query parameter" checkbox whose value is written into the link's `options` via an entity builder. At render time `hook_link_alter()` checks that flag and, unless an explicit `destination` is already set, injects `query.destination` from the core `redirect.destination` service (the current request's path/destination). Because links that carry the current URL vary per page, `MenuLinkDestination::preRenderLink()` (a `TrustedCallbackInterface` pre-render callback wired via `hook_element_info_alter()`) applies a `url` cache context so such links are cached correctly.

The module has **no routes, permissions, or services of its own**; configuration is on the standard admin menu-link form or in module YAML. The destination value comes from Drupal core's `redirect.destination` service, and Drupal core's redirect handling only honours internal destinations (external `destination` values are rejected by core when the redirect is performed), so this does not introduce an open-redirect beyond core's existing, guarded behaviour. The main correctness concern it explicitly handles is cacheability (the `url` cache context).
---
No routes/permissions/services of its own — configured via menu-link YAML (`destination: true`) or the admin menu-link form checkbox. Destination comes from core `redirect.destination`; core rejects external destinations on redirect, so no new open-redirect. Adds a `url` cache context to affected links for correct caching. Requires core >= 10; `menu_link_content` needed only for the UI checkbox.
---
- Return a user to the current page after a menu-triggered login.
- Add `destination: true` to a YAML menu link so it carries a destination.
- Enable the "Add a destination query parameter" checkbox on a content menu link.
- Preserve an existing `destination` from the current URL onto the link.
- Set the current page as the destination when none is present.
- Send users back to their prior page after an edit/action link.
- Avoid hand-appending `?destination=` to menu links.
- Keep "log in / log out" menu links context-aware of the current page.
- Provide return-to-page behaviour for admin action links in a menu.
- Respect an explicitly configured `destination` (won't override it).
- Ensure destination-bearing links get a `url` cache context for correctness.
- Configure the behaviour per individual menu link, not site-wide.
- Use it for language-switcher-style links that should return in place.
- Add return-to behaviour to custom module-defined menu links via YAML.
- Combine with core menus without extra query-string plumbing.
- Keep menu links cacheable while still varying by current URL.
- Drive "back to where you were" UX from the menu system.
- Support both YAML and menu_link_content links with one mechanism.
