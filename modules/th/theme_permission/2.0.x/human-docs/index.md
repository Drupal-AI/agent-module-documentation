# Theme Permission — manual setup guide

**Theme Permission** (`theme_permission`) replaces Drupal core's single,
all-or-nothing **Administer themes** permission with **per-theme** permissions. Out
of the box, core lets you either manage every theme or none — there is no middle
ground. With this module you can allow a role to install, uninstall, set as
default, or configure only *specific* themes on the Appearance page, leaving the
rest untouched.

This is useful whenever you want to hand out partial, least-privilege theme
access: letting a "designer" role manage just the front-end theme, letting a
marketing team manage their brand's theme while the admin theme stays protected,
or giving a client access to a single theme's settings and nothing else. On a
multi-brand site, each brand's team can manage its own theme independently.

For every installed theme, the module automatically generates a matching pair of
permissions — one to administer that theme and one to uninstall it — plus a single
**Edit Administration theme** permission that controls who can change the admin
theme. It then rewrites the Appearance page so each user only sees, and can only
act on, the themes they are permitted to manage. Because these permissions are
generated per theme, the exact list you see on the permissions page depends on
which themes are installed.

The module has **no configuration form of its own** — you assign the generated
permissions on Drupal's normal permissions page, and everything else happens on the
standard Appearance page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the generated per-theme permissions
   and how to assign them.

## Where it lives in the admin menu

There is no dedicated settings page. You assign the per-theme permissions at
**People → Permissions** (`/admin/people/permissions`), and the themes themselves
are managed on the standard **Appearance** page (`/admin/appearance`), which this
module modifies to respect the permissions.

## How to use it

Once enabled, open the permissions page, find the new per-theme permissions (for
example "Administer themes olivero"), and grant them to the roles that should
manage each theme. Those roles will then see a trimmed-down Appearance page
showing only the themes they can manage. See [Configuration](configuration/index.md)
for the full picture.
