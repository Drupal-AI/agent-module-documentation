# Masquerade — manual setup guide

**Masquerade** (`masquerade`) lets privileged users temporarily switch into
another person's account — "become" that user — and then switch back to their
own, all **without knowing the target's password**. It's the classic tool for
support and QA: reproduce a bug that only one user hits, view the site exactly as
a member sees it, or verify that a role grants precisely the access you intended.

Switching is safe and permission‑gated. Access is controlled by two fixed
permissions — *masquerade as any user except super user* and *masquerade as super
user* — plus a **dynamically generated per‑role permission** for every role
(for example *masquerade as editor*). That lets you grant "become an editor"
without also granting "become an admin". When someone switches, Masquerade
regenerates the session ID (guarding against session fixation), fires the normal
logout/login hooks, and records the impersonation in Drupal's log, so there's an
audit trail of who impersonated whom.

Users switch from the `/masquerade` form, from a **Masquerade** block you can
place in a region, or from a **Masquerade** tab on a user's profile page. They
switch back at `/unmasquerade` or via an **Unmasquerade** link in the account
menu. The module depends only on core's **User** (`user`) module.

There is **no dedicated admin settings form**. Once enabled, the main things to
do are grant the right permissions and, optionally, place the Masquerade block.
Its only settings are a per‑block "show unmasquerade link" checkbox and a single
`update_user_last_access` config flag that has no UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — granting permissions, placing the
   Masquerade block, the switch UI, and the one config flag.

## Where it lives in the admin menu

Masquerade has no settings page of its own (`configure` is null). It surfaces in
a few places instead:

- **People → Permissions** (`/admin/people/permissions`) — where you grant the
  masquerade permissions to roles.
- **Structure → Block layout** (`/admin/structure/block`) — where you can place
  the **Masquerade** block.
- The `/masquerade` form and the **Masquerade** tab on any user's profile
  (`/user/{user}/masquerade`) — where authorized users actually switch.

See [Configuration](configuration/index.md) for how to set each of these up.
