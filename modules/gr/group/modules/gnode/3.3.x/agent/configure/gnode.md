# Configure — installing group_node on a group type

gnode has **no config UI or settings of its own**. You enable node-in-group functionality by
installing the derived `group_node:{node_type}` relation plugins onto a group type using the
parent Group module's content plugin UI:

`/admin/group/types/manage/{group_type}/content`
(route `entity.group_type.content_plugins`, gated by `administer group`).

Installing a plugin there creates a `group_relationship_type` config entity
(`group.relationship_type.{group_type}-group_node-{node_type}`). Configure or uninstall it via
the parent routes `entity.group_relationship_type.edit_form` / `.delete_form`.

gnode's own config is a single optional view: `views.view.group_nodes` (the per-group node
overview). Its `RouteSubscriber` registers group-scoped node create/collection routes, and
`gnode.module` adds a **Nodes** operation link to each group (weight 20) when the current user
has `access group_node overview` and the `view.group_nodes.page_1` route exists.
