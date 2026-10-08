# Configuration

Setting up Private Message is a three‑part job: grant the right **permissions**,
place the **blocks** that make up the messaging interface, and adjust the global
**settings** to taste. This page covers each in turn.

## 1. Permissions

Grant permissions at **People → Permissions** (`/admin/people/permissions`).
Private Message defines several; the important ones are:

| Permission | Lets a role… |
|---|---|
| `use private messaging system` | Send and receive messages and reach the inbox, composer, thread view, and block pages. This is the base permission every messaging user needs. Most routes also require core's *access user profiles*. |
| `delete own private message` | Delete messages the user wrote. |
| `delete private message thread for all` | Delete a whole thread for every member, not just clear their own copy. |
| `add private message ban entities` | Block another user. |
| `view` / `edit` / `delete private message ban entities` | View, edit, or delete block records. |
| `delete any private message` | Moderator: delete any user's messages. |
| `administer private messages` | Administer the message and thread content and their field displays. |
| `administer private message module` | Reach all of the module's admin and config routes. |

Typical setups:

- **Ordinary members** — `use private messaging system` (plus core *access user
  profiles*), and usually `delete own private message` and `add private message ban
  entities` so they can tidy their own messages and block people.
- **Moderators / admins** — add `administer private messages`, `delete any private
  message`, and `administer private message module`.

## 2. Place the blocks

The messaging UI is delivered through three blocks, placed at **Structure → Block
layout** (`/admin/structure/block`). Add the ones you need to appropriate regions of
your theme:

| Block | What it shows | Key settings |
|---|---|---|
| **Private message inbox** (`private_message_inbox_block`) | A list of the user's most recent conversations, refreshed over AJAX. | Number of threads to show, how many to load per AJAX request, and the refresh rate. |
| **Private message notification** (`private_message_notification_block`) | An unread badge. | Refresh rate, and whether to count unread **messages** or unread **threads**. |
| **Private message actions** (`private_message_actions_block`) | Action links, such as starting a new message. | — |

Some sites receive ready‑made block placements automatically when a compatible
theme is present; otherwise, place them yourself.

## 3. The settings page

Open **Configuration → Private Message → Private Message Config**
(`/admin/config/private-message/config`). This form is where you tune the module's
global behavior. The main options:

### Notifications

- **Enable notifications** *(on by default)* — whether the module offers and sends
  new‑message notifications (used by the email submodule).
- **Notify by default** *(on by default)* — send notifications by default; users can
  override this in their own profile.
- **Notify while using** *(default no)* — whether to notify a user even while they
  are actively on the messaging page.

### Presence and behavior

- **Seconds considered away** *(default 120)* — how many idle seconds before a user
  counts as "away" from a thread, which affects notifications.
- **Autofocus** *(on by default)* — automatically focus the message input box.
- **Send key(s)** *(default Enter)* — the keyboard key(s) that send a message.
- **Hide recipient field when prefilled** *(off by default)* — hide the recipient
  field when a recipient has already been passed in through the URL.
- **Remove CSS** *(off by default)* — turn on to drop the module's bundled styles so
  you can theme the interface entirely yourself.

### Message labels

- **Create message label** *(default "Create Private Message")* — the label of the
  create action.
- **Send button label** *(default "Send")* — the label of the send button.

### Blocking (ban) settings

- **Ban mode** *(default passive)* — choose **passive** or **active** blocking.
- **Ban message** *(default "User is unable to receive your message")* — shown when
  someone tries to message a user who blocked them.
- **Block / Unblock / Block page labels** — customize the wording of the block and
  unblock buttons and the link to the blocking page.

Note that this settings page is extensible: other modules can add their own sections
to it through a plugin, so you may see additional groups if such a module is
enabled. Click **Save configuration** to apply your changes.

## Displaying and extending the entities

The message and thread entities have Field UI base routes under **Structure →
Private message**, where you can add fields and adjust the display and form of a
thread. On a thread's *Manage display*, formatters control how the conversation and
its member list render (message count, load order, refresh rate, and so on), and a
recipient autocomplete widget powers composing — it automatically hides users who
have blocked the current user.
