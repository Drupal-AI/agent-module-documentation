# Friendship — manual setup guide

**Friendship** (`friendship`) adds friendship and connection workflows between users,
turning a plain Drupal site into something more social. Users can follow one another,
send and accept friend requests, and manage their connections — the building blocks
of a community or membership site where people relate to each other, not just to
content.

The typical flow is Follow → Unfollow, and Accept → Remove friend: a user follows
another, the other can accept to form a mutual friendship, and either side can
unfollow or remove the connection later. On top of this the module exposes several
**Views fields** you can add to listings and profiles — "Total friends number",
"Total followers number", "Total following number", and a "Friendship action link"
that renders the right follow/unfollow/accept control for the current viewer.

Because friendship data is inherently **personal and social**, treat it with care:
expose friend lists only to the extent your privacy expectations allow, and gate
friend management behind the module's permissions. Note that a friendship
relationship is not, by itself, a content‑access grant — it doesn't unlock protected
content unless some other module chooses to build on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — placing the friendship link on user
   profiles, customizing the action labels, and the Views fields available to you.

## Where it lives in the admin menu

Friendship's settings (the follow/unfollow label text) are at **Administration →
Configuration → People → Friendship settings**
(`/admin/config/people/friendship-settings`), and the follow/unfollow link is placed
on the user account display at **People → Account settings → Manage display**
(`/admin/config/people/accounts/display`). See
[Configuration](configuration/index.md).
