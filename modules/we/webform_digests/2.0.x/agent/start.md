<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Submissions Notification (webform_digests) — agent index

Sends **periodic digest emails** of webform submissions instead of one email per submission. You
create a `webform_digest` **config entity** per webform (recipient, from, subject, body, and the
target webform); on cron the module queues one job per digest, and a queue worker loads the
submissions that changed inside the frequency window, optionally filters them by `#states`
conditions, groups them by **source entity**, and mails one message per source entity. All of
recipient/from/subject/body run through **token replacement**, and the module exposes a
`webform_digest` token type (submission-label list + count) for the body.

The schedule is driven by `hook_cron` gated on config `webform_digests.settings` (`cron.enabled`,
`cron.frequency` = hour/day/week, `cron.hour`) and a `State` timestamp `webform_digests.last_run`.
There is **no settings UI** — the cron behaviour is changed only by overriding that config in
`settings.php`. Queueing can also be triggered manually via the JSON route
`webform_digests.send` or the drush command `webform:queue-digests`. The actual send is done by the
`webform_digest_queue` QueueWorker on the next cron run.

- Depends on: `webform:webform`. No composer.json ships; no optional/soft dependencies.
- Core: `^9 || ^10 || ^11`. Package: `Webform`. Namespace: `drupal/webform_digests`.
- **No dedicated settings page / `configure` route.** Ships config schema
  (`webform_digests.settings` + the `webform_digest` config entity) but its runtime knobs are
  overridden in `settings.php`, not through a form.
- Permissions: `edit any webform digest`, `send webform digest` (both `restrict access: true`).
  Digest entity CRUD is gated by core `administer site configuration`.
- Drush: yes — `webform:queue-digests` (plus a legacy Drush-8 `queue-digests` in `.drush.inc`).
- Defines **no custom plugin type**; uses the core `QueueWorker` plugin type.

## What you'd do → where

- **Create / edit a digest (recipient, from, subject, body, which webform, tokens)** →
  [configure/digests.md](configure/digests.md)
- **Restrict a digest to a subset of submissions with conditional logic (`#states`)** →
  [configure/digests.md](configure/digests.md)
- **Change how often digests run, the send hour, disable the built-in cron, or trigger a send
  from a URL / drush / an external scheduler** → [configure/scheduling.md](configure/scheduling.md)
- **Call `queueSubmissions()` / `sendMessage()` from code, understand the queue worker, the mail
  handler, the controller, the tokens and the hooks** → [api/services.md](api/services.md)

## Key facts (real machine names)

- Config entity: **`webform_digest`** (`Entity\WebformDigest`, `ConfigEntityType`, `config_prefix:
  webform_digest`, `admin_permission: administer site configuration`). Stored keys: `id`, `label`,
  `recipient`, `originator`, `subject`, `body`, `conditions`, `webform`, `uuid`.
- Routes:
  - `webform_digests.send` (`GET /admin/structure/webform_digests/send`) → `Controller\DigestController::sendAction`; perm `send webform digest`; returns JSON `{"queued": <n>}`.
  - `webform_digests.conditions_form` (`/admin/structure/webform_digests/{webform_digest}/conditions`) → `Form\WebformDigestConditionsForm`; perm `edit any webform digest`.
  - Entity routes via `WebformDigestHtmlRouteProvider` (extends `AdminHtmlRouteProvider`):
    `entity.webform_digest.collection` (`/admin/structure/webform_digests`), `.add_form` (`/add`),
    `.canonical` (`/{webform_digest}`), `.edit_form` (`/{webform_digest}/edit`),
    `.delete_form` (`/{webform_digest}/delete`) — all require `administer site configuration`.
- Services: `webform_digests.queue_builder` (`WebformDigestsQueueBuilder`),
  `webform_digests.mail_handler` (`WebformDigestsMailHandler`),
  `webform_digests.webform_route_context` (`ContextProvider\WebformDigestRouteContext`, tagged
  `context_provider`), `webform_digests.drush` (`Commands\WebformDigestsCommands`).
- QueueWorker plugin id: **`webform_digest_queue`** (`Plugin\QueueWorker\WebformDigestQueue`,
  `cron = {"time" = 30}`). Queue name is the same: `webform_digest_queue`.
- Permissions: `edit any webform digest`, `send webform digest` (`webform_digests.permissions.yml`).
- Config object: `webform_digests.settings` — keys `cron.enabled` (bool, default `TRUE`),
  `cron.frequency` (`hour`|`day`|`week`, default `day`), `cron.hour` (int, default `9`).
- State: `webform_digests.last_run` (int timestamp of the last queue build).
- Hooks (in `.module` / `.tokens.inc`): `hook_cron`, `hook_mail` (key `digest`),
  `hook_entity_operation` (adds a **Conditions** operation to each digest), `hook_token_info`,
  `hook_tokens`.
- Token type: **`webform_digest`** (`needs-data`); tokens `id`, `label`, `subject`,
  `submissions` (rendered `item_list` of submission labels), `submissions_count`.
- Drush: `webform:queue-digests` (`WebformDigestsCommands::queueDigests`); legacy
  `webform_digests_drush_command()` / `drush_webform_digests_queue_digests()` in
  `webform_digests.drush.inc`.
- Menu link `entity.webform_digest.collection` (under `system.admin_structure`); action link
  `entity.webform_digest.add_form` on the collection.
