<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The breadcrumb config entity (`custom_breadcrumbs`)

Each breadcrumb trail is a `custom_breadcrumbs` config entity
(`custom_breadcrumbs.custom_breadcrumbs.<id>`), managed at *Structure → Custom breadcrumbs*
(`/admin/structure/custom-breadcrumbs`, add form `/admin/structure/custom_breadcrumbs/add`).

## Fields (config_export)

| Field | Meaning |
|---|---|
| `id` / `label` | Machine name and human label. |
| `status` | Enabled/disabled (only enabled entities are matched). |
| `description` | Free text. |
| `type` | **`1` = Content entity** (match by entity type/bundle), **`2` = Path** (match by `pathPattern`). |
| `entityType` | (type 1) Content entity type id, e.g. `node`. |
| `entityBundle` | (type 1) Bundle, e.g. `article`. |
| `language` | Langcode to match, or `und` (not specified) as fallback. |
| `pathPattern` | (type 2) Newline-separated path patterns; `*` wildcard, `<front>` for front page, tokens allowed. |
| `breadcrumbPaths` | Newline-separated crumb URLs (one per line). |
| `breadcrumbTitles` | Newline-separated crumb titles (paired with paths by line index). |
| `extraCacheContexts` | Newline-separated extra cache contexts (e.g. `url.query_args:search`). |

`type` is stored as the string/int `1` or `2`. For **type 1**, the builder loads enabled
`custom_breadcrumbs` entities with `entityType` = the route's entity type and matching
`entityBundle` + `language`, and applies the first match. For **type 2** it matches the route's
alias/internal path against each `pathPattern`.

## Path + title syntax

`breadcrumbPaths` and `breadcrumbTitles` are read line-by-line (`getMultiValues()` splits on
newlines) and paired by index. Each supports **Token** replacement (`[node:title]`, `[term:name]`,
…) against the matched entity. Special values in a path line:

- `<front>` → links the crumb to the front page.
- `<nolink>` → renders the crumb as text with no link.
- `<term_hierarchy:field_name>` → expands the referenced taxonomy term field into its full
  parent-to-child term hierarchy (each ancestor becomes a linked crumb). Requires the matched
  entity to have that term-reference field.

Empty resolved path or title lines are skipped (useful with `['clear' => TRUE]` token behavior).
Paths must start with `/`, or with `[` for a token, or be one of the special values.

## Create via the API (scriptable)

```php
use Drupal\custom_breadcrumbs\Entity\CustomBreadcrumbs;

// Content-entity trail: Home > Blog > [node:title] for Article nodes.
CustomBreadcrumbs::create([
  'id' => 'article_trail',
  'label' => 'Article trail',
  'status' => TRUE,
  'type' => 1,
  'entityType' => 'node',
  'entityBundle' => 'article',
  'language' => 'und',
  'breadcrumbPaths' => "/blog\n<nolink>",
  'breadcrumbTitles' => "Blog\n[node:title]",
  'extraCacheContexts' => '',
])->save();

// Path trail: everything under /products/*.
CustomBreadcrumbs::create([
  'id' => 'products_trail',
  'label' => 'Products trail',
  'status' => TRUE,
  'type' => 2,
  'pathPattern' => "/products/*",
  'breadcrumbPaths' => "/products",
  'breadcrumbTitles' => "Products",
])->save();
```

Read it back: `drush config:get custom_breadcrumbs.custom_breadcrumbs.article_trail`.

## Rendering a breadcrumb inside a teaser (extra field)

`hook_entity_extra_field_info()` adds a **"Breadcrumbs"** pseudo-field to every entity's view
displays (hidden by default). Enable it on a *Manage display* (e.g. the node teaser view mode) to
render the computed breadcrumb inside the entity output — designed for showing breadcrumbs on node
teasers in search results.
