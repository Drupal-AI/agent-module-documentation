<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content filter adds dedicated per-content-type management pages inside the Content administration area, so editors get a focused listing page for each node type instead of the mixed default content overview.

---

For each content type selected on the settings form (`/admin/config/user-interface/content-filter`, permission `administer content_filter`), the module produces a page at `/admin/content/filtered/{node_type}` that embeds the core `content` view (`views_embed_view('content')`) with the content-type filter locked to that bundle and hidden. A parent index lives at `/admin/content/filtered` (permission `access administration pages`, an admin route). Optionally the module adds submenu links under the Content menu via a derivative + `hook_menu_links_discovered_alter`; if disabled, the pages remain reachable as sub-tabs. Hooks (`hook_views_pre_view`) inject an *Add {bundle}* button into the view header and swap in the locked bundle filter.

The embedded `content` view enforces its own access, and the routes are gated by `access administration pages`. The *Add* button is built with the Link API and rendered via the renderer, and page titles pass the bundle label through `t()` placeholders — there is no raw concatenation of user input into markup, so no XSS-bypass surface. The only mutation is admin config (which content types get pages, and whether menu links are added). The module creates no content types and does not alter permissions or text formats.

---
- Enable the module and open `/admin/config/user-interface/content-filter`.
- Select which content types get their own admin page.
- Toggle whether submenu links appear under the Content menu.
- Visit `/admin/content/filtered` for the index of filtered pages.
- Open `/admin/content/filtered/{node_type}` for one content type.
- Give editors a focused listing per content type.
- Use the injected *Add {bundle}* button to create content.
- Keep the content-type filter locked and hidden per page.
- Reduce clutter on sites with many content types.
- Access pages as sub-tabs when menu links are disabled.
- Grant `administer content_filter` to site builders.
- Use the familiar core content view filters/actions per page.
- Add quick-jump Content submenu items for editors.
- Verify the default `content` view is enabled (required).
- Avoid modifying existing content, permissions or text formats.
- Combine with role permissions to scope who sees the pages.
