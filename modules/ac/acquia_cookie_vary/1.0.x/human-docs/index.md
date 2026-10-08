# Acquia Cookie Vary — manual setup guide

**Acquia Cookie Vary** (`acquia_cookie_vary`) makes cached responses **vary by
specific cookies** on the Acquia platform. When a page can legitimately differ
depending on a cookie value — say a language preference or an A/B-testing bucket —
this module tells the platform cache to store a separate cached copy per cookie
value, instead of serving one cached page to everyone regardless of their cookie.

It is a **performance / caching** feature for Acquia-hosted sites: used correctly,
it lets you keep pages on the edge cache while still respecting the handful of
cookies that genuinely change what a visitor should see.

**Caching by cookie is security-sensitive, so choose the cookies carefully.** Vary
only by cookies that safely partition **public** content. **Never** vary (and
therefore cache) by a **session or authentication cookie** — doing so risks caching
one user's personalised or private response and serving it to another visitor. The
module has no access-control role of its own; getting the cookie list right is the
part that matters.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Acquia Cookie Vary works at the caching layer rather than presenting a prominent
admin screen. Its behaviour applies to the responses your Acquia platform caches
once it is enabled and its vary cookies are set.

## How to use it

Enable the module on an Acquia-hosted site, then decide which cookies the cache
should vary by — restricting the list to cookies that only affect **public**
content (language, A/B bucketing, and the like). Keep session and auth cookies off
that list entirely. With the right cookies configured, cookie-dependent pages are
cached correctly per value instead of being served identically to everyone.
