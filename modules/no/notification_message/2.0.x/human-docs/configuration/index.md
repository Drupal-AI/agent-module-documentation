# Configuration

Notification Message has no single settings form. You configure it in three
parts: **message types** (the templates/bundles your notifications belong to),
the **messages** themselves, and the **block** that displays them. This page
walks through each, plus the permissions that control who can do what.

## 1. Message types (bundles)

Go to **Structure → Notification message types**
(`/admin/structure/notification-message-types`). A *global* type is provided out
of the box; you can use it as‑is or create your own (for example *Alert*,
*Promo*, *Info*) so different kinds of notice can be styled and behave
differently.

When you add or edit a type, you can set:

- **Label** and **machine name** — the human name and internal id.
- **Help** and **Description** — guidance text shown on the type's add/edit
  forms.
- **Allow conditions** — when on, messages of this type can attach Drupal
  Condition plugins (role, request path, and so on) to limit where they appear.
- **Condition data types** — which context data types the condition picker
  offers for this type.
- **Show dismiss button** — adds a close (×) control to messages of this type so
  visitors can dismiss them. Dismissal is remembered across sessions with a
  cookie.
- **Dismiss button text** — the label for that button (default *Close*).

Because message types are Field UI bundles, each one has a **Manage fields** tab.
Use it to attach extra fields to a type — an image, a link, an icon, a severity
level — and they become part of every message of that type.

## 2. Messages

Go to **Content → Notification messages**
(`/admin/content/notification-message`) and click to add a message. Each message
has:

- **Label** *(required)* — an internal title for the message.
- **Message** — the body text, edited with a rich‑text format.
- **Authored by** — the author reference; defaults to you.
- **Publish start date** *(required)* — when the message begins showing. Defaults
  to *now*.
- **Publish end date** *(required)* — when it stops showing. Defaults to two days
  later.
- **Conditions** — shown only if the message's type has *Allow conditions* on.
  Add one or more Condition plugins here to limit where the message appears.
- **All conditions required** — when ticked, every condition must match (AND);
  unticked, any one matching is enough (OR).

A key idea: there is **no published/unpublished checkbox**. A message is
considered published purely because *right now* falls between its start and end
dates. Once the end date passes, the message disappears on its own (cron helps
clear it from caches promptly). This means you can schedule several announcements
in advance and each one appears and vanishes on its own schedule.

## 3. Place the block

Go to **Structure → Block layout** (`/admin/structure/block`) and place the
**Notification messages** block into whatever region you want (often a header or
highlighted region). The block has two settings:

- **Type** — choose which message types this block should display. **Leave it
  empty to show all types.**
- **Display mode** — the view mode used to render each message (for example
  *full*), letting you show a compact or full version per block instance.

The block only ever renders messages whose date window is currently open, that
the viewer is allowed to see, and whose conditions (if any) pass.

## Permissions

Set these at **People → Permissions** (`/admin/people/permissions`):

- **Administer notification message content** — full create/edit/delete access to
  messages. A trusted, broad admin permission.
- **Administer notification message types** — manage the message types (bundles)
  and their fields. Also a trusted admin permission.
- **View any unpublished notification message** — view messages whose window is
  not currently open (upcoming or expired), regardless of who wrote them. Useful
  for editors who need to preview scheduled announcements.
- **View own unpublished notification message** — view out‑of‑window messages the
  user authored.

The access model is broadcast‑oriented: while a message is within its window it
is public — every visitor can see it, by design. The only non‑public state is a
message outside its window, and the two "unpublished" permissions above control
who may preview those.

## Theming (optional)

If you want to style messages, the module provides Twig templates
(`notification-message.html.twig` for a single message,
`notification-messages.html.twig` for the block wrapper) and a range of template
suggestions by view mode, bundle, and message id — so you can theme a single
message, a whole type, or the block container. See the
[`agent/`](../agent/start.md) theming notes for the exact suggestion names.
