<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Author Content Ownership Transfer Workflow reassigns node authorship from inactive users to a target account, automatically on cron and manually via a bulk dashboard.
---
`OwnershipTransferService` identifies content owned by users deemed inactive (per the module's settings) and transfers those nodes to a configured target user; `hook_cron` runs `transferInactiveUsersContent()` on schedule. Admins configure the policy at `/admin/config/ownership-transfer`, run ad-hoc reassignments from the bulk dashboard at `/admin/config/ownership-transfer-bulk`, and review an analytics dashboard at `/admin/config/ownership-transfer-dashboard` showing transfer activity.

All three routes require the `administer author content transfer` permission (restricted to trusted roles). The operations mutate node ownership in bulk, so the permission should be tightly scoped. The module makes no outbound requests and stores no secrets; its risk surface is the ownership mutation itself, which is admin-gated.
---
- Automatically reassign content from inactive authors.
- Run ownership transfer on cron.
- Transfer inactive users' nodes to a target account.
- Configure the inactivity policy on the settings form.
- Bulk-transfer ownership from the dashboard.
- Preview transfer analytics before/after runs.
- Reassign orphaned content when an author is deactivated.
- Keep content attributed to an active editor.
- Restrict transfers to a trusted admin role.
- Review which nodes were transferred and when.
- Consolidate content ownership during team changes.
- Handle offboarding by moving content off a leaver's account.
- Choose the destination user for transfers.
- Trigger a one-off bulk transfer manually.
- Audit ownership-transfer activity on the analytics dashboard.
- Avoid leaving nodes owned by disabled accounts.
- Apply ownership policy site-wide via cron.
- Limit who can perform bulk reassignment.