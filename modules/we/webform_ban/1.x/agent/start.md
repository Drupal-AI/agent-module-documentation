<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Ban (webform_ban) — agent index

Small glue module between the **Webform** module and Drupal **core's Ban module**. Version **1.2.4**.
It does **not** enforce anything itself — it gives submission moderators one-click tools to push a
webform submission's stored IP (`WebformSubmission::getRemoteAddr()`) into core's site-wide ban list
via the `ban.ip_manager` service. Actual blocking is done by core Ban's HTTP middleware, which then
returns 403 to that IP for the whole site (which incidentally stops it re-submitting forms).

Three pieces make up the surface: (1) `hook_entity_operation()` adds a **"Ban IP Address"** operation
link on each `webform_submission` row that opens core's ban admin form (`ban.admin_page`) with the
submission's IP pre-filled in a modal; (2) an Action plugin `webform_submission_ban_ip_address` that
bans the selected submissions' IPs; (3) an Action plugin `webform_submission_ban_and_delete_action`
that bans then routes to the multi-delete confirm form. Both actions are registered as
`system.action.*` config entities in `config/install`.

- Depends on: `webform:webform` (info.yml). **Soft-depends on core `ban`** — NOT declared in
  info.yml; the operation hook guards with `moduleExists('ban')`, but the two Action plugins call
  `\Drupal::service('ban.ip_manager')` unguarded (they fatal if run while `ban` is disabled).
- Core: `^9 || ^10 || ^11`. Package: none (no `package:` key in info.yml).
- No settings page / `configure` route. No config schema of its own (ships `config/install` actions
  only). Defines **no** permissions, services, routes, drush commands, or plugin types.
- Consumes core Ban's permission **`ban IP addresses`** and service **`ban.ip_manager`**.

## What you'd do → where

- **Ban a submitter's IP (operation link, or the two bulk-operation actions), understand access &
  the ban/delete flow** → [plugins/actions.md](plugins/actions.md)

## Key facts (real machine names)

- Hook: `hook_entity_operation()` in `webform_ban.module` — adds operation `block` (title
  "Ban IP Address") on `webform_submission` entities; shown only when `ban` is enabled, the current
  user has `ban IP addresses`, and the IP is not already banned. Links to route `ban.admin_page`
  with `['default_ip' => <remote_addr>]`, modal via `WebformDialogHelper::DIALOG_NARROW`.
- Action plugin id `webform_submission_ban_ip_address` (class
  `Drupal\webform_ban\Plugin\Action\WebformSubmissionBanIpAddress`, type `webform_submission`,
  extends `ActionBase`). `execute()` calls `ban.ip_manager->banIp()` if `isBanned()` is false;
  `access()` requires permission `ban IP addresses`.
- Action plugin id `webform_submission_ban_and_delete_action` (class
  `…\WebformSubmissionBanAndDeleteAction`, type `webform_submission`, extends webform's
  `WebformSubmissionDeleteAction` → core `DeleteAction`). `executeMultiple()` bans each IP then calls
  `parent::executeMultiple()`; `confirm_form_route_name` = `webform_submission.multiple_delete_confirm`.
- Config entities (`config/install`): `system.action.webform_submission_ban_ip_address`,
  `system.action.webform_submission_ban_and_delete_action`.
- External symbols consumed: service `ban.ip_manager` (`Drupal\ban\BanIpManager` — `isBanned()`,
  `banIp()`), permission `ban IP addresses`, routes `ban.admin_page` and
  `webform_submission.multiple_delete_confirm`, `WebformSubmission::getRemoteAddr()`.
