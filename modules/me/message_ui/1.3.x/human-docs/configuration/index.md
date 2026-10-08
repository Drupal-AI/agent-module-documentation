# Configuration

Message UI has no settings form. You "configure" it by granting the right
permissions to your roles and by knowing where its forms live. This page walks
through both.

## Set up permissions

Go to **People → Permissions** (`/admin/people/permissions`) and look for the
*Message UI* group. There are two kinds of permission.

### Broad permissions

| Permission | What it allows |
|------------|----------------|
| **Bypass message access control** | Full create/view/edit/delete on *any* message, regardless of template. Grant only to trusted administrators. |
| **Update tokens** | Lets a user update a message's tokens from the edit form. |
| **View any message template** | View messages of any template. |
| **Edit any message template** | Edit messages of any template. |
| **Create any message template** | Create messages of any template. |
| **Delete any message template** | Delete messages of any template. |
| **Delete multiple messages** | Access the bulk delete form at `/admin/config/message/message_delete_multiple`. |

### Per‑template permissions

For every message template you have defined, Message UI generates four
permissions — **view**, **create**, **update**, and **delete** *(that template's)*
message. These appear in the same *Message UI* group once templates exist. Use
them to hand different roles responsibility for different message types — for
example, letting a support team create "contact log" messages without touching
notification messages.

If you don't see the per‑template permissions, make sure at least one Message
template has been created (in the Message module) and clear caches.

## The message interface

Message UI registers these routes. Access to each is decided by the permissions
above (plus any access rules other modules add through the module's hooks).

| Path | Purpose |
|------|---------|
| `/message/add` | Lists every template the current user may create. If only one is available, it redirects straight to that template's create form; if none, it points to the template‑creation page. |
| `/message/add/{template}` | The create form for a specific template. |
| `/message/{id}` | View a single message. |
| `/message/{id}/edit` | Edit a message. |
| `/message/{id}/delete` | Delete a message (with a confirmation step). |
| `/admin/config/message/message_delete_multiple` | Bulk‑delete many messages at once. |

## Operation links in Views

Message UI provides a Views field that renders **view / edit / delete** operation
links on each message row (the Message Notify UI submodule adds a **notify**
link). Add this field to any view that lists message entities to build a
moderation or audit screen — each link respects the same permissions, so users
only see the operations they're allowed to perform.

## Extending access in code

If permissions alone aren't enough, the module invites several hooks so other
modules can allow or deny operations, alter the rendered message, or narrow the
bulk‑delete query. Those are developer extension points — see the sibling
[`agent/`](../agent/start.md) docs for the exact hook signatures.
