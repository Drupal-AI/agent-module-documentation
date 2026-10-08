<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ShURLy (shurly) — agent index

Short URL service on the site's own domain — per-user ownership, custom aliases, click analytics.
Submodules `shurly_analytics`, `shurly_service`. Depends on core `views`.
Version **8.x-1.0-beta4** — **beta**, most recent release 2024.
Core requirement `^9.3 || ^10 || ^11`.

Permissions: `create short URLs`, `enter custom URLs`, `view own URL stats`, `edit own URLs`,
`edit all URLs`, `administer short URLs`.

**State the premise, because it is easy to miss: a URL shortener is an open redirect with a
permission on it.**
- **`create short URLs` lets its holder point the organisation's own domain at anything** — exactly
  what a phishing campaign wants: a link that passes "is this a domain I trust" and lands elsewhere.
- Links are **permanent and public** once created; there is **no expiry** in the model.
- **Destinations can be edited after sharing**, so a link reviewed at creation is not necessarily
  pointing where it was reviewed to point.

Treat it as a **reputation-bearing permission**, held by people who would be allowed to publish.

**Two defects (verified live):**
1. **`/shurly/edit/{rid}` returns an anonymous 500** for a non-numeric id — `ShurlyEditForm::access()`
   has no `else`, so it returns **NULL** instead of an `AccessResultInterface`, and the route has no
   `rid` pattern. Every distinct bad value is another 500.
2. The same callback reads `$row->uid` **without checking `fetchObject()` matched** — a PHP 8
   warning; fails closed.

**Why organisations want this over a vendor:** recognisable in print and read aloud, no dependency
on a shortening service still existing, and the click data stays in-house.
