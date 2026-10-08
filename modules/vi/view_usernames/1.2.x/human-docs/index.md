# View Usernames — manual setup guide

**View Usernames** (`view_usernames`) closes a privacy gap in Drupal core.
Out of the box, Drupal treats usernames as effectively public — and with
JSON:API enabled, a site's entire user base can be enumerated. This module
changes the default so that seeing someone's username becomes a **permission**
rather than an implicit right.

Once enabled, a username is visible only when the account is *Anonymous*, when
the viewer is the account owner, or when the viewer holds *Administer users* or
the new **View usernames** permission. Everyone else sees a placeholder in place
of the name. The enforcement is layered on purpose: it hooks user access and
field access for the proper checks, and adds a last-resort guard on the
username render path so that even code that forgot to ask for access still
inherits the restriction — including author fields, comment bylines, Views
username fields, and JSON:API user resources.

For sites that need finer rules, the module ships an extensible **decider**
system: you can register your own service (for example "members of the same
group may see each other's names") without patching the module. The shipped
default decider runs at a low priority so your rules can override it.

A word of warning that the permission itself repeats: granting **View
usernames** to *anonymous* or to *all authenticated users* re-opens the very
exposure the module exists to prevent — especially with JSON:API. Grant it only
to roles you trust.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission.

## Where it lives in the admin menu

There is no settings form. The one control the module adds is a permission,
**View usernames**, on the standard permissions page at **People → Permissions**
(`/admin/people/permissions`). Assign it to the roles that are allowed to see
other users' names.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **People → Permissions** and grant **View usernames** to the roles that
   should be able to see usernames — typically editors, staff, or
   administrators, and deliberately *not* anonymous or every authenticated user.
3. Review your public-facing pages afterwards. Because the restriction reaches
   into author fields, comment bylines, Views and JSON:API, some places that
   used to show a name will now show a placeholder for visitors who lack the
   permission. That is the intended effect — audit those displays and confirm
   they read the way you want.

If you need conditional visibility (colleagues in a shared group seeing each
other, for example), a developer can add a custom "decider" service; see the
[`agent/`](../agent/start.md) docs for the extension point.
