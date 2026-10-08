<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Headless CMS - Notify NATS (headless_cms_notify_nats) — agent index

Provides a **`nats`** transport plugin for Headless CMS - Notify: publishes each notification
message to a NATS.io subject. Version **1.2.x**. Core `^10.3 || ^11`. Depends on `nats:nats`,
`headless_cms:headless_cms`, `headless_cms_notify:headless_cms_notify`. Requires a running NATS
server and a client configured in the `nats` module. No routes, permissions or config schema of its
own — configured on a `headless_notify_transport` entity.

## What it provides

- **Transport plugin** `HeadlessNotifyNatsTransport`
  (`src/Plugin/HeadlessNotifyTransport/HeadlessNotifyNatsTransport.php`), id **`nats`**,
  implements `HeadlessNotifyTransportPluginFormInterface`. Config:
  - `nats_client` (required select; options from `NatsClientManagerInterface::getAvailableClients()`),
  - `topic_prefix` (required; validated by regex `^[a-zA-Z0-9\_\-\.]+[a-zA-Z0-9]+$` — no trailing dot).
- **`send()`** loads the chosen client (`NatsClientManagerInterface::get()`), builds subject
  `sprintf('%s.%s', topic_prefix, $message->getType())`, dispatches
  `HeadlessNotifyNatsBeforeSendEvent` (subject is mutable), then `$client->publish($subject,
  $message->toJson())`.
- **Event** `headless_cms_notify_nats.before_send` (`Event\HeadlessNotifyNatsBeforeSendEvent`,
  public mutable `$topic`, readonly `$message`).

## Notes

- Connection, auth and TLS are handled entirely by the selected `nats` client — this module does not
  open sockets or hold credentials itself.
- Payload is the Notify message JSON `{type, subType, params}`; subject is `<prefix>.<type>`, e.g.
  `mysite.entity_operation` / `mysite.cache_rebuild`.

## Configure

Add a transport at `/admin/config/headless-cms/notify/transports/add`, choose **NATS**, pick a
client + prefix, then reference it from a consumer's Notify settings. See the parent Notify docs:
[../../headless_cms_notify/1.2.x/agent/start.md](../../headless_cms_notify/1.2.x/agent/start.md) and
[api/transport.md](api/transport.md).
