<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `/api/menu_items/{menu_name}` endpoint

Resource plugin `rest_menu_item` (`RestMenuItemsResource`), canonical URI
`/api/menu_items/{menu_name}` — `{menu_name}` is a menu machine name (`main`, `footer`,
`account`, …).

## Query parameters

- `_format` — **required**: `json`, `hal_json`, or `xml`. Missing it returns **406 Not
  Acceptable**.
- `max_depth` — return only levels up to this depth.
- `min_depth` — start the tree at this depth (default internal min depth is 1).

Examples:

```
/api/menu_items/main?_format=json
/api/menu_items/footer?_format=xml&max_depth=1
/api/menu_items/account?_format=hal_json&min_depth=2
```

## Response shape

An array of menu-item objects; children are nested under a **`below`** key (absent when an
item has no children). Fields present per item are governed by `output_values`
(see configure/settings.md) and include: `key`, `title`, `description`, `uri`, `alias`,
`external`, `absolute`, `relative`, `existing`, `weight`, `expanded`, `enabled`, `uuid`,
`options`.

```json
[
  { "title": "About", "uri": "node/1",
    "below": [ { "title": "Team", "uri": "node/2" } ] }
]
```

- **Content fields:** custom fields on `menu_link_content` links (image, entity reference, …)
  are included automatically — entity references return the referenced entity; image fields
  return absolute file URLs.
- **`<nolink>` items:** section headers with no route are included, but `uri`, `alias`,
  `absolute`, `relative` are omitted; `title`, `weight`, `below` remain.
- **`base_url`:** when set, replaces the domain in `absolute` (and drives `relative`) output —
  for decoupled front ends on another domain.
- **`add_fragment`:** when enabled, appends anchor fragments (`#id`) from link options to
  `alias`/`absolute`/`relative`.

## Access

Standard core REST: enable the `rest_menu_item` resource (REST UI or config) and grant
`restful get rest_menu_item`. A menu that is a key in a non-empty `allowed_menus` but not
enabled there returns **403**. Responses carry cache tags (invalidated on menu/link/entity
change) and vary by user permissions.
