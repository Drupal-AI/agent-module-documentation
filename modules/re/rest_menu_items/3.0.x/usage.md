<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST menu items exposes a Drupal menu tree over a REST endpoint (`/api/menu_items/{menu_name}`), returning the menu's links as nested JSON/XML so a decoupled front end can render site navigation from the menu name alone.

---

The module adds a single REST resource plugin, `rest_menu_item`, served at
`/api/menu_items/{menu_name}` where `{menu_name}` is a menu machine name (e.g. `main`,
`footer`, `account`). The required `_format` query parameter selects `json`, `hal_json`, or
`xml`, and optional `max_depth` / `min_depth` parameters limit which levels of the tree are
returned; children are nested under a `below` key. Which fields each item carries (`key`,
`title`, `uri`, `alias`, `external`, `absolute`, `relative`, `existing`, `weight`, `expanded`,
`enabled`, `uuid`, `options`, …) is controlled by the `output_values` config, and any custom
fields on `menu_link_content` entities (image, entity reference, etc.) are added automatically.
Site-wide behaviour is set on a small config object `rest_menu_items.config` via the settings
form at `/admin/config/services/rest_menu_items` (permission `administer rest menu items`):
`allowed_menus` restricts which menus may be requested (empty = all; a disabled menu returns
403), `base_url` overrides the domain used for `absolute` URLs (handy for decoupled setups),
and `add_fragment` appends anchor fragments to URL output. Responses are cached with proper
cache tags and vary by permission. Two alter hooks
(`hook_rest_menu_items_resource_manipulators_alter`, `hook_rest_menu_items_output_alter`) let
you reshape the tree or the output. Like any core REST resource it must be enabled (via REST
UI or config) and the `restful get rest_menu_item` permission granted before it responds.

---

- Serve the main menu as JSON to a React/Vue/Next front end from `/api/menu_items/main?_format=json`.
- Build a headless site's primary navigation without hardcoding links in the front end.
- Return the footer menu for a decoupled footer component.
- Expose the account/user menu to a SPA to render logged-in navigation.
- Limit a request to the top level only with `max_depth=1`.
- Skip the top level and return a subtree with `min_depth=2`.
- Retrieve menus as XML (`_format=xml`) for a system that consumes XML.
- Use `hal_json` to get HAL+JSON with hypermedia links.
- Rewrite absolute URLs to a separate API/front-end domain using the `base_url` setting.
- Restrict which menus are exposed over REST via `allowed_menus` (e.g. never expose the admin menu).
- Get a 403 for menus you deliberately excluded from `allowed_menus`.
- Trim the JSON to just the fields you need by configuring `output_values`.
- Include custom `menu_link_content` fields (e.g. an icon image) in the menu output automatically.
- Append in-page anchor fragments to link URLs by enabling `add_fragment`.
- Render `<nolink>` section headers (title/weight/children, no URI) in a mega-menu.
- Feed a static-site generator the menu structure at build time.
- Drive a mobile app's navigation drawer from the site's menus.
- Reshape the output keys (e.g. rename `below` to `child`) with `hook_rest_menu_items_output_alter`.
- Add custom tree manipulators per menu with `hook_rest_menu_items_resource_manipulators_alter`.
- Change the endpoint path with `hook_rest_resource_alter` if `/api/menu_items` clashes.
- Provide navigation data to multiple front ends from one Drupal menu source of truth.
- Cache navigation responses at the edge, invalidated automatically when menus change.
- Combine `min_depth`/`max_depth` to fetch a specific menu section for a landing page.
- Expose translated menu links per language because responses vary and menus are translatable.
