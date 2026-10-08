# Redirect After Login — manual setup guide

**Redirect After Login** (`redirect_after_login`) sends a user to a specific
internal page the moment they log in — with a **different landing page for each
role**. Editors can land on the content overview, administrators on the admin
dashboard, customers on their account page, and ordinary members on a member
dashboard, all from a single settings form.

It's a lightweight, core-only module (no contributed dependencies). When a user
logs in, it looks up the destination configured for their role and rewrites
Drupal's post-login redirect so they end up there. Because a user can hold several
roles, the module resolves priority by using the **last role** in the user's role
list; if no destination is set for that role, it falls back to the front page
(`/`). Destinations must be **internal** paths (external URLs are rejected), and
you can maintain an exclude list of pages where redirection should be skipped.

The module is careful about not getting in the way: an explicit `?destination=`
deep link is respected rather than overridden, password-reset and one-time-login
flows are always skipped, and maintenance mode falls back safely. For custom
needs, a dispatched event lets other modules change the target or cancel the
redirect, and there's integration with passwordless login. It's a simpler,
per-role-only alternative to the more configurable Login Destination module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set a post-login destination per
   role, the exclude list, and the permission.

## Where it lives in the admin menu

The settings page is at **Configuration → People → Redirect After Login**
(`/admin/config/people/redirect`, also linked from the People section as "Set
Login Destination"). Reaching it requires the *Administer redirect_after_login
settings* permission. (An older path, `/admin/config/system/redirect`, simply
forwards to the same form.)

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the settings form and enter a destination path for each role.
3. Save, then log in as a user with one of those roles to confirm they land on the
   right page.

See [Configuration](configuration/index.md) for the field-by-field details,
including how multi-role priority works.
