<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions and route access

Defined in `tmgmt_contentapi.permissions.yml` — one permission.

| Machine name | Title | Notes |
|---|---|---|
| `access queue process` | Access Translation Queue Process | `restrict access: TRUE` (flagged as security-sensitive in the UI). |

## What the permission gates

It is the `_permission` requirement on `tmgmt_contentapi.queue_process_in_bg`
(`/tmgmt-contentapi/queue-process-background/{queue_name}/{batch_size}`, POST). The controller
`QueueProcessController::processQueueInBackground()` drains a batch of items from one of the
module's own queues (see [api/services.md](../api/services.md)).

Beyond the permission, the controller also demands a valid `X-CSRF-Token` header (checked
against the token value `queue_process_background`), an allowlisted `{queue_name}`, and a
`{batch_size}` between 1 and 1000 — so calling it requires both the permission and a CSRF token
for that action. Grant it only to the role/automation that triggers background queue draining
(typically an authenticated admin/editor session, or a scripted client that first obtains the
CSRF token).

## Access on the other three routes (9.5.x)

The Auto-Bundle and continuous-job routes are not permission-gated; they use `_custom_access`
callbacks that defer to **entity access** on the referenced TMGMT entity:

| Route | Access callback | Rule |
|---|---|---|
| `tmgmt_contentapi.translator_auto_bundle` | `AutoBundleForm::access` | plugin id == `contentapi` **and** `update` access to the `tmgmt_translator`. |
| `tmgmt_contentapi.auto_bundle_status_refresh` | `AutoBundleStatusController::access` | delegates to `AutoBundleForm::access`. |
| `tmgmt_contentapi.continuous_submissions` | `ContinuousSubmissionsController::access` | job `isContinuous()` **and** `update` access to the `tmgmt_job`. |

So an editor who may edit a given translator/job may reach these pages; everyone else is denied.
Everything else the module does (creating translators, submitting/importing jobs, reviewing) is
governed by TMGMT's own permissions (`administer tmgmt`, `create translation jobs`,
`accept translation jobs`, etc.), not by this module.
