<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodules

Nine optional submodules ship in-tree under `modules/`; all depend on `conreg`. Each adds its own
routes/permissions (config forms under `admin/config/conreg/*`).

## Badges & lookup
- **conreg_badges** — "Badge making functions for ConReg." Badge-name entry (`BadgeNamesForm`) and
  print/render (`BadgePrint`) with a per-event menu deriver; client-side badge rendering via
  `textFit` + `html2canvas` + `jquery.badge_names`, uploaded through
  `BadgeUploadController` (`members/badge/upload/{eid}`). Perm `view membership badges`.
- **conreg_lookup** — "Allow lookup of member details in ConReg." `LookupMemberForm` for staff to
  look up a member's details (perm `lookup members`).

## Mailing-list framework + providers
- **conreg_mailing_list** — "Manage subscription of conreg members to mailing lists." Defines the
  **`MailingListProvider`** plugin type (attribute + manager + `MailingListProviderPluginBase`),
  a `conreg_subscription_rule` config entity (`ConregSubscriptionRule` + list builder + form),
  a `MailingListSyncService`, a queue worker (`MailingListSubscriptionWorker`), and typed
  transient/permanent exceptions. Perm `administer conreg_subscription_rule`.
- **conreg_mailerlite** — Mailerlite `MailingListProvider` (`MailerliteProvider`). Its API key is a
  **Key entity ID** resolved via `key.repository`; `key:key` is a dependency.
- **conreg_simplenews** — Simplenews `MailingListProvider` (`SimplenewsProvider`); depends on
  `simplenews`.

## External CRM / task / chat integrations
- **conreg_airtable** — "Add AirTable integration to ConReg." `AirTable` service pushes member rows
  to an Airtable base (config form `ConfigAirTableForm`, hook syncs on member change). Perm
  `configure AirTable integration`.
- **conreg_clickup** — "Add ClickUp integration to ConReg." `ConregClickUp` creates/updates ClickUp
  tasks from members (OAuth token exchange + task API). Perm `configure ClickUp integration`.
- **conreg_discord** — "Create Discord invitations from ConReg." `Discord` service +
  `ConfigDiscordForm`; adds token hooks so Easy Email templates can embed a Discord invite. Depends
  on `token`, `easy_email`. Perm `configure discord invitebot`.
- **conreg_planz** — "Add PlanZ or Zambia integration to ConReg." Pushes members into a PlanZ/Zambia
  programme-scheduling system (`PlanZ`, `PlanZUser`, badge-id source, admin + config forms, token
  hooks). Perms `configure PlanZ integration`, `PlanZ admin`. Has its own config schema.

## Notes for agents
- `conreg_mailerlite` and `conreg_simplenews` are **providers** — they require
  `conreg_mailing_list` and are useless without it.
- The airtable, clickup and discord integrations call third-party HTTP APIs over Guzzle
  (TLS verification at library default).
