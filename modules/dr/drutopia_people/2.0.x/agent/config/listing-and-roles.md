<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# People & content-by-author views, indexing, URLs, vocabulary, and role grants

All items are shipped config. This is a config feature installed via the Drutopia distribution;
enabling the module imports the objects below.

## Search API index — `search_api.index.people.yml`

- `id: people`, `server: database`, `read_only: false`, datasource `entity:node`.
- Indexes node fields (title, body, created, changed, status, promote, sticky,
  `field_people_type`, and a rendered `search_index` item) so profiles are searchable and the
  people view can query them.

## People listing view — `views.view.people.yml`

- `base_table: search_api_index_people` (a Search API view). Description "Displays for the people
  content type." Access: **permission `access content`** (standard public listing); query
  `bypass_access: false`, `skip_access: false` (node access is enforced).
- **Displays:**
  - `default` (Master): title **"Our people"**, style **`plain_style`** (from `views_plain`),
    rows = `search_api` rendered entity in the **`teaser`** view mode, **grouped by
    `field_people_type`**, pager `none`, basic exposed form (sort by). Sorts: People type ASC,
    then created DESC.
  - `page_listing` (Page): **path `/people`**, added to the `main` menu as "People".
- The **"Add person"** local action (`drutopia_people.links.action.yml`) points at
  `node.add` with `node_type: people` and appears on `view.people.page_listing`.

## Content-by-author view — `views.view.content_by_author.yml`

- `base_table: node_field_data`. Access: **permission `access content`**.
- Fields include title, status, created, and `field_authors`. Uses a **`node_nid` contextual
  argument** through the `field_authors` relationship, so given a person node it lists the content
  that references that person as an author.
- Ships a **`block_author`** block display (embeddable on a person's page to show their authored
  content).

## Pathauto patterns

- `pathauto.pattern.people_node.yml` — id `people_node`, type `canonical_entities:node`, pattern
  **`people/[node:title]`**, restricted to bundle `people`.
- `pathauto.pattern.people_type.yml` — id `people_type`, type `canonical_entities:taxonomy_term`,
  pattern **`[term:vocabulary]/[term:name]`**, restricted to the `people_type` vocabulary.

## Taxonomy vocabulary — `taxonomy.vocabulary.people_type.yml`

`vid: people_type`, name "People type", description "For categorizing people content." Empty by
default; the site adds terms. `topics` (used by `field_topics`) comes from a Drutopia dependency,
not this module.

## Role permission grants — `config/actions/user.role.<role>.yml`

These use the Drutopia config-actions mechanism (each file `add`s a `node.type.people` config
dependency and `add`s permission strings to the role's `permissions` list). They modify existing
Drutopia roles rather than defining new ones. Grants are people-scoped only — **no delete, admin,
bypass, or other privileged permissions**:

| Role | Permissions granted (exact strings) |
|---|---|
| `contributor` | `create people content`, `edit own people content` |
| `editor` | `create people content`, `edit any people content` |
| `manager` | `create people content`, `edit any people content` |

`contributor` is the most limited (own-content only); `editor` and `manager` can edit any person.
All three are standard per-bundle node permissions; **none of the three grants delete**.
