<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Filter lets you tag each paragraph type with the content types it belongs to, then filters the paragraph-types admin list and node reference widgets by that association.
---
On the paragraph type add/edit form the module injects a "Content types" checkboxes element; the selection is stored in the `paragraphs_filter.settings` config keyed by paragraph type id (an empty selection means "no filtering / available everywhere"). A replacement list builder (`ParagraphsFilterListBuilder`) adds an exposed-style filter form (`ParagraphsFilterForm`) to `/admin/structure/paragraphs_type`, letting admins narrow the list to paragraph types tied to a chosen content type via a `?content_type=` query. It also alters the entity-reference field settings form (`field_config_edit_form`) so that, for node fields, paragraph target bundles not associated with the node's content type are removed from the drag-and-drop target list.

The module is configuration-only and operates entirely within standard admin forms (structure/field configuration), so it inherits those pages' access controls; it defines no routes, permissions, or services of its own and takes no untrusted input beyond a content-type machine name used to build a redirect query. When a paragraph type is deleted, its stored association is cleaned up, and the config object is removed when empty. Typical setup: enable the module (requires Paragraphs), edit each paragraph type to select applicable content types, then use the filter on the paragraph types list.
---
- Tag a paragraph type with the content types where it should be offered.
- Leave the selection empty to make a paragraph type available everywhere.
- Filter the paragraph types admin list by content type.
- Reset the paragraph types list filter back to showing all.
- Narrow a node's paragraph reference widget to relevant paragraph types.
- Reduce editor confusion when many paragraph types exist.
- Keep paragraph-type governance in exportable config.
- Auto-clean associations when a paragraph type is deleted.
- Configure associations directly on the paragraph type add/edit form.
- Apply per-content-type paragraph availability without custom code.
- Use the `?content_type=` query to deep-link a filtered paragraph list.
- Combine with Paragraphs' existing field configuration UI.
- Curate large paragraph libraries for editorial teams.
- Prevent irrelevant paragraph bundles from appearing on a node type's reference field.
- Disable the module to restore the unfiltered paragraph types list.