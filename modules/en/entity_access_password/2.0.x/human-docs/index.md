# Entity Access Password — manual setup guide

**Entity Access Password** (`entity_access_password`) lets you put a **password**
in front of individual pieces of content. It works by adding a special "Password
protection" field to a content type (or any fieldable entity — taxonomy terms,
media, and so on). When an entity is marked protected, the view modes you choose
render a **password form** instead of the content until the visitor types the
correct password.

You get three kinds of password, and you can enable any combination on a field:
a **per-entity** password (each node has its own), a **bundle-wide** password
(shared by every entity of that type), and a site-wide **global** password. Any
enabled password that matches unlocks the content. Passwords are stored hashed and
checked with Drupal core's secure password service, and the unlock form reuses
core's login flood protection to slow down guessing.

Once someone enters the right password, the "access granted" state has to be
remembered somewhere — so you must enable at least one **access-storage backend**
submodule: a **session** backend (works for anonymous visitors, remembered for the
browser session) and/or a **user-data** backend (remembered per logged-in user
across sessions). Without one, visitors would have to re-enter the password on
every page.

> **Important — this is a "password curtain", not full access control.** Protection
> is applied only at the display layer (the rendered view mode) and by masking the
> title. The underlying entity data is still reachable through paths that skip that
> rendered view mode — JSON:API/REST, Views raw fields, search indexing, and any
> view mode you did not include. Private-file downloads attached to a protected
> entity *are* gated, but the field data is not. If you need true access control,
> restrict those paths separately or pair this with a real entity-access module.
> See the sibling [`agent/`](../agent/start.md) docs for detail.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and enable an access-storage backend submodule.
2. [Configuration](configuration/index.md) — the global settings, adding and
   configuring the protection field, view-mode selection, permissions, and the
   editor experience.

## Where it lives in the admin menu

- **Global settings** (the site-wide password and random-password length):
  **Configuration → Content authoring → Entity Access Password → Settings**
  (`/admin/config/content/entity_access_password/settings`).
- The **protection field** is added per bundle under **Structure → Content types →
  *(your type)* → Manage fields**, and the protection form appears via **Manage
  display**.

Both admin areas require the restricted **Administer entity access password**
permission.
