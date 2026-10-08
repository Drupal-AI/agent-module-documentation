# Administer Users by Role for blocking — manual setup guide

**Administer Users by Role for blocking** (`administerusersbyrole_custom_actions`)
extends the [Administer Users by Role](https://www.drupal.org/project/administerusersbyrole)
module. Administer Users by Role lets you delegate user management to "sub-admin"
roles while restricting which other users they may touch, based on role. This
add-on grants those sub-admins a scoped **block / unblock** capability: it adds a
`block users` permission that lets a role block and unblock only users whose roles
have been marked as "safe" in Administer Users by Role's settings.

The enforcement is deliberately strict. When a user is saved and their status
changes — active becoming blocked, or blocked becoming active — the module checks
the acting user in a `hook_user_presave` handler. Unless every gate passes (the
actor has the `block users` permission and the target's roles are all within the
allowed/safe set), the save is refused with an error and the actor is redirected
back. Users who hold the full core `administer users` permission bypass these
checks, which keeps real administrators as the override.

Because this is **access-sensitive**, be honest with yourself about the model when
you set it up: the whole point is to let a limited role act on some users but not
others, so the "safe roles" list in the parent module is what actually defines the
blast radius. Get that list wrong and a sub-admin could act on accounts you did
not intend — or, more safely, be blocked from ones they legitimately need. The
module scopes the action to avoid privilege escalation, but only as well as the
safe-roles configuration you give it. It depends on Administer Users by Role and
targets Drupal 8, 9, and 10.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside
   Administer Users by Role, then grant the permission and mark safe roles.

## Where it lives in the admin menu

There is no settings form of its own. Its two configuration points live elsewhere:
the `block users` permission is on **People → Permissions**
(`/admin/people/permissions`), and the list of roles a sub-admin may act on is the
"safe roles" setting inside **Administer Users by Role**'s own configuration.

## How to use it

1. Decide which roles your sub-admins are allowed to block/unblock, and mark those
   roles as safe in Administer Users by Role's settings.
2. On **People → Permissions**, grant the **block users** permission to your
   sub-admin role — and to that role only. Do not grant the full core *Administer
   users* permission unless you intend that role to bypass all of these checks.
3. Test as the sub-admin, not as user 1: confirm they can block a user whose roles
   are all safe, and confirm they are refused (with an error and redirect) when
   they try to block a user who holds a non-safe role.
