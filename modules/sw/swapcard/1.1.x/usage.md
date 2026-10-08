<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Swapcard integrates Drupal with the Swapcard event platform's GraphQL API through a plugin manager that formats queries and sends authenticated requests over Guzzle.

---

The base module is a developer-facing shell: a config form at `/admin/config/services/swapcard/config` (gated by `administer site configuration`) stores the API key and Guzzle options (base URI, timeout), and pinging the API on key entry validates the connection. Swapcard "plugins" (annotation `@Swapcard`, base `SwapcardPluginBase`) declare the GraphQL fields to request; `queryString()` builds the GraphQL body recursively and `post()` sends it, returning the decoded response. The API key is sent in an `Authorization: <key>` header and requests use Guzzle defaults (TLS verification left on).

The optional `swapcard_content` submodule (requires Queue UI) creates four content types — Swapcard Events, Sessions, Speakers, Exhibitors — and syncs them from Swapcard into Drupal via a QueueWorker, on demand from the config form or on cron, including custom fields and select-list options mirrored from Swapcard. It ships a Drush command (`SwapcardCommands`) and a purge confirm form. The `swapcard_content_media` submodule adds a Media reference field and syncs Swapcard images (event banner, exhibitor logo, session banner, speaker photo).
---
- Install the base module and open `/admin/config/services/swapcard/config`.
- Paste a Swapcard API key and let the form ping the API to validate it.
- Set the GraphQL base URI and request timeout for the Guzzle client.
- Read `swapcard.settings` `guzzle_options` in custom code to reuse the configured client.
- Create a Swapcard plugin instance via `plugin.manager.swapcard` to run a query.
- Build a GraphQL query body with a plugin's `queryString()` method.
- Request only chosen fields, or all defined fields with the `all` argument.
- Send a GraphQL POST and get a decoded array via a plugin's `post()`.
- Extend outgoing field lists from another module with `hook_swapcard_request_alter()`.
- Alter plugin definitions via the `swapcard` alter hook.
- Enable swapcard_content to create Event, Session, Speaker and Exhibitor content types.
- Sync Swapcard entities into Drupal nodes on demand from the config form.
- Sync Swapcard content automatically on cron when the option is enabled.
- Process large Swapcard responses (thousands of nodes) through the QueueWorker.
- Run swapcard_content's Drush command to trigger a sync from the CLI.
- Mirror Swapcard select-list options into Drupal field allowed values.
- Purge a synced event and its content via the purge confirm form.
- Enable swapcard_content_media to add a Media image field to Swapcard content.
- Sync event banners, exhibitor logos, session banners and speaker photos as media.
- Relate synced Sessions to their Exhibitors and Speakers via entity reference.
