# Add To Head — manual setup guide

**Add To Head** (`add_to_head`) lets you inject arbitrary HTML, CSS, or JavaScript
into your pages from the admin UI — scoped to the paths and user roles you choose.
It is the quick way to drop in a Google Analytics or Tag Manager snippet, a
Facebook/Meta pixel, a search-engine verification `<meta>` tag, a chat widget, or a
temporary announcement banner, all without editing a theme template or doing a code
deploy.

You work in terms of named **profiles**. Each profile has a machine name, a block of
raw code, a **scope** (where the code is injected), and visibility rules for which
**paths** and which **roles** it applies to. At render time, `head`-scope profiles
are added early in the document `<head>` (before CSS and JS), and `scripts`-scope
profiles are added near the bottom of the page. You can stage several profiles —
say, Facebook, Google, and LinkedIn pixels — as separate entries so each can be
toggled on and off independently.

Because it injects code verbatim, the module is powerful and a little dangerous:
whoever holds its permission can put arbitrary markup and scripts on every page.
That permission is therefore marked security-sensitive — grant it only to people you
trust. The module is dependency-free and works on Drupal 8.8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — creating profiles, the three scopes,
   and the path/role visibility rules.

## Where it lives in the admin menu

The profile manager is at **Configuration → Development → Add To Head**
(`/admin/config/development/add-to-head`), gated by the *Administer add to head*
permission.

## One thing to know before you start

The **`styles`** scope is offered in the profile form but does **not** currently
render anywhere — its implementation is an intentional placeholder. For CSS, use the
`head` scope with an inline `<style>` block (or a `<link>` tag) instead. See
[Configuration](configuration/index.md) for the full details.
