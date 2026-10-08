<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Exposed Filters adds a Views filter that turns an entity-reference relationship into an exposed dropdown of the referenced nodes' **titles**, instead of exposing raw node IDs.

---

The module provides a single Views filter plugin, **`eref_node_titles`** (class `EREFNodeTitles`, extending core's `ManyToOne` filter), registered on the `node_field_data` table via `hook_views_data_alter()` as "Entity Reference Exposed Filters Node Titles". You use it in a View that has an entity-reference **relationship** (a "Content referenced from …" relationship); the filter reads that relationship, finds the referenced content type(s), and builds the exposed filter's value options as node **titles** (keyed internally by node id) so site visitors pick a human-readable title rather than a number. The filter is **always exposed** (its expose button is disabled) and requires a valid standard node entity-reference relationship — it removes non-node/non-standard relationships from the relationship option list and marks itself broken if none exists. Its extra options control the option list: **sort_by** (`nid` or `title`), **sort_order** and **sort_bundle_order** (`ASC`/`DESC`), **get_unpublished** (Unpublished / Published / All), and **get_filter_no_results** (drop options that would return no results). It ships config schema for the filter and its value, has no admin settings page (`configure: null`), no permissions, and no Drush commands; it depends on core Views. Note: it targets node reference fields only (not taxonomy terms or users), and reference fields backed by a View handler are unsupported.

---

- Expose a dropdown of referenced article titles on a listing View instead of node IDs.
- Let visitors filter a View of content by the parent/related content it references, by title.
- Build a faceted-style exposed filter of "referenced from" content titles.
- Filter a page-of-events View by the referenced venue's title.
- Show referenced product titles as the exposed filter options on a reviews View.
- Sort the exposed title options alphabetically (`sort_by: title`, `sort_order: ASC`).
- Sort the exposed options by node id instead (`sort_by: nid`).
- Order options first by content-type bundle, then by title, via `sort_bundle_order`.
- Include only Published referenced nodes in the option list (`get_unpublished: Published`).
- Include Unpublished or All referenced nodes in the options when needed.
- Hide filter options that would return zero results (`get_filter_no_results`).
- Provide an editor-friendly exposed filter without writing a custom Views filter plugin.
- Replace a raw numeric entity-reference exposed filter with readable titles.
- Drive a "related content" browse experience keyed off an entity-reference relationship.
- Filter a directory View by the organisation each entry references.
- Use referenced-node titles as filter options across multiple target content types.
- Translate the option titles to the current language (uses the translated title in context).
- Keep the exposed filter always visible so it is part of the View's UI by default.
- Constrain a View to content referencing a specific chosen node picked by title.
- Give end users a select list of referenced content that stays in sync with published nodes.
- Avoid exposing internal node IDs to site visitors in filter URLs' option labels.
- Combine with a Views relationship to surface only relevant referenced content types.
