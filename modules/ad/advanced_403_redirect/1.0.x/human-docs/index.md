# Advanced 403 Redirect — manual setup guide

**Advanced 403 Redirect** (`advanced_403_redirect`) changes what happens when a
visitor hits an **access-denied (403)** response. Instead of showing Drupal's
default "Access denied" page, it sends the user to a destination you choose — for
example the login page or a friendlier custom page — and lets you drive that with
rules.

The destination is **set by an administrator**, not supplied by the visitor's
request, so this does not open the door to open-redirect abuse. It is purely a
site-structure and user-experience feature: it controls *where a 403 sends the
user*, not *who gets a 403 in the first place*. It has no role in access control
beyond the permission it provides to manage its own settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the redirect destination and
   rules.

## Where it lives in the admin menu

The module adds its own settings for the 403 redirect rules and provides a
permission to control who may change them (set it on **People → Permissions**).
See [Configuration](configuration/index.md) for what you can set.
