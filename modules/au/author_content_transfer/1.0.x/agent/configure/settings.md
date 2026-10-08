<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Author Content Ownership Transfer

Permission for all routes: `administer author content transfer`.

- **Settings** `/admin/config/ownership-transfer` — define the inactivity policy (which users count as inactive) and the destination user that inactive authors' content is transferred to. Stored in `author_content_transfer.settings`.
- **Bulk dashboard** `/admin/config/ownership-transfer-bulk` (`BulkOwnershipTransferForm`) — run an ad-hoc bulk reassignment now.
- **Analytics dashboard** `/admin/config/ownership-transfer-dashboard` (`AnalyticsDashboardController`) — review transfer activity/preview counts.

**Automation:** `author_content_transfer_cron()` calls `OwnershipTransferService::transferInactiveUsersContent()` each cron run, applying the configured policy automatically.

**Caution:** these operations mutate `node` ownership in bulk. Grant the permission only to trusted administrators and verify the target user + inactivity policy on the settings form before enabling cron-driven transfers.
