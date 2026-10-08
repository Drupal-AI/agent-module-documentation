<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Usage Addons turns the Entity Usage module's tracking data into two field formatters, so "where is this used?" becomes something you place on a display or a view rather than a report you navigate to.

---

Entity Usage already records which entities reference which. What it does not do is put that answer in front of an editor at the moment they need it, which is while they are looking at an entity and wondering whether deleting it will break three pages.

This module adds two integer field formatters, both attached to an entity's ID field. The **Detailed** formatter lists the referencing (source) entities, optionally with columns for their ID, a link to the entity, their published status, and their entity type, and it collapses to a linked count once the number of references passes a configurable threshold. The **Count** formatter always renders just the linked total. Both read Entity Usage's tables through a small `Usage` service, so there is no second source of truth and no extra tracking to keep in sync.

The count links through to Entity Usage's own per-entity usage page, but only for users who hold Entity Usage's `access entity usage statistics` permission; everyone else sees the number without a link. Referencing-entity labels and links respect each viewer's access: an entity the viewer may not see is shown as "- Restricted access -" and is never linked. Paragraph and inline block references are resolved back to their host entity so the link points somewhere useful.

The scope is genuinely small: one service class and two formatter classes, no routes, no permissions defined here, no configuration page beyond the per-formatter display settings. That is a feature. It also means the module inherits every limitation of Entity Usage. If the parent module has not tracked a relationship (an unsupported field type, or a reference built in a way its plugins do not see), this formatter shows nothing, and shows it without complaint. An empty usage list is not proof that an entity is unused. Configure what gets tracked in Entity Usage itself. The README is the single word `# todo`, so the source is the documentation.

---

- Show an editor where an entity is referenced, on the entity's own display.
- Render a usage count as a field on a node, media, or taxonomy display.
- Render a detailed list of referencing entities as links.
- Warn a content team before they delete a still-referenced entity.
- Expose "where used" as a column in a Views listing of content or media.
- Link a usage total through to Entity Usage's built-in usage report.
- Collapse a long reference list to a count once it exceeds a threshold you set.
- Add a per-row entity-type column so editors can tell nodes from blocks from paragraphs.
- Add a per-row published/unpublished status column to the detailed list.
- Add a per-row ID column to the detailed list.
- Toggle a header row on the detailed usage table.
- Reuse Entity Usage's existing tracking with no extra data collection.
- Audit which media items are actually in use across the site.
- Find orphaned referenced entities during a content cleanup.
- Surface backlinks to content editors without a separate module.
- Check reference impact before unpublishing an entity.
- Resolve paragraph and inline-block references back to their host entity link.
- Keep the display strictly read-only; the module never mutates content.
- Restrict the count link to users with the Entity Usage statistics permission.
- Understand that an empty list means "not tracked", not necessarily "unused".
