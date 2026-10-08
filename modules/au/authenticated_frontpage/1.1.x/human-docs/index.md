# Custom Frontpage for Authenticated users — manual setup guide

**Custom Frontpage for Authenticated users** (`authenticated_frontpage`) lets
logged-in visitors see a **different front page** from anonymous visitors — without
redirecting them anywhere. Drupal only has one front-page setting, so a site whose
public homepage is a marketing page but whose members expect a dashboard normally has
to choose one or bolt on a redirect. This module lets you keep both: anonymous
visitors get the public homepage, members get their own page, and both live at the
same `/` URL.

The important design choice is that it serves different content at the same path rather
than redirecting. An event subscriber intercepts the front-page request and resolves it
to the configured alternative for authenticated users. That keeps `/` meaningful for
everyone — the "home" link still points home for both audiences, and there is no extra
redirect round trip or changed URL. This is the main reason to reach for it instead of a
redirect module.

Its single setting is protected by the **`administer authenticated_frontpage
configuration`** permission, which is marked as access-restricted — appropriate, since
it decides what a whole class of users sees first. There are no dependencies beyond
core, and it supports a wide range of Drupal versions (8 through 11).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.
2. [Configuration](configuration/index.md) — set the authenticated-users front page and
   the cache caveat to check.

## Where it lives in the admin menu

Once enabled, the settings form sits at
**Configuration → System → Custom Frontpage for Authenticated users**
(`/admin/config/system/authenticated-frontpage`), gated by the
**`administer authenticated_frontpage configuration`** permission.
