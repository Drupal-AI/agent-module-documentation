<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simplenews Resend (simplenews_resend) — agent index

Adds a permission-gated "Reset newsletter status" action to **Simplenews** newsletter nodes. Confirming
it resets an already-sent issue's `simplenews_issue.status` from `SIMPLENEWS_STATUS_SEND_READY` back to
`SIMPLENEWS_STATUS_SEND_NOT` and saves the node, so Simplenews' normal send flow (spool, cron/mail)
becomes available again. The module sends no mail and does not change recipient targeting — it only
clears the sent flag; the actual re-send is a separate Simplenews send.

- **Requires:** `simplenews`. Version **2.0.0**. Core `^8 || ^9 || ^10 || ^11`. Package: Mail.
- **No config**, no config schema, no services beyond one access checker, no Drush commands, no submodules.

## What it provides
- **Entity form** `node.simplenews_resend` → `Drupal\simplenews_resend\Form\SimplenewsResendForm`
  (a `ContentEntityConfirmFormBase`), registered onto the node entity type in
  `simplenews_resend_entity_type_build()` (`.module`).
- **Route** `entity.node.resend_status` at `/node/{node}/resend` (`.routing.yml`) — the confirm form,
  gated by the `_reset_newsletter_status` requirement.
- **Access checker** service `access_check.simplenews_resend.reset_newsletter_status` →
  `Drupal\simplenews_resend\Access\ResetNewsletterStatusAccessChecker` (`applies_to: _reset_newsletter_status`).
- **Permission** `reset simplenews status` (`.permissions.yml`).
- **Node operation** `resend` ("Reset newsletter status") added in `simplenews_resend_entity_operation_alter()`,
  only when `Url::access()` passes; and a **local task** tab `entity.node.resend_status` (`.links.task.yml`).
- **hook_help** for `help.page.simplenews_resend` (`.module`).

## Solution docs
- [The resend action — route, permission, access & confirm form](action/resend.md)
