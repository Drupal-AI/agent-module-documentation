# Custom Meta — agent index

Extends [Metatag](https://www.drupal.org/project/metatag): define your own meta tags (attribute
`name`/`property`/`http-equiv`) from the admin UI instead of coding a plugin each time. Definitions
live in `custom_meta.settings` and are turned into Metatag tag plugins via derivers. Depends on
`metatag`. One permission: `administer custom meta tags`.

- **Admin UI, routes, the `custom_meta.settings` config shape, prefix, cache-flush caveat** →
  [configure/tags.md](configure/tags.md)
- **How config becomes Metatag plugins (base tags, derivers, group) and how to add definitions in code** →
  [plugins/metatag.md](plugins/metatag.md)

Key facts:
- Configure route `custom_meta.admin_overview` = `/admin/config/search/metatag/custom-meta`.
- Config object `custom_meta.settings`: `tag` (keyed by machine name → {attribute,name,label,description})
  and `prefix` (string, prepended to the rendered tag name by the derivers).
- Base tag plugin ids: `custom_meta_tag_name`, `custom_meta_tag_property`, `custom_meta_tag_http_equiv`;
  Metatag group id `custom_meta`.
- After changing definitions you must flush caches for new derivatives to appear.
