# Actions UI — manual setup guide

**Actions UI** (`action`) provides an admin interface for managing Drupal
*actions* — reusable tasks (publish, unpublish, delete, send email, assign owner,
and so on) that other modules such as Views Bulk Operations, ECA, and Rules
execute against content. It is the contrib continuation of Drupal core's former
`action` module, which was removed from core: the underlying `action` config
entity type still lives in core's System module, and this module supplies the
management UI and the configurable action plugins that used to ship with it.

There are two kinds of action. **Simple** actions take no configuration and appear
automatically on the actions admin page (things like publish/unpublish/delete).
**Advanced** actions are ones you create from a plugin and configure individually
— for example "unpublish any node containing a banned keyword" or "change a node's
author to a specific user." Each advanced action you create is saved as an
`action.action.*` config entity, so it can be exported to code and deployed across
environments.

The module ships three configurable advanced‑action plugins: **Change the author
of content** (`node_assign_owner_action`), **Unpublish content containing
keyword(s)** (`node_unpublish_by_keyword_action`), and the comment equivalent
(`comment_unpublish_by_keyword_action`). It also includes Drupal 6/7 migration
support for the legacy keyword actions. Access to the whole UI is gated by the core
**Administer actions** permission; the module defines no permissions, services, or
Drush commands of its own. Note this is a **pre‑1.0** release (`0.2.2`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the actions admin page and creating
   advanced actions.

## Where it lives in the admin menu

The actions admin page is at **Configuration → System → Actions**
(`/admin/config/system/actions`), gated by the core **Administer actions**
permission. Grant that permission only to trusted roles.

## How to use it

Enable the module, then visit **Configuration → System → Actions** to see the
available simple actions and to create advanced ones. See
[Configuration](configuration/index.md) for the step‑by‑step.
