<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder + Section Library (lb_plus_section_library) — agent index

Submodule of **lb_plus** that reconnects the contrib **Section Library** module to the Layout Builder +
UI: save a section or whole page as a `section_library_template`, then drag saved templates back into
any (possibly nested) layout. Version **3.6.x** (`3.6.12`). Core `^10 || ^11`.
Depends on `section_library`, `lb_plus`, `navigation_plus` — install only if running all three.

Exists because `lb_plus` **replaces** the Layout Builder UI, so Section Library's own render-element
link no longer has a place to attach; this module re-wires the save/place flow into LB+'s tools.

## What it provides
- **Route** `lb_plus_section_library.place_template` → invokable `Controller\PlaceTemplate`
  (gated by core `_layout_builder_access: 'view'`). → `agent/api/section-library.md`
- **Tool plugin** `#[Tool id: section_library]` (`Plugin/Tool/SectionLibrary`, hot key `s`) — adds a
  "Save to Section Library" top-bar button and per-section save indicators.
- **Sidebar plugin** `#[Sidebar id: section_library]` (`Plugin/Sidebar/SectionLibrary`) — left-rail
  palette of saved templates, each draggable, with Edit/Delete context links gated by the template's
  own `access('update')` / `access('delete')`.
- **Route subscriber** `Routing\LBPSLRouteSubscriber` — swaps `section_library.add_template_to_library`
  to `Form\AddTemplateForm` (AJAX rebuild of the LB+ sidebar).
- **Event subscribers**: `EventSubscriber\SectionToolIndicators` (adds the save-section indicator via
  lb_plus's `SectionToolIndicatorEvent`), `EventSubscriber\ShouldEditMode` (keeps Edit Mode on while
  placing a template).
- **Hooks** (`.module`): strips Section Library's incompatible render-element link
  (`hook_element_info_alter`); on new-template presave, re-generates the section's `lb_plus/uuid` so
  clones don't collide; removes the delete button from the template edit form; sets the template
  entity's workspace handler to `IgnoredWorkspaceHandler`.
- **Service provider** `LbPlusSectionLibraryServiceProvider` registers
  `lb_plus_section_library.update_sidebar_form_alter` only when `navigation_plus` is enabled.

## Governance note (editorial, not technical)
An uncurated library fills with near-duplicate templates and editors stop using it. Decide who curates
before it fills up.
