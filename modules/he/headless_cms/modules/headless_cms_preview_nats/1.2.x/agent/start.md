<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Headless CMS - Preview NATS (headless_cms_preview_nats) — agent index

Publishes a NATS message when a **headless preview is saved**, for real-time frontend live-reload.
Version **1.2.x**. Core `^10.3 || ^11`. Depends on `nats:nats`, `headless_cms:headless_cms`,
`headless_cms_preview:headless_cms_preview`. Requires a running NATS server + a configured `nats`
client.

## What it provides

- **Event subscriber** `EventSubscriber\HeadlessPreviewEventSubscriber` — subscribes to
  `headless_cms_preview.preview_updated` (`HeadlessPreviewUpdatedEvent`). When
  `headless_cms_preview_nats.settings:enabled` is true, loads the configured NATS client and
  `publish()`es `['operation' => 'update']` to subject
  `sprintf('%s.%s.%s--%s', topic_prefix, account->id(), entity->getEntityTypeId(), entity->bundle())`.
- **Settings** — no route of its own; `hook_form_headless_cms_preview_settings_alter()`
  (`.module`) adds a *NATS Settings* section (enable / `nats_client` / `topic_prefix`) to the parent
  Preview settings form at `/admin/config/headless-cms/preview`, with its own submit handler
  `_headless_cms_preview_nats_settings_submit()`.
- **Config object** `headless_cms_preview_nats.settings` — `enabled` (bool, default false),
  `nats_client` (string, default null), `topic_prefix` (string, default null); schema in
  `config/schema`.

## Notes

- Connection, auth and TLS are handled by the selected `nats` client, not here.
- The published subject encodes the editing user id + entity type/bundle so a frontend can subscribe
  narrowly.

## Solution docs

- **Enable, the NATS settings section, the published subject/payload** →
  [config/settings.md](config/settings.md)

Parent module: [../../headless_cms_preview/1.2.x/agent/start.md](../../headless_cms_preview/1.2.x/agent/start.md).
