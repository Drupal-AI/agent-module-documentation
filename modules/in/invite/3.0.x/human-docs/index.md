# Invite — manual setup guide

**Invite** (`invite`) lets the people already on your site invite others to join.
An existing user sends an invitation — either as an email or as a shareable
invite link — and the module tracks that invitation through its lifecycle, from
"sent" to "accepted". It's the classic building block for invite-only
communities, referral programs, and any signup flow where growth is meant to
spread person to person.

The base module provides the invitation framework, permissions, and the tracking
of who invited whom. Two optional submodules add the actual sending methods:
**Invite by Email** (`invite_by_email`) sends invitations to an email address,
and **Invite Link** (`invite_link`) generates a link a user can share however
they like. Enable whichever delivery method fits your site.

A word on safety before you start: an invitation — an invite link especially —
is effectively a *key* to joining your site. Whoever holds a valid invite link
can use it to register, so treat these tokens as sensitive: keep who may send
invitations restricted through permissions (to stop the invite system being used
for spam), and remember that the email addresses your users enter are personal
data you are now responsible for.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose your sending submodules.
2. [Configuration](configuration/index.md) — the invite settings form and the
   permissions that decide who may send invitations.

## Where it lives in the admin menu

Once enabled, Invite's settings form lives at **Invite settings**
(`invite.invite`). You reach it from the admin configuration area; see the
[Configuration](configuration/index.md) page for what each option does and for
the permissions that govern who can send invitations.
