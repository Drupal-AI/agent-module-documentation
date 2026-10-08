<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Content filter

## Settings form
`/admin/config/user-interface/content-filter` (perm `administer content_filter`), config `content_filter.settings`:
- Selected content types → each gets a `/admin/content/filtered/{node_type}` page.
- `content_filter_menus` (bool) → whether to add submenu links under the Content menu (`hook_menu_links_discovered_alter` disables `content_filter.main` when off).

## How a page is built
- Route `content_filter.filtered` → `ContentPageController::getBlockContents()` validates the bundle exists then returns `views_embed_view('content')`.
- `ContentFilterHooks::viewsPreView()` (on the `content` view for route `content_filter.filtered`):
  - injects an *Add {bundle}* button into the view header (`CFService::getHeaderButton`, built with the Link API), and
  - locks the `type` filter to the current bundle and hides it (`CFService::alterViewFilters`).
- `MenuIndexController::getContent()` renders the default system admin-block page for `/admin/content/filtered`.

## Requirements & safety
- The core `content` view must be enabled.
- Access: admin routes only (`administer content_filter`, `access administration pages`); the embedded view applies its own access checks.
- No XSS surface: markup comes from the Link API / `t()` placeholders, not string concatenation of user input.
