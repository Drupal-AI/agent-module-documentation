<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NATS transport — configuration, publishing & event

## Prerequisites

- The `nats` contrib module enabled and at least one NATS client configured (this is where the
  server URL, credentials and TLS live — not in this submodule).
- A reachable NATS server.

```
drush en headless_cms_notify_nats -y
```

## Create the transport

At `/admin/config/headless-cms/notify/transports/add` choose **NATS**.
`HeadlessNotifyNatsTransport::buildConfigurationForm()` renders:

| Setting | Key | Notes |
|---|---|---|
| NATS Client | `nats_client` | Required; options = `NatsClientManagerInterface::getAvailableClients()` |
| Topic Prefix | `topic_prefix` | Required; regex `^[a-zA-Z0-9\_\-\.]+[a-zA-Z0-9]+$` (letters/numbers/dashes/dots, no trailing dot) |

Assign the transport to a consumer under *Consumer → Additional Settings → Headless CMS → Notify*.

## Publishing (`send()`)

For each applicable consumer:

1. `$client = $this->natsClientManager->get($config['nats_client'])`.
2. `$topic = sprintf('%s.%s', $config['topic_prefix'], $message->getType())` — e.g.
   `mysite.entity_operation`, `mysite.cache_rebuild`.
3. Dispatch `HeadlessNotifyNatsBeforeSendEvent($topic, $message)` — subscribers may overwrite
   `$event->topic`.
4. `$client->publish($event->topic, $message->toJson())`.

Payload example (subject `mysite.entity_operation`):
`{"type":"entity_operation","subType":"node","params":{"id":"12","uuid":"…","bundle":"article","operation":"update"}}`.

## Altering the subject

Subscribe to `HeadlessNotifyNatsBeforeSendEvent::EVENT_NAME`
(`headless_cms_notify_nats.before_send`) and mutate the public `$topic` property, e.g. to add the
entity type or environment into the subject. `$message` is available (readonly) for context.

## Security / operations note

TLS, authentication and connection pooling are the responsibility of the chosen `nats` client;
this transport neither disables TLS nor stores credentials. Harden the NATS connection in the
`nats` module's client configuration.
