# Domain Menus — manual setup guide

**Domain Menus** (`domain_menus`) gives each domain on a
[Domain Access](https://www.drupal.org/project/domain) site its own set of menus.
On a single Drupal install that serves several domains, you can give each domain
an independent main menu, footer menu, or any other named menu — and delegate
editing those menus to per-domain editors without handing out the powerful
"administer menus" permission.

A menu becomes a "domain menu" simply by being assigned to one or more domains.
The module can do this in bulk: on its settings form you list menu "names" (like
`main` or `alt`) and, with one click, create a matching menu for every domain,
auto-named `dm<domainId>-<name>` (for example `dm1-main`). New domains get their
menus created automatically, and deleted domains have theirs cleaned up. You can
also mark any hand-made menu as a domain menu by assigning it domains on the menu
edit form.

Access is the other half of the story. Two permissions — **Edit assigned domain
menus** and **Edit active domain menus** — let editors work only on the menus of
domains they are assigned to (the "active" variant additionally requires the menu
to belong to the currently active domain). A management page at
`/admin/structure/domain-menus` shows each user the domain menus they may edit.
Two blocks render the active domain's version of a menu, and an optional
submodule adds a Superfish drop-down version.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the optional Superfish submodule.
2. [Configuration](configuration/index.md) — the settings form (menu names, bulk
   create/delete, display options) and the two editing permissions.

## Where it lives in the admin menu

The settings form sits at **Configuration → Domain → Domain Menus**
(`/admin/config/domain/domain_menus`) and is gated by the Domain module's
**Administer domains** permission. The per-user management list is at **Structure
→ Domain menus** (`/admin/structure/domain-menus`).

## How to use it

Typical flow: on the settings form, enter the menu names you want (for example
`main` and `footer`), tick **Create menus**, and save — the module builds one
menu per name per domain. Then grant your per-domain editors the **Edit assigned
domain menus** permission so they can manage their own domain's navigation.
Finally, place a **domain menu block** (or the Superfish variant) in your theme to
render the active domain's version of a menu. See
[Configuration](configuration/index.md) for the details.
