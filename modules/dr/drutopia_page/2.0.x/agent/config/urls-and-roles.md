<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pathauto pattern, promote override, RDF mapping, and role grants

All items are shipped config. This is a config feature installed via the Drutopia distribution;
enabling the module imports the objects below.

## Pathauto pattern — `pathauto.pattern.node_page.yml`

- `id: node_page`, type `canonical_entities:node`, pattern **`[node:title]`**.
- Selection criterion restricts it to bundle `page` (`entity_bundle:node`, bundles `page`),
  `weight: -5`. Pages get a title-based URL alias automatically.

## Promote base-field override — `core.base_field_override.node.page.promote.yml`

- Overrides the node `promote` field on the `page` bundle, label "Promoted to front page",
  **default value `0`** — new pages are not promoted to the front page by default.

## RDF mapping — `rdf.mapping.node.page.yml`

- Maps the `page` node type to **`schema:WebPage`**; `title` → `schema:name`, `created` →
  `schema:dateCreated`, `changed` → `schema:dateModified`, `body` → `schema:text`, `uid` →
  `schema:author`, comment count → `schema:interactionCount`.

## Role permission grants — `config/actions/user.role.<role>.yml`

These use the Drutopia config-actions mechanism (each file `add`s a `node.type.page` config
dependency and `add`s permission strings to the role's `permissions` list). They modify existing
Drutopia roles rather than defining new ones. Grants are page-scoped only — **no delete, admin,
bypass, or other privileged permissions**:

| Role | Permissions granted |
|---|---|
| `contributor` | `create page content`, `edit own page content` |
| `editor` | `create page content`, `edit any page content` |
| `manager` | `create page content`, `edit any page content` |

The `contributor` role is the most limited (own-content only); `editor` and `manager` receive the
identical grant (create + edit any page). All are standard per-bundle node permissions. No role is
granted `delete … page content`.
