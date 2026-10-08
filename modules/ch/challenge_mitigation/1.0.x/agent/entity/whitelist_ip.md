<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Whitelist IP entity & admin list

## Entity `cm_whitelist_ip`
`src/Entity/ChallengeMitigationWhitelistIp.php` — `@ContentEntityType`, base_table
`cm_whitelist_ip`, label key `ip`, `admin_permission = administer challenge mitigation
whitelist`. Handlers: list builder `ChallengeMitigationWhitelistIpListBuilder`, delete form
`Core\Entity\ContentEntityDeleteForm`, access `Core\Entity\EntityAccessControlHandler`.

Base fields (`baseFieldDefinitions()`):
- `id` (integer, read-only), `uuid` (uuid, read-only).
- `ip` (string, max 45 — full IPv6, required) — the whitelisted client IP.
- `origin` (string, max 255, optional) — how it was added; the challenge form sets
  `'Default challenge mitigation'`.
- `created` (created timestamp) — used to compute expiry.

Rows are created by `ChallengeMitigationAccessForm::submitForm()` on a passed challenge and
deleted by `challenge_mitigation_cron()` once older than `whitelist_duration` minutes, or
manually via the delete form.

## Admin list — `ChallengeMitigationWhitelistIpListBuilder`
`src/ChallengeMitigationWhitelistIpListBuilder.php`, route
`entity.cm_whitelist_ip.collection` (`/admin/config/challenge-mitigation/whitelist_ips`).
- `createInstance()` injects date formatter, request stack, form builder, and reads
  `whitelist_duration` (default 1440) from config.
- `buildHeader()/buildRow()` columns: IP, Origin, Created, Expiration
  (`created + whitelist_duration*60`, formatted `short`), Operations.
- `load()` pages 50 per page (`->pager(50)`, `accessCheck(TRUE)`); an `ip_filter` query param
  applies a `LIKE %value%` condition on `ip`.
- `render()` prepends the filter form.

## Filter form — `ChallengeMitigationIpFilterForm`
`src/Form/ChallengeMitigationIpFilterForm.php`, id `challenge_mitigation_ip_filter_form`. A
single "Filter by IP address" textfield; on submit redirects to
`entity.cm_whitelist_ip.collection` with `?ip_filter=<value>`, which the list builder's
`load()` reads.

## Delete
`entity.cm_whitelist_ip.delete_form`
(`/admin/config/challenge-mitigation/whitelist_ips/{cm_whitelist_ip}/delete`) uses the core
`ContentEntityDeleteForm`. All three routes require the
`administer challenge mitigation whitelist` permission.
