# Configuration

Most of getting Private Messages running is a matter of granting the right
**permissions** and, if you want it, placing the new-messages block. The module
also has a settings form (the `privatemsg.settings` config) for site-wide message
options.

## Permissions

Go to **People → Permissions** (`/admin/people/permissions`) and grant these to
the appropriate roles:

- **Administer privatemsg** — full administrative control over the messaging
  system, including its settings and viewing other users' messages. This is a
  restricted permission; keep it to administrators only.
- **Privatemsg write messages** — allows a user to compose and send private
  messages. Grant this to whichever member roles should be able to message each
  other (commonly *authenticated user*).
- **Privatemsg use messages actions** — allows the bulk/mass actions in the
  message list, such as marking messages read or unread.
- **Privatemsg delete own messages** — allows a user to delete their own
  messages/conversations.

## The settings form

Private Messages provides a settings form (`privatemsg.settings`) for site-wide
options — this is where behaviour such as message notification and the messaging
defaults live. Because messages are entities, the message and thread types also
have their own display settings (view modes) that you can adjust under the
entity's *Manage display*.

## Blocking and the unblockable role

The module lets members **block** other users so they can't be messaged, and lets
you designate an **unblockable role** — members of that role (for example
moderators or support staff) can always reach users regardless of blocks. Set the
unblockable role in the module's settings so that your staff can never be silenced
by an ordinary member.

## New-messages counter block

Private Messages provides a block that shows a member's count of new messages.
Place it from **Structure → Block layout** in whichever region suits your theme
so members always see when they have unread mail.

## Access, and what to check

Everything a member can do is bounded by the permissions above, and administrators
(with *Administer privatemsg*) can view other users' messages. Because the
messages are private, it's worth confirming on your own site that a member cannot
open another member's thread or message by changing the ID in the URL, that
deleted messages stay unreachable, and that the inbox Views list only the current
user's messages — these are the checks that matter most for any messaging system.
