# ShURLy — manual setup guide

**ShURLy** (`shurly`) runs a URL-shortening service on your own Drupal site. Instead
of leaning on a third-party shortener, you create short links on your own domain — a
link reading `example.org/summer` rather than a vendor's `xyz.co/ab12` — with per-user
ownership, custom or auto-generated aliases, and click tracking on every link.

Organisations want short links on their own domain for reasons that are mostly about
trust and measurement. A link on your own domain is recognisable in print, on a
poster, or read aloud; it does not depend on some shortening service still existing in
five years; and the click data stays with you rather than with a vendor. New links are
created at `/shurly`, where you enter the long URL and an optional custom short URL,
and logged-in users can see their own links and click counts at `/myurls`.
Auto-generated slugs use a character set that deliberately omits the ambiguous
`0`, `1`, `l`, `I`, and `O`, and custom slugs may use any non-reserved characters,
including UTF-8 glyphs. Two optional submodules extend it: **`shurly_analytics`** for
click statistics and **`shurly_service`** for a web-services API to shorten and expand
URLs programmatically.

It is worth stating the premise plainly, because it is easy to miss: **a URL
shortener is an open redirect with a permission on it.** Anyone who holds the
*create short URLs* permission can point your own domain at anything they like — which
is exactly what a phishing campaign wants, a link that passes a "is this a domain I
trust?" check and then lands somewhere else entirely. Links are permanent and public
once created, there is no expiry in the model, and a link's destination can usually be
edited *after* it has been shared — so a link that looked fine when it was reviewed is
not guaranteed to still point where it was reviewed to point. Treat *create short
URLs* as a reputation-bearing permission, given only to people you would trust to
publish on the site.

A couple of practical caveats. This 8.x branch is a **beta** (`8.x-1.0-beta4`) with
its most recent release dating from 2024 — the maintainers themselves flag the D8+
version as still in development, so weigh that before using it in production. There is
also a known rough edge: the edit route (`/shurly/edit/{rid}`) returns a server error
to anonymous requests when the id is not a number, because the access check does not
handle that case cleanly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it, plus the optional submodules.
2. [Configuration](configuration/index.md) — permissions, rate limiting, and how
   links are created and managed.

## Where it lives in the admin menu

ShURLy's settings form is the **`shurly.admin`** route, where you configure things
like per-role rate limiting. All listings — including the administrative overview of
everyone's URLs and the per-user `/myurls` page — are built with Views, since Views is
a hard dependency.
