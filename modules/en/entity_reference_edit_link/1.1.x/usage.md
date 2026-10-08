<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Edit Link puts an "Edit" link beside the item selected in an entity reference field's widget on an entity edit form, so a referenced entity can be opened for editing directly from the form that references it. The link opens in a new browser tab and is shown only when the current user has update access to that entity.

---

The friction it removes is small, constant and cumulative. An editor working on an article selects a related term, an author profile or a linked page, notices something wrong with it, and has to leave the form — losing unsaved work unless they save first — open the admin listing, search for the item, edit it, and navigate back. A link beside the reference removes that navigation; the target opens in a new tab (`target="_blank"`), so the original form stays put. This is a **widget-side** feature, not a display formatter: it augments the core `entity_reference_autocomplete` widget (and, when the Select2 module is present, the `select2_entity_reference` widget) by swapping in a subclass via `hook_field_widget_info_alter()`. The link is built from the referenced entity's `edit-form` link template and appears **only if `$referencedEntity->access('update')` passes for the current user**, so an editor who may view but not edit the item is not shown a link. Multi-value autocomplete fields get an added "Edit Entity" table column; multi-value Select2 fields get a dropbutton of links; the comma-separated *tags* autocomplete widget is deliberately excluded. Version **1.1.6**, core `^9 || ^10 || ^11`. A second, separate feature (opt-in from 1.1.0) is configured at `/admin/config/entity-reference-edit-link` behind `administer site configuration`: for the content types you select there, the **node edit page title** gains an "Edit &lt;type&gt;" link to that type's *Manage fields* (Field UI) page — visible only to users holding `administer node fields`. Two things to expect. The edit link respects the referenced entity's own access, so if a stale link were ever followed the entity form still enforces access (a 403 is a usability annoyance, not a hole). And **editing the referenced entity changes it everywhere** — a shared term edited from here is edited for every node using it; say so in editorial guidance, because a link that looks local and acts globally is how shared content gets damaged.

---

- Edit a referenced taxonomy term from a node form without leaving it.
- Fix a linked page's content straight from the reference widget.
- Open a referenced entity's edit form in a new browser tab.
- Reduce navigation while editing reference-heavy content.
- Edit an author or profile entity referenced by an article.
- Correct a mistake in a referenced item quickly.
- Avoid losing unsaved work by keeping the source form open.
- Speed up editorial workflows on complex content models.
- Edit a referenced media entity from the autocomplete widget.
- Add edit links to a multi-value reference field's "Edit Entity" column.
- Get a dropbutton of edit links on a multi-value Select2 reference field.
- Only show edit links to editors who actually have update access.
- Keep edit links off the comma-separated tags autocomplete widget.
- Add the edit link to a Select2 entity reference widget when Select2 is installed.
- Give reference-heavy content types a faster editing loop.
- Jump from a node's edit form to a referenced product's edit form.
- Reduce context switching between the source and referenced entities.
- Add an "Edit <type>" shortcut to the Manage fields page from a node edit title.
- Let field administrators jump to a content type's field settings while editing a node.
- Restrict the Manage-fields title link to selected content types via the settings page.
- Support content editors who frequently refine referenced entities inline.
