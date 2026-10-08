<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Field Widgets (entity_reference_widgets) — agent index

**Widgets for entity reference fields: hierarchical taxonomy selection + an Inline Entity Form "autocomplete create new" option.**

- **Version:** 1.0.x  •  core: `^9 || ^10`  •  depends on `field_ui`, `inline_entity_form`.
- **Selection plugin:** `@EntityReferenceSelection(id="erw:hierarchical")` `Hierarchical extends DefaultSelection` — adds `parent.target_id` condition for a configured parent (taxonomy_term).
- **IEF enhancement:** `hook_field_widget_third_party_settings_form` adds `erw_enable_create`, helper/new-item/save text to `inline_entity_form_complex`; alter attaches `entity_reference_widgets/ief` library + data attributes.
- **No routes/permissions/config UI;** per-field settings only.

**Security (reviewed, sound):** selection uses core `DefaultSelection` (access-checked queries); enhancements are client-side UX (libraries, third-party settings). No custom endpoints or mutation.
