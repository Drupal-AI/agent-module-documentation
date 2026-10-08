# Config Delete — manual setup guide

**Config Delete** (`config_delete`) adds a small admin form for **deleting a
single configuration object** — either a simple config item or a config entity —
straight from the Drupal UI. Normally there is no delete button for a stray piece
of configuration: an orphaned `field.storage.*` left behind by an uninstalled
module, a leftover view or image style, a broken config entity that errors in its
own admin form. Config Delete gives a trusted administrator a UI to remove those
without writing an update hook or reaching for Drush and Devel.

The form optionally deletes the object's declared **config dependencies** too, so
you can cascade-delete a config entity along with the sub-configs it depends on in
one action. Because deleting configuration can break a site, the form carries a
prominent warning and is gated behind a dedicated, access-restricted permission
rather than the usual "administer" permissions.

This is a developer/administrator tool. It has **no settings of its own** — no
settings form, no schema, no default config, and no Drush commands. It only
requires core's **Configuration Manager** (`config`) module and works on Drupal
10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   grant the permission.

(There is no separate configuration page — the module has no settings. Using it
is covered below.)

## Where it lives in the admin menu

The tool appears as a **Delete** tab under **Configuration → Development →
Configuration synchronization** (`/admin/config/development/configuration/delete`).

## How to use it

1. Grant the **Delete configuration** permission to a trusted administrator role
   (People → Permissions). It is marked as a restricted-access permission — give
   it only to roles you trust, since misuse can break the site.
2. Go to `/admin/config/development/configuration/delete` (the **Delete** tab on
   the Configuration synchronization screen).
3. Choose a **Configuration type** — `Simple configuration` for a plain config
   object (for example `system.site`), or a config-entity type such as *View*,
   *Image style*, or *Field*.
4. Choose the specific **Configuration name** of that type.
5. Optionally tick **Delete config dependencies** to also delete the objects
   listed in this item's own dependencies. (Note: this deletes the config *this*
   object depends on — not other config that depends on it.)
6. Read the warning, then click **Delete**.

Deleting configuration that other config or modules rely on can break your site,
so use this on a development or staging environment first, and export/back up your
config before pruning anything in production.
