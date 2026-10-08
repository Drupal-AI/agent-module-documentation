<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Term Reference adds a "References" tab to taxonomy term pages for managing the entities that point at that term through an entity-reference field.

---

A discovery service (`TermReferenceDiscovery`) finds which entity-reference fields target the term's vocabulary; a manager (`TermReferenceManager`) lists referencing entities and adds/removes the reference on save. The single route, `/taxonomy/term/{taxonomy_term}/references/{field}`, renders an AJAX form (`TermReferenceForm`) as an admin-route local task. Access is enforced by a custom checker that requires update access to the term itself AND edit access to the specific reference field on the target entity/bundle (`$term->access('update')` AND `fieldAccess('edit')`), so users can only manage references they are already permitted to edit.

The typical task is: on a term page, open the References tab, pick a reference field, and attach or detach content items — useful for curating "what links here" relationships without editing each node individually. Setup requires only enabling the module; it surfaces any existing entity-reference fields that target taxonomy terms.
---
- Manage which nodes reference a taxonomy term from the term page
- See all entities pointing at a term via a given field
- Add a reference from a term page instead of editing each node
- Remove an entity's reference to a term
- Curate tagged content from the taxonomy side
- Work with any entity-reference field targeting the vocabulary
- Restrict management to users who can edit the term and field
- Use an AJAX form that updates in place
- Expose references as a local task tab on term pages
- Handle multiple reference fields per term
- Build editorial back-reference workflows
- Attach content to a category without opening the node
- Enforce field-level edit access on each reference change
- Discover reference fields automatically per vocabulary
- Support published/unpublished target entities
