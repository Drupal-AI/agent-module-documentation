<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alias Manager adds a collapsible "Alias manager" section to an entity's edit form listing every URL path alias that points at that entity.

---

Alias Manager is a small helper module that surfaces an entity's URL path aliases directly on its edit form. Via `hook_form_alter`, on the edit form of any content entity whose entity type declares a `canonical` link template (nodes, taxonomy terms, media, users, commerce products, and so on), it adds a details element in the advanced/vertical-tabs group. The section renders a table of the path aliases whose source is the entity's internal path (`/<entity canonical internal path>`), one row per alias, showing the alias string and its language. For users who also hold the core "create url aliases" permission, each row gains Edit and Delete operation links that point at core's own path admin routes (`/admin/config/search/path/edit/{id}` and `/delete/{id}`). The whole section only appears when the current user has the module's `administer alias_manager` permission and the entity already exists (not on the "add" form). It has no configuration, no routes of its own, no services, and no config schema; it reads core's `path_alias` entity storage via `loadByProperties`. A `hook_help` page renders the module README (through the Markdown filter if the `markdown` module is enabled).

---

- See all URL aliases for a node without leaving its edit form.
- Review which aliases resolve to a taxonomy term.
- Check the aliases attached to a media entity.
- Inspect aliases on a commerce product or any canonical entity.
- Confirm an entity has exactly one alias (spot duplicates).
- View the language each alias is assigned to on a multilingual site.
- Jump straight to core's alias edit form via the Edit operation link.
- Delete a stale alias via the Delete operation link.
- Give editors visibility of an entity's aliases without granting full path admin.
- Audit aliases per-entity during content cleanup.
- Verify Pathauto-generated aliases on the entity that produced them.
- Spot entities that have no alias (the table shows an "empty" message).
- Restrict who sees the alias list using the `administer alias_manager` permission.
- Separate "can see aliases" from "can edit aliases" via the `create url aliases` permission.
- Surface aliases as a vertical tab alongside URL alias / authoring info tabs.
- Support content editors reviewing SEO-relevant URLs per entity.
- Use as a lighter, entity-generic alternative to node-only alias listers.
- Confirm an alias points at the right internal path after a move.
- Provide a quick per-entity alias overview during migrations.
- Enable and forget — no configuration step required.
