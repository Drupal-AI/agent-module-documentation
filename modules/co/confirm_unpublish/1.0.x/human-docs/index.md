# Confirm Unpublish — manual setup guide

**Confirm Unpublish** (`confirm_unpublish`) shows a confirmation dialog when an
editor unpublishes a node, so taking a page off the site becomes a deliberate act
rather than an unnoticed checkbox. In Drupal, unpublishing is just the "Published"
checkbox on the node form, sitting next to Save with the same visual weight as
editing a title — but the consequence is very different: the page vanishes from the
site, from menus, and from search results, and anyone holding its URL gets an
access‑denied. Editors clear that box by accident more often than you would think,
and nobody notices until someone reports a dead link. A confirmation dialog is the
standard remedy for an action that is cheap to confirm but expensive to undo
unnoticed.

The module can also optionally **log** each confirmed unpublish to Drupal's
database log (the *Recent log messages* report), recording the user name and the
node path — handy for an audit trail. By default the dialog appears for **all**
content types, but you can exclude specific ones from the module's settings form.
It depends only on core's **Node** module and supports Drupal 10.2 and 11.

Two honest caveats. First, this is a **safeguard, not a lock**: it reduces
mistakes, but a user can still proceed to unpublish after confirming — it does not
prevent the action or add a permission. Second, if your editorial process really
needs unpublishing to be a controlled, permissioned, logged step, core's
**Content moderation** with an explicit *Archived* state is a stronger fit than a
dialog. This module is the right size when full moderation would be more process
than the team wants. Note the project is **not covered by Drupal's security
advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — customise the message, turn logging
   on, and exclude content types.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Content authoring →
Confirm Unpublish** (`/admin/config/content/confirm-unpublish`).
