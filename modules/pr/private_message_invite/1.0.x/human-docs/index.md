# Private Message Invites — manual setup guide

**Private Message Invites** (`private_message_invite`) extends the
[Private Message](https://www.drupal.org/project/private_message) module so the
manager of a message thread can **invite other people into that thread by email
address**. The invited person then chooses to accept or decline; on acceptance,
they're automatically added to the thread's members and taken straight to the
conversation.

It handles both people who already have an account and brand-new email addresses,
and the invitation emails are customisable (with separate wording for existing
versus new users). Each invitation is stored as its own small entity that tracks
the target email, the thread, who created it, and its status (pending or
accepted), so the state of every invite is auditable.

The invite flow is careful about validation and access. When you send an invite,
the form rejects malformed addresses, addresses that already belong to the
thread, and duplicate invitations. The accept and decline links are protected by
a custom access check: only the invited user (while they're not yet a member) or
the person who created the invite can act on it — everyone else, including
anonymous visitors, is refused. Sending invites and editing the email templates
are each gated behind their own permissions, described in Configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside
   Private Message, then enable it.
2. [Configuration](configuration/index.md) — grant the invite permissions and
   customise the invitation emails.

## Where it lives in the admin menu

The invitation **email templates** are edited at **Configuration → Private
Message → Invite Email Configurations**
(`/admin/config/private-message/invite`).

## How to use it

1. Grant the right permissions (see [Configuration](configuration/index.md)).
2. Open a private-message thread. You'll see an **Invite Members** action link.
3. Enter the email address of the person to invite and submit. A pending
   invitation is created and an email is sent.
4. The recipient follows the **accept** link to join the thread (they're added to
   its members and redirected into the conversation) or the **decline** link,
   which removes the invitation. A thread creator can also withdraw a pending
   invite. Logged-in users with pending invitations see a warning message linking
   to their invitations list.
