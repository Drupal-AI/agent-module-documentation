# Admin Role UI — manual setup guide

**Admin Role UI** (`admin_role_ui`) makes Drupal's **administrator‑role settings**
behave the way admin roles actually work in code, and in doing so stops
administrators from accidentally locking themselves out. In modern Drupal, whether a
role is an "administrator role" (one that bypasses permission checks) is governed by
an `is_admin` flag stored in configuration. The core UI's single *Administrator role*
selector doesn't fully reflect that, which can lead to surprising results.

This module alters the core role settings form to **disable** that core
*Administrator role* selector and instead **surface which roles currently have the
`is_admin` flag set**. Admin‑role status is then managed through configuration (the
`is_admin` flag) rather than through the dropdown — aligning the UI with how the
setting really works and matching configuration‑management workflows. As a safeguard,
it also hides the submit button when only the administrator role remains, and it links
to help explaining how to change the administrator role.

It is purely a form/UI override: it has no routes, services, or permissions of its
own, and it requires no configuration. Its whole job is to make the admin‑role screen
safer and clearer, which is especially valuable on sites with more than one
administrator.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module has no page of its own. It changes the existing **role settings** screen,
reached from **People → Roles** (`/admin/people/roles`) — specifically the role
settings form where the administrator role is chosen.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open the role settings form under **People → Roles**. You will see that the core
   *Administrator role* selector is disabled, and the screen now shows which roles
   currently have `is_admin` set, along with help text explaining the behaviour.
3. To change which role is the administrator role, manage the `is_admin` flag through
   configuration (for example via your exported configuration), as the on‑screen help
   describes.

There is nothing to configure — enabling the module is all that's required.
