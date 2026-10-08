<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions — Entity Share Websub Hub

One permission, defined in `entity_share_websub_hub.permissions.yml`:

| Permission | Machine key | Gates |
|---|---|---|
| See syndicated content subscriptions view | `see content subscriptions` | Access to the **Syndicated content** View, which lists which subscriber sites subscribed to which content (reads the `entity_share_websub_hub_subscription` table). Not marked `restrict access`, but it exposes subscriber endpoints/emails, so treat it as admin-only. |

Grant it with:

```bash
drush role:perm:add administrator 'see content subscriptions'
```

Note the **`/subscribe` route itself is not gated by this permission** — it requires only
`access content` (granted to anonymous by default) because remote subscriber sites, not logged-in
users, call it. The intent-validation handshake and `X-Hub-Signature` are what actually
authenticate a subscription, not a Drupal permission.
