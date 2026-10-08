# Admin Login Path — manual setup guide

**Admin Login Path** (`admin_login_path`) makes Drupal's user‑account pages —
login, register, password reset, one‑time‑login, and account cancellation — render
with your site's **administration theme** instead of the front‑end theme. If your
admin theme is something like Claro or Gin and you'd like staff to sign in against
that same familiar, on‑brand look, this module does it in one enable step — no
custom theme negotiator or theme code required.

> ## What this module is *not*
>
> Despite its name, Admin Login Path does **not** move, rename, or hide
> `/user/login`, and it adds **no** access restriction, protection, or
> security‑through‑obscurity to the login flow. The default account paths remain
> reachable exactly as they are in core — it only changes the *theme* they render
> in. There is no lockout risk and no login‑path relocation here; if you need to
> actually relocate or protect the login URL, this is not that module.

It's a zero‑configuration theming helper. A route subscriber flags the core
account routes as "admin routes," which makes Drupal's theme negotiator serve them
with the configured admin theme. So that anonymous visitors can actually see the
admin theme on the login and register pages, the module's install step grants
core's **View the administration theme** permission to both the anonymous and
authenticated roles. (That permission only controls theme visibility — it does not
expose any admin route or data.)

The module works on **Drupal 8.9 through 11**, has no dependencies, and defines no
settings form, permissions, Drush commands, or plugins of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Nowhere — there is no settings page or menu item. Enabling the module is all there
is to it. Your admin theme is chosen at **Appearance**
(`/admin/appearance`), as always.

## How to use it

There is **nothing to configure**. Enable the module and the account pages
immediately render with whatever administration theme your site uses. The affected
pages are the standard core account routes: `/user/login`, `/user/register`,
`/user/password` (and the reset‑request/one‑time‑login forms), and the account
cancellation confirmation page.

To change *which* administration theme is used, pick a different admin theme at
**Appearance**. To revert entirely, simply uninstall the module — the routes go
straight back to the front‑end theme.

> **Note on uninstall:** removing the module reverts the theming immediately, but
> the **View the administration theme** permission it granted to the anonymous and
> authenticated roles is **not** automatically revoked. If you don't want those
> roles to keep it, remove it by hand on the **People → Permissions** page after
> uninstalling.
