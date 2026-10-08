<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Collapsible adds expand/collapse toggles to the classic Paragraphs multi-value edit widget, so long stacks of paragraph items can be folded down to their titles on the entity edit form.

---

This is a small, **zero-configuration** front-end enhancement for the Paragraphs module. On enable it does one thing in PHP: `hook_library_info_alter()` appends its asset library (`paragraphs_collapsible/paragraphs_collapsible.widget`, a jQuery + `core/once` behavior plus a CSS file) as a dependency of Paragraphs' `drupal.paragraphs.admin` library, so the JS/CSS load wherever that admin widget renders. The JavaScript targets the **classic** Paragraphs table widget (`entity_reference_paragraphs`, matched by the `.field--widget-entity-reference-paragraphs` wrapper): for each paragraph row that has a `.paragraph-type-title`, it injects a per-row toggle button (`[+]` / `[-]`) and an overarching **Expand all / Collapse all** button on the field label, with proper `aria-expanded` / `aria-label` attributes. Rows containing validation errors or freshly AJAX-added content are auto-expanded. There is no settings form, no configure route, no permissions, no Drush, no config, and no plugins — enabling the module is the entire setup. It only affects the editing UI (the classic widget); rendered output and other widgets are untouched.

---

- Fold a long list of paragraph items down to their titles on a node edit form.
- Add Expand all / Collapse all controls above a Paragraphs field for editors.
- Collapse individual paragraph rows with a per-row `[+]` / `[-]` toggle.
- Make editing pages with dozens of paragraphs manageable by hiding sub-forms.
- Keep an at-a-glance overview of paragraph titles while editing a landing page.
- Auto-expand only the paragraph rows that have validation errors after a failed save.
- Auto-expand a paragraph row that was just added via AJAX so editors see it immediately.
- Improve the editing UX of the classic (legacy) Paragraphs table widget without custom code.
- Provide accessible collapse controls with aria-expanded/aria-label on toggle buttons.
- Reduce scrolling on content types that use many paragraph components.
- Give reviewers a compact, collapsed view of a page's paragraph structure.
- Speed up reordering paragraphs by collapsing them first (smaller drag targets).
- Apply consistent collapsible behavior across every content type using the classic widget.
- Let editors expand one paragraph at a time to focus on a single component.
- Avoid a heavy accordion contrib dependency for simple collapse/expand needs.
- Enhance a media-heavy paragraphs form so images/sub-forms aren't all open at once.
- Ship a better paragraphs authoring experience by simply enabling one module.
- Collapse paragraph rows that have titles while leaving title-less rows always visible.
- Fold nested paragraph sub-forms so the outer structure stays readable.
- Present a cleaner edit screen for editorial teams working with structured content.
