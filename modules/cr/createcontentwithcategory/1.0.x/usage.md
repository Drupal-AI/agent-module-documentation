<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Create Content with Category renders a menu-like block of links, one per taxonomy term, each opening the node-add form with the term already selected in a chosen reference field.

---

You configure target "node type + reference field" combinations at `/admin/config/content/createcontentwithcategory` (stored in `createcontentwithcategory.settings:target_nodes_fields` as `content_type__field_name` ids). For each target the `Ccwc` class loads the referenced vocabularies' terms and builds a themed menu (`menu__…`) whose links point to `node.add` for the content type with a Prepopulate query key (`edit[<field>][widget]`) carrying the term id — so clicking a category link opens a new node form with that category pre-filled. A block plugin with a deriver exposes one block per configured target; block access is granted to users who can create that content type (`create <content_type>`). Depends on the Prepopulate module to seed the field value from the URL.

Configuration requires `administer taxonomy`. There are no custom content-creation endpoints; the links target core's `node.add` route, so created nodes still go through the normal node-add access checks. The block is intended to be shown to users who can create the target content type (`create <content_type>`).

---
- Show a block of "create X in category Y" links
- Pre-select a taxonomy term on the node-add form
- Offer editors quick category-scoped content creation
- Configure which content type + field combos get a block
- Generate one block per node-type/field target
- Drive creation links from a vocabulary's terms
- Let authors start an article already tagged
- Use Prepopulate to seed reference fields from the URL
- Restrict blocks to users who can create that content type
- Build a category navigation for content authoring
- Support multiple vocabularies per field
- Label links with term names automatically
- Speed up tagging-heavy editorial workflows
- Expose creation links as a placeable block
- Derive one block per node-type/field target
- Render the links as a themed menu
- Seed a select-list reference field via the prepopulate key
- Reduce clicks to create pre-categorised content