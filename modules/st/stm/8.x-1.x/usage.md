<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
**Simple Taxonomy Menu (STM)** adds a *Sync To Menu* tab to a vocabulary's term-overview page that builds menu links mirroring that vocabulary's term tree — a quick way to turn a category taxonomy into a navigation menu without hand-creating each link.

---

The module registers one route, `stm.taxonomy_vocabulary.sync_menu_form` (`/admin/structure/taxonomy/manage/{taxonomy_vocabulary}/overview/menu`, local task *Sync To Menu*), backed by the form `SyncToMenuForm`. Access is controlled by the route requirement `_entity_access: 'taxonomy_vocabulary.view'`. The form loads the vocabulary's terms (via the `taxonomy_term` storage) and, on submit, creates menu-link content entities that reproduce the term parent/child hierarchy into a chosen menu. It has no services, permissions, config entities or blocks of its own and stores nothing beyond the menu links it generates. Legacy machine version `8.x-1.2`.

---

- Generate a navigation menu from a taxonomy vocabulary in one click.
- Mirror a category term hierarchy as nested menu links.
- Turn a product-category taxonomy into a site menu.
- Re-sync a menu after adding new terms to a vocabulary.
- Save time versus hand-building menu links per term.
- Access the sync form from the vocabulary's term overview tab.
- Keep menu structure aligned with taxonomy parent/child relations.
- Build a main-menu tree from a topics vocabulary.
- Create menus for multiple vocabularies independently.
- Produce menu links that point at taxonomy term pages.
- Bootstrap navigation for a freshly imported taxonomy.
- Provide editors a simple UI for taxonomy-driven menus.
- Reproduce deep term hierarchies as multi-level menus.
- Avoid contributed menu-sync complexity for simple cases.
- Regenerate navigation when reorganizing categories.
- Complement core Menu UI with taxonomy-sourced links.
- Drive a footer or sidebar menu from a small vocabulary.
