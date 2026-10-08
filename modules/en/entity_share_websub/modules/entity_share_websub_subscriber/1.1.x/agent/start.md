<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Share Websub Subscriber — agent index

The **subscriber** end of Entity Share Websub. Adds Subscribe/Unsubscribe buttons to the
Entity Share pull form, registers subscriptions with a remote hub, and auto-imports content
when the hub notifies it. This is the **only configurable** module of the three.

- **Settings form + config keys (`import_config`, `hide_default_button`,
  `break_subscription_on_edit`, `subscribe_hub_url`, cancel texts)** →
  [configure/settings.md](configure/settings.md)
- **Services, callback routes, events, the subscribe/import flow, DB tables** →
  [api/services-and-flow.md](api/services-and-flow.md)

Key facts:
- `configure` route: `entity_share_websub_subscriber.settings` at
  `/admin/config/entity-share-websub-subscriber` (permission
  `administer entity share websub subscriber settings`).
- Config object: `entity_share_websub_subscriber.settings`. `import_config` is **required**
  (select an Entity Share import_config entity) for the automated sync to work.
- Callback routes `/subscription/{subscription_key}` (GET verify / POST|PUT update / DELETE
  cancel) are `_access: TRUE` — authenticated by `X-Hub-Signature`, not a permission.
- Tables: `entity_share_subscription`, `entity_share_subscription_record`. Depends on
  `entity_share_client` and the `entity_share_websub` base.
