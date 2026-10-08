<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `tmgmt_contentapi.permissions.yml` — one permission.

| Machine name | Title | Notes |
|---|---|---|
| `access queue process` | Access Translation Queue Process | `restrict access: TRUE` (flagged as security-sensitive in the UI). |

## What it gates

It is the `_permission` requirement on the only route the module defines,
`tmgmt_contentapi.queue_process_in_bg`
(`/tmgmt-contentapi/queue-process-background/{queue_name}/{batch_size}`, POST). The controller
`QueueProcessController::processQueueInBackground()` drains a batch of items from one of the
module's own queues (see [api/services.md](../api/services.md)).

Beyond the permission, the controller also demands a valid `X-CSRF-Token` header (checked
against the token value `queue_process_background`), an allowlisted `{queue_name}`, and a
`{batch_size}` between 1 and 1000 — so calling it requires both the permission and a CSRF token
for that action. Grant it only to the role/automation that triggers background queue draining
(typically an authenticated admin/editor session, or a scripted client that first obtains the
CSRF token). Everything else the module does (creating translators, submitting/importing jobs,
reviewing) is governed by TMGMT's own permissions (`administer tmgmt`, `create translation jobs`,
`accept translation jobs`, etc.), not by this module.
