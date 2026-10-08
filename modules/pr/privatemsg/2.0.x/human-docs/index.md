# Private Messages (Privatemsg) — manual setup guide

**Private Messages** (`privatemsg`) lets the members of your site send private
messages to one another — an inbox, threaded conversations, read/unread state,
and bulk actions — without anyone having to share an email address. It's the
classic messaging module for community-oriented Drupal sites such as forums,
social networks, membership sites, and marketplaces, and this is the Drupal
10/11 line of that long-running project.

Messages and threads are modelled as content entities, so they have their own
view modes and full Views integration. Out of the box you get a message list with
filters, mass actions (mark read / mark unread), a block showing a new-messages
counter, the ability to write to any number of users or to whole roles, optional
email notification of new messages (a per-user checkbox), user blocking with an
"unblockable" role, and personal tags on threads. Administrators can view other
users' messages.

Because a community's inbox needs bulk operations, the module depends on the
contributed **Views Bulk Operations** module for its "mark read / delete" mass
actions, along with several core modules. Three optional submodules exist to
migrate existing message data in from older sites — two for Drupal 6 and one for
Drupal 7.

A word of caution worth keeping in mind on any messaging system: messages are
**private by definition**, so before you trust it on a site where the messages
matter, test that a user cannot reach another user's thread or message by editing
the ID in the URL, that deleted or unpublished messages stay unreachable, and
that the inbox listings filter by the current user. Note also that the 2.0.x line
has been a release candidate (2.0.0-rc22) through a long stabilisation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Views Bulk Operations), enable it, and choose migration submodules if you're
   coming from Drupal 6 or 7.
2. [Configuration](configuration/index.md) — grant the messaging permissions and
   review the module settings.

## How members use it

Once permissions are granted, members compose messages to one or more users (or
to a role), read and reply in threaded conversations, mark messages read/unread,
tag threads, and delete conversations. The new-messages counter block can be
placed in a region so members always see when they have mail, and users can
opt in to email notification of new messages from their profile.
