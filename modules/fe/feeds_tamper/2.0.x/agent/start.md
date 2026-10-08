# feeds_tamper — agent start

Runs **Tamper** plugins on Feeds source values before mapping/saving. Requires `feeds` +
`tamper`. No global config route; configured per feed type at
`/admin/structure/feeds/manage/{feeds_feed_type}/tamper` (link template `tamper`).
Feeds Tamper defines NO plugin type — the transformation plugins come from the Tamper module.

- Attach/manage tampers on a feed type (UI + config storage) → [configure/tampers.md](configure/tampers.md)
- Manage tampers programmatically (service API) → [api/tamper-manager.md](api/tamper-manager.md)
- Permissions (global + per-feed-type) → [permissions/permissions.md](permissions/permissions.md)
