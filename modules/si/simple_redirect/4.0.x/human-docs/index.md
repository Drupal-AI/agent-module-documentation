# Simple Redirect — manual setup guide

**Simple Redirect** (`simple_redirect`) is a lightweight way to send one internal
path to another with a permanent (301) redirect. You define a "from" path and a
"to" path in the admin UI, and whenever a visitor requests the "from" URL the
module immediately forwards them to the "to" URL. It is meant for the everyday
case — a page moved, a URL changed, an old link you want to keep working — without
pulling in the much larger Redirect module.

Each redirect is stored as a small configuration entity, so you can add, edit, and
delete as many as you like from a single admin list. The edit form keeps you out of
trouble: it insists that both paths start with a slash, refuses to redirect away
from the front page or from a path with an anchor fragment, and blocks duplicate
"from" paths. Because the destination is always an admin-configured internal path,
there is no way for a visitor to steer the redirect somewhere unexpected — this is
not an open-redirect risk.

The module does nothing until you create your first redirect — there is no global
behavior to switch on, and it adds no permissions of its own (managing redirects
uses the core **Administer site configuration** permission). It depends only on
Drupal core and works on Drupal 8.9 through 10 (it is not marked compatible with
Drupal 11).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add, edit, and manage your redirects.

## Where it lives in the admin menu

Once enabled, manage your redirects at **Configuration → Search and metadata →
Simple Redirect** (`/admin/config/search/simple-redirect`). You'll see a list of
existing redirects with a button to add a new one.
