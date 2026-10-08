# Message Subscribe UI — agent index

The **end-user front end** for Message Subscribe: a per-user Subscriptions tab, a subscribe block,
and the `administer message subscribe` permission. No settings form of its own (`configure=null`).

- **The Subscriptions tab, the subscribe block, per-flag views, the permission, the view_name third-party setting** →
  [configure/ui.md](configure/ui.md)

Key facts:
- Route `message_subscribe_ui.tab` → `/user/{user}/message-subscribe` (`SubscriptionController::tab`),
  with a sub-tab per enabled `subscribe_*` flag (local-task deriver `MessageSubscribeUiLocalTask`).
- Which View a flag's listing uses = flag third-party setting `message_subscribe_ui.view_name`
  (default `<flag_prefix>_<entity_type>:default`); a select is added to each subscription flag's edit form.
- Ships Views: `subscribe_node`, `subscribe_taxonomy_term`, `subscribe_user`.
- Block plugin id `message_subscribe_ui_block` ("Manage subscriptions") — subscribe toggle on entity pages.
- **Defines the `administer message subscribe` permission** (the base module's settings route requires it).
- Depends on `message_subscribe` + `views`.
