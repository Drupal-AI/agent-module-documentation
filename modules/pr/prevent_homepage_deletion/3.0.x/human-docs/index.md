# Prevent Homepage Deletion — manual setup guide

**Prevent Homepage Deletion** (`prevent_homepage_deletion`) is a safety net that
stops editors from deleting — or even unpublishing — the nodes that hold your
site's most important pages. Out of the box it protects the nodes configured as
your **front page**, your **404 (page not found)** page, and your **403 (access
denied)** page, and you can add any number of extra pages (like a privacy policy,
a terms page, or a key landing page) to the protected list.

Protection works by taking away, not granting. For a protected node, the *Delete*
tab disappears, the delete link is removed from the content overview, and
`/node/N/delete` returns "access denied". The module also hides the **Published**
checkbox on a protected node's edit form, so those pages can't be quietly
unpublished either. Bulk "Delete content" actions skip protected nodes and show an
explanatory message so editors understand why.

The one escape hatch is a dedicated permission, **Delete homepage node**. Grant it
to a single trusted role (say, a site owner) and they can still delete or
unpublish protected pages when they genuinely need to — for example when replacing
the front-page node during a redesign. (Note that Drupal's core *Bypass content
access control* permission, and user 1, override this module entirely.)

The module works on Drupal 9, 10, and 11, needs PHP 8.1+, and depends only on
core's Node module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission.
2. [Configuration](configuration/index.md) — the settings form, the protected URL
   list, and which pages are always protected.

## Where it lives in the admin menu

Its settings form sits at **Configuration → System → Prevent page deletion**
(`/admin/config/system/prevent-homepage-deletion`).

## How to use it

1. Enable the module. Immediately your front page, 404, and 403 nodes are
   protected — no configuration needed.
2. (Optional) Add extra pages to protect on the settings form (see
   [Configuration](configuration/index.md)).
3. Decide who, if anyone, may still delete protected pages, and grant them the
   **Delete homepage node** permission (see
   [Installation](installation/index.md#grant-the-permission)).
