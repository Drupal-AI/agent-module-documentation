<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & access model

## Permissions (`notification_message.permissions.yml`)

| Permission | Gates |
|---|---|
| `administer notification message content` | Full CRUD on `notification_message` entities (this is the entity's `admin_permission`). |
| `administer notification message types` | Manage `notification_message_type` bundles (this is the type entity's `admin_permission`). |
| `view any unpublished notification message` | View messages whose date window is not current, regardless of author. |
| `view own unpublished notification message` | View out-of-window messages the user authored. |

None of these are declared `restrict access: true`, but `administer notification message
content`/`types` are broad admin permissions — treat them as trusted.

## Access model (`src/Entity/NotificationMessageAccess.php`)

`checkAccess()` for a `notification_message`:

1. If the account holds the entity admin permission (`administer notification message
   content`), all operations are allowed.
2. Otherwise, for the **`view`** operation:
   - If the message is currently **published** (now within its start/end window,
     `isPublished()`), view is **allowed for everyone** — messages are broadcast content.
   - If **not** in-window: allowed only to the author with `view own unpublished notification
     message`, or to anyone with `view any unpublished notification message`.
3. All other operations fall through to `neutral` (denied unless another module grants).

**Design note (checked, not a vulnerability):** notification messages are *broadcast*, not
per-recipient private content. There is no per-user inbox and no "owner-only" read of an
in-window message — an active message is intentionally public. So "can user A read user B's
notification?" does not apply: an active message is shown to all visitors by design, and the
only non-public state is the out-of-window (draft/expired) case, which the two `unpublished`
permissions gate correctly. The display block additionally calls `->access('view')` on each
message after querying with `accessCheck(FALSE)`, so this handler is the single enforcement
point.
