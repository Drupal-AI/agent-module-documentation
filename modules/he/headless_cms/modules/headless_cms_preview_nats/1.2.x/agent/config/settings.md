<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preview NATS — settings & published message

## Enable

```
drush en headless_cms_preview_nats -y
```

Requires the `nats` module with at least one configured client (the server URL, credentials and TLS
live there) and the parent `headless_cms_preview` module.

## Settings (added to the Preview settings form)

This submodule has **no route of its own**. `headless_cms_preview_nats_form_headless_cms_preview_settings_alter()`
adds a *NATS Settings* details section to `/admin/config/headless-cms/preview`
(gated by `administer headless_cms settings`), and `_headless_cms_preview_nats_settings_submit()`
writes them to the `headless_cms_preview_nats.settings` config object:

| Field | Config key | Default | Notes |
|---|---|---|---|
| Enable NATS Integration | `enabled` | `false` | Master toggle |
| NATS Client | `nats_client` | `null` | Required; options = `NatsClientManagerInterface::getAvailableClients()` |
| Topic Prefix | `topic_prefix` | `null` | Required; prefix for the published subject |

Schema: `config/schema/headless_cms_preview_nats.settings.yml`.

## What gets published

`EventSubscriber\HeadlessPreviewEventSubscriber::onHeadlessPreviewUpdated()` runs on
`headless_cms_preview.preview_updated`. If `enabled` is false it returns immediately. Otherwise it
loads the configured client and publishes:

- **Subject**: `sprintf('%s.%s.%s--%s', topic_prefix, account->id(), entity_type_id, bundle)` —
  e.g. `mysite.42.node--article` (editor uid 42 saved a preview of an article).
- **Payload**: `['operation' => 'update']`.

A frontend subscribes to the relevant subject (optionally per editor uid) and reloads the preview
when a message arrives. Combine with `headless_cms_preview`'s per-consumer preview URLs to fetch the
fresh draft over JSON:API.

## Operations note

TLS/auth/connection are the responsibility of the chosen `nats` client; this module only calls
`publish()`. Harden the NATS connection in the `nats` module configuration.
