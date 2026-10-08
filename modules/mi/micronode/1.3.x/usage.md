Lets you flag any content type as "micro-content": its nodes stop being reachable on their own canonical page by visitors (editors who can update them still can), and they are pulled out of "Add content" lists, admin content lists, new Views, and entity autocompletes.

---

Micro-content is content that only makes sense embedded in other content (a card, a callout, a
reusable snippet) rather than as a standalone page. This module marks a **node type** as micro-content
through a per-type third-party setting (`micronode.micronode_is_microcontent`), edited via a
"Micro-content settings" vertical tab added to the node type form — there is no central config page
(`configure` is null). A `hook_ENTITY_TYPE_access` (node) implementation forbids the `view` operation
on the `entity.node.canonical` route for users who cannot `update` the node, but only when the node's
type is flagged; other routes and users with edit access are unaffected. Around that core behaviour it
also reorganises the UI: the `/node/add` page (unless `type_tray` is installed) is served by a subclass
that hides micro-content types, a new `/node/add-microcontent` route lists only micro-content types
(guarded by a custom `_micronode_create_any_access` check), `admin_toolbar_tools` links are regrouped
under an "Add Micro-Content" menu item, the Views node wizard is subclassed and a boolean
`micronode_is_microcontent` Views filter is added (with `hook_views_data_alter`) so listings can
include/exclude micro-content, exposed bundle filters drop the hidden types, and an
`entity_autocomplete` `#process` callback (`MicronodeAutocompleteHelper::disallowMicronodes`) blocks
micro-content from autocompletes unless explicitly allowed. Toggling a type's flag clears all cache
bins (validate handler) and the helper `micronode_get_node_types()` result is cached and tagged
`config:node_type_list`. Author positions this as a simpler, node-native alternative to Rabbit Hole /
Microcontent: any content type can be marked micro-content (and back) at any time. Note existing types
must be re-saved once so the flag initialises (NULL until saved) for the Views filter to see them.

---

- Mark a "Card", "Callout", or "Snippet" content type as micro-content so its nodes have no public page.
- Keep reusable content as real nodes (fields, revisions, translations) without standalone URLs.
- Prevent anonymous visitors from reaching an embedded node via its `/node/{id}` canonical path.
- Still let editors (users with update access) open micro-content nodes to edit them.
- Remove micro-content types from the `/node/add` "Add content" chooser.
- Give editors a dedicated `/node/add-microcontent` page listing only micro-content types.
- Group micro-content "add" links under their own Admin Toolbar menu section.
- Exclude micro-content nodes from newly created Views by default.
- Add an "Is Micro-content" boolean filter to a View to include or exclude such nodes.
- Drop micro-content bundles from an exposed content-type filter automatically.
- Stop micro-content nodes appearing in entity reference autocomplete suggestions.
- Explicitly allow micro-content in a specific autocomplete when you do want it.
- Convert an existing content type into micro-content (or back) at any point in a project.
- Replace Rabbit Hole's "hide node" behaviour with a node-native, Views-aware approach.
- Migrate paragraph-like reusable items to nodes while keeping them off the front stage.
- Hide landing-page building blocks from search/listing surfaces that use the Views filter.
- Clear caches automatically when a type's micro-content status changes so listings update.
- Build a component library of embeddable nodes referenced from full pages.
- Restrict "add micro-content" access to roles that can create at least one such bundle.
