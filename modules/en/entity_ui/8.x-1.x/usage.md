<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity UI Builder adds configurable tabs (local tasks) to content entities of any type, with the tab's content supplied by a pluggable content plugin.

---

Entity UI Builder lets a site builder add extra tabs to content entities without writing custom code. Each tab is an `entity_tab` config entity that names a path component, a tab title, a page title, the target entity type (and optionally specific bundles), and a "tab content" plugin that renders the page. The module ships four content plugins: **Entity view** (renders the entity in a chosen view mode), **Entity form** (renders the entity's edit form in a chosen form mode), **Assign entity owner** (a form to change the owner), and derivatives of **Actions configurable** (one per applicable core/contrib action plugin, letting the user configure and execute the action on the entity). Tabs are configured from the target entity type's existing admin UI — beside the bundle list for entity types with bundles, or beside the field admin UI otherwise. Each tab automatically defines its own access permission, granular per bundle and (for owner-aware entity types) per any/own. The module requires only core Field UI, and is the spiritual successor to Drupal 7's Entity Operations.

---

- Add a read-only "summary" tab to nodes that renders a custom view mode.
- Give a custom content entity an edit tab without hand-writing routes or forms.
- Expose a compact "teaser" view mode of an entity on its own tab.
- Add an "owner" tab to reassign the author/owner of owner-aware entities.
- Surface a configurable core action (publish, unpublish, make sticky) as an entity tab.
- Add a delete-via-action tab scoped to specific bundles.
- Provide editors a form-mode-specific edit screen (e.g. a "moderation" form mode) as a tab.
- Give a taxonomy term or media entity extra management tabs.
- Build bespoke per-entity admin screens by writing a custom EntityTabContent plugin.
- Restrict a tab to a subset of bundles via the tab's target bundles setting.
- Grant a tab only to editors of their own content using the auto-generated "own" permission.
- Grant a tab across all content of a type using the auto-generated "any" permission.
- Order multiple tabs on an entity by adjusting each tab's weight.
- Reuse a view mode as a tab page instead of duplicating the canonical view.
- Add a form tab that opens a specific form mode for quick edits.
- Present an action's configuration form so users can run it on the fly per entity.
- Add management tabs to entity types provided by other contrib modules.
- Add tabs to entity types that lack bundles but are fieldable (field UI base route).
- Namespace tab routes consistently as `entity.<type>.entity_ui_<path>`.
- Localize tab and page titles, with token replacement in the page title.
- Migrate Drupal 7 Entity Operations concepts to Drupal 10.3/11.
- Prototype an entity admin UI quickly and refine it into custom code later.
- Alter available tab content plugins with `hook_entity_ui_entity_tab_content_info_alter()`.
- Let site builders assemble entity management screens entirely through configuration.
- Keep all tab definitions as exportable config entities under version control.
