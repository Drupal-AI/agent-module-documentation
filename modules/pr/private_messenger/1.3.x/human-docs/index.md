# Private Messenger — manual setup guide

**Private Messenger** (`private_messenger`) is, despite the name, **not**
user-to-user chat. It's an administrator's tool for leaving a specific user a
**warning, status, or error message that appears on that user's next login**. It
extends Drupal core's messenger so that when something has happened to a user's
account or data — an action was applied, a profile needs updating — you can make
sure they see a note about it the next time they sign in, alongside any other
notification you send.

Under the hood, each message is a small `private_messenger_message` content entity
that an administrator creates against a recipient user, choosing the message type
(warning / status / error) and the text. When that recipient next logs in, Drupal
displays the message through its normal messenger and then deletes the stored
entity, so the same note isn't shown again (and so the table doesn't fill up).

Two things to note. First, everything here is **admin-gated**: creating, listing,
editing, and deleting these messages all require the module's administration
permission, and there is no user-facing or anonymous surface. Second, messages
are targeted at individual recipients — there's no cross-user "read someone
else's messages" surface, because only holders of the admin permission can see
the message list at all.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no settings form** for this module. You work with it entirely by
creating and managing message entities in the admin content area (or
programmatically), as described below.

## Where it lives in the admin menu

Messages are managed under **Content → Private Messenger Messages**
(`/admin/content/private-messenger-message`) — add, edit, and delete them there.
All of these actions require the **Access private messenger message overview**
permission.

## How to use it

- **Grant the permission.** At **People → Permissions**, give the *Access private
  messenger message overview* permission to the staff role that should manage
  these messages. Keep it to trusted administrators — the message text is treated
  as safe markup, so only trusted users should be able to author it.
- **Create a message for a user.** From
  `/admin/content/private-messenger-message`, add a message: pick the type
  (warning/status/error), write the text, and choose the recipient user. Optional
  placeholder parameters can be supplied.
- **What the recipient sees.** On their next login, the message is shown via
  Drupal's messenger and then removed automatically (it is preserved during a
  masquerade session so an admin impersonating the user doesn't consume it).
- **Programmatic creation.** Developers can create a `private_messenger_message`
  entity directly (setting `type`, `recepient_uid`, `message`, and optional
  parameters) — handy for firing a login notice from custom code when an
  automated action affects a user.
