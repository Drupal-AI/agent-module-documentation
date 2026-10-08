<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Author Content Ownership Transfer Workflow (author_content_transfer) — agent index

**Reassigns node ownership away from inactive users automatically (cron) and via a bulk dashboard + analytics.**

- **Version:** 1.0.x (1.0.0)  •  **Core:** ^10 || ^11  •  **Package:** Content authoring
- **Depends on:** node, user
- **Routes (all `administer author content transfer`):** settings `/admin/config/ownership-transfer`; bulk `/admin/config/ownership-transfer-bulk`; analytics `/admin/config/ownership-transfer-dashboard`.
- **Service:** `author_content_transfer.transfer_service` → `OwnershipTransferService` (`transferInactiveUsersContent()`).  **Cron:** `author_content_transfer_cron()`.
- **Permission:** `administer author content transfer`.

**Security:** all routes gated by the single `administer author content transfer` permission; bulk ownership mutation is admin-only. No outbound calls or secrets. Scope the permission tightly since it can mass-reassign authorship. See [configure/settings.md](configure/settings.md).
