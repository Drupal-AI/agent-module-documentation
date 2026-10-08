<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alert message (alert_message) — agent index

Dismissable site-wide alert banners as **content entities** (`alert_message`), rendered by one **Block
plugin**, with **role/user targeting** and **cron-driven scheduling**. Depends on contrib `entity` and
core `text`, `datetime`, `block`. Version **1.1.1**. **Core `^11.1` — Drupal 11.1+ only.** No config
schema, no Drush, no new plugin types. Permissions: yes (dynamic, from the Entity API module).

- **The `alert_message` entity — fields, the publish/unpublish scheduling, targeting, the validation
  constraint, cron, and permissions** → [configure/entity.md](configure/entity.md)
- **Placing and rendering the block — the lazy builder, the dismiss cookie/JS, the page-cache policy
  and cache metadata, and the templates** → [blocks/block.md](blocks/block.md)

Key facts:
- Nothing shows until you **place the `alert_message` block** in a region (`/admin/structure/block`).
  Alerts are authored at `/admin/content/alert-message` (collection) → *Add alert message*.
- Entity fields (`Entity/AlertMessage.php::baseFieldDefinitions`): `label` (string, required),
  `message` (`text_long`, required, rendered `text_default` → filtered by its text format), `users`
  (entity_reference→user, unlimited), `roles` (entity_reference→user_role, unlimited), `publish_date`
  + `unpublish_date` (datetime, both required), `to_publish` (bool), `status` (bool), `uid`, `created`,
  `changed`. Translatable; `base_table` `alert_message`, `data_table` `alert_message_field_data`.
- **You never set `status` by hand.** `preSave()` resets `status`/`to_publish` then sets them from the
  date window: publish in the future → `to_publish = TRUE`; window currently open → `status = TRUE`.
- **Constraint** `AlertMessagePublishDates` rejects an unpublish date in the past or ≤ the publish date.
- **`hook_cron`** re-`save()`s alerts matching `to_publish = TRUE` OR `status = TRUE`, so each one's
  `preSave()` re-evaluates the window. Scheduling granularity = your cron frequency (not real-time).
- **Rendering**: block `#lazy_builder` → `AlertMessageLazyBuilder::build()` loads `status = TRUE`
  alerts, filters by `getTargetedRoleIds()` ∩ current roles and `getTargetedUserIds()` ∋ current uid
  (empty targeting = show to all), views each, wraps in `#theme block__alert_messages`.
- **Dismiss**: `js/alert_message_read.js` appends the id to the `alertMessageClosed` cookie (JSON array,
  `path=/`) and removes the node; `template_preprocess_alert_message()` skips ids found in that cookie.
  Purely client-side, per browser session — **no server dismiss route exists**.
- **Caching**: block cache tag `alert_message_list`; contexts `cookies:alertMessageClosed`, `user`,
  `user.roles`. `AlertMessageDismissedRequestPolicy` (a `page_cache_request_policy` service) returns
  `DENY` when the dismiss cookie is present so Dynamic Page Cache serves per-cookie variants
  (Varnish-compatible, avoids CLS).
- **Permissions**: module ships `administer alert message` (restrict access). The Entity API
  `EntityPermissionProvider` adds `access alert_message overview`, `view alert_message`,
  `view own unpublished alert_message`, `create alert_message`, `update own/any alert_message`,
  `delete own/any alert_message`. Field UI adds the usual `administer alert_message fields/display/...`.
- **Settings page** (`admin/structure/alert-message`, `entity.alert_message.settings`) is a placeholder
  — it only tells you to configure fields in Field UI; it is not the module's `configure` link.
- **User lifecycle hooks**: on account cancel, `alert_message_user_cancel()` unpublishes (block method)
  or reassigns to uid 0; `alert_message_user_predelete()` deletes the user's authored alerts.
- **Templates** (overridable): `templates/alert-message.html.twig` (single alert + close button; ships
  crude inline styles), `templates/block--alert-messages.html.twig` (loops the alerts).
