<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Tag Manager: Events (google_tag_events) — agent index

Developer-facing add-on to `google_tag`. Provides a PHP service to push events into the GTM
`dataLayer` from server code — including events raised right before a redirect, which are stashed
and replayed on the next rendered page (works for anonymous visitors too). There is **no admin UI
for defining events**; the only setting is a Debug-mode toggle. Depends on `google_tag ^2.0` and
`js_cookie ^1`. Core `^9.2 || ^10 || ^11`.

Configure route: `google_tag_events.settings_form` at
`/admin/config/services/google-tag/events/settings`, gated by google_tag's own
**`administer google_tag_container`** permission (this module declares none). Defines one plugin
type (`google_tag_event`). No drush commands.

- **Push an event from PHP; the service API and how events reach the page** → [api/service.md](api/service.md)
- **Encapsulate event-data prep in a plugin (the `google_tag_event` plugin type)** → [plugins/event-plugins.md](plugins/event-plugins.md)
- **The Debug-mode setting (config object, form, drush/PHP)** → [configure/settings.md](configure/settings.md)

Key facts:
- Service id `google_tag_events` (class `Drupal\google_tag_events\GoogleTagEvents`); procedural
  shortcut `google_tag_events_service()`. Main method:
  `setEvent(string $name, array $data = [], bool $save_to_tempstore = TRUE)`.
- Plugin type: manager `plugin.manager.google_tag_events` (`GoogleTagEventsPluginManager`),
  base `GoogleTagEventsPluginBase`, interface `GoogleTagEventPluginInterface::process()`,
  directory `Plugin/google_tag_event`, `@Plugin` annotation, alter hook `hook_google_tag_events_alter`.
  A plugin whose `id` equals the event name shapes that event's data; optional `weight` orders pushes.
- Config object `google_tag_events.settings`, single key `debug_mode` (boolean, default `false`).
  Form `Drupal\google_tag_events\Form\SettingsForm` (form id `google_tag_events_settings`).
- Runtime: `hook_page_attachments` attaches library `google_tag_events/tracking`; `hook_page_bottom`
  renders queued events via a lazy builder (`google_tag_events.lazy_builder:getEvents`);
  `hook_ajax_render_alter` flushes events raised during AJAX via the `googleTagEventsSettings` command.
- Cross-request delivery: private tempstore collection `google_tag_events`; for anonymous users a
  cookie-backed store (`PrivateTempStoreCookie`, cookie prefix `STYXKEY_gte_ptsc_`) carries events
  across a redirect and is migrated into the real tempstore on login. Tempstore factory service
  `google_tag_events.private_tempstore` (deprecated in favor of `tempstore.private`).
