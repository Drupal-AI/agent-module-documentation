Block Visibility Groups Admin is the optional UI-helper submodule of Block Visibility Groups. It adds a "create a group from the current page" workflow and defines a `ConditionCreator` plugin type that turns the page you are on into pre-filled block-visibility conditions.

---

The submodule depends only on its parent `block_visibility_groups` and adds no config, permissions or config schema of its own. Its core piece is a **ConditionCreator** plugin type: a `DefaultPluginManager` (service `plugin.manager.block_visibility_groups_admin.condition_creator`) that discovers plugins in each module's `Plugin/ConditionCreator/` namespace, annotated with `@ConditionCreator` (`id`, `label`, `condition_plugin`). Each ConditionCreator knows how to build form elements for one kind of condition and how to translate the submission into a core Condition plugin config array; the module ships three — `route` (core `request_path`), `roles` (core `user_role`) and `node_type` (core `node_type`). The `ConditionCreatorForm` (route `block_visibility_groups_admin.group_create` at `/admin/structure/block/block-visibility-group-new/{route_name}/{parameters}`) instantiates every ConditionCreator for the passed route/parameters, renders their checkboxes under a **Conditions** fieldset, and on submit creates a new `block_visibility_group` entity, adds the selected conditions to it and redirects to the group's edit form. A menu link places the group collection under **Structure → Block layout → Block visibility groups**, and a `GroupLister` controller (route `block_visibility_groups_admin.active_groups`) plus a `GroupInfo` service list the groups whose conditions currently evaluate to TRUE on the active page. Route access uses core permissions (`administer blocks` for creating a group, `access content` for the active-group list) — the submodule defines none itself. It is essentially the "development helper" / authoring UI layer on top of the base module's entity and condition_group plugin.

---

- Create a new block visibility group straight from the page you are viewing, pre-seeded with that page's conditions.
- Turn the current route into a "current path" (`request_path`) condition without typing the path pattern by hand.
- Offer editors a one-click "restrict to these roles" condition builder via the `roles` ConditionCreator.
- Offer a "restrict to this content type" condition builder on node pages via the `node_type` ConditionCreator.
- Define your own ConditionCreator plugin to add a guided builder for any other core Condition plugin.
- Map a wildcard route path (e.g. `/node/*`) into a condition automatically by stripping route parameters.
- Bundle several selected conditions into one freshly-created group in a single form submission.
- Auto-generate the group's machine name and land on its edit form to fine-tune AND/OR logic afterwards.
- Add a guided condition builder from a custom module by dropping a plugin in `Plugin/ConditionCreator/`.
- Alter or extend the discovered ConditionCreator definitions via the `block_visibility_condition_creator` alter hook.
- List which visibility groups are currently "active" (their conditions pass) on a given set of group ids.
- Give site builders quick "Manage Blocks" links per active group that jump to the block layout filtered to that group.
- Provide contextual "Add New Visibility Group" entry points wired to a specific route and parameters.
- Pre-fill a node-type condition with the current node's bundle so editors just confirm rather than choose.
- Escape and list all site roles as checkboxes when building a user-role condition.
- Reuse core Condition plugins (request_path, user_role, node_type) without writing their config arrays manually.
- Keep the authoring UI optional: enable it only where builders need the guided group-creation flow, leave it off in production.
- Programmatically instantiate a ConditionCreator for a route via `createInstance($id, ['route_name' => ..., 'parameters' => ...])`.
- Validate that at least one condition was selected before a group is created.
- Build context mappings automatically (e.g. current-user context for roles, node route context for node type) when creating conditions.
