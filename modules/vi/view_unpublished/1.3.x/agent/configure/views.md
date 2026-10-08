# Views integration

The module ships a Views filter plugin `NodeStatus`
(`src/Plugin/views/filter/NodeStatus.php`) that **overrides** core's node
"Published status or admin user" filter (`view_unpublished.views_execution.inc`
swaps it in). It rewrites the WHERE clause so a row is visible when the node is
published, OR the viewer owns it, OR the viewer holds any of the
view_unpublished permissions (global, per-type, or `bypass node access`). When
`content_moderation` is enabled it also honors `view any unpublished content` on
moderated entities.

Practical rule (from the README): in a View, use the filter
**"Published status or admin user"** — NOT **"Published = Yes"**. Only the former
is taken over by this module and will therefore respect the custom permissions.
The core Content overview (`/admin/content`) already uses that filter, so its
"not published" filter reflects who may see which drafts automatically.

No configuration options are added to the filter itself; behavior is driven
entirely by the acting user's permissions (see permissions/permissions.md).
