<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST Menu Tree — agent index

One core REST resource, `menu_tree`, returning a whole menu's nested link tree from
`GET /entity/menu/{menu}/tree`. Depends on core `rest` + `menu_normalizer`. No config UI, no own
permissions/schema — governed by core REST.

- **Enabling the resource, the endpoint, access, response shape, and caching** →
  [configure/enable.md](configure/enable.md)

Key facts:
- Resource `@RestResource(id = "menu_tree")` (`src/Plugin/rest/resource/MenuTreeResource.php`),
  `serialization_class = Drupal\system\Entity\Menu`, path `/entity/menu/{menu}/tree`.
- **Not on by default** — enable the `menu_tree` resource (REST UI or `rest.settings`), set
  formats/auth, and grant core permission `restful get menu_tree`.
- `get()` loads via `menu.link_tree`, sorts (`generateIndexAndSort`), drops inaccessible links per
  `checkAccess()` (core per-link `view` access), removes keys, serializes via Menu Normalizer.
- Full cacheability: menu entity + per-link access results + link cache metadata + list/entity tags.
