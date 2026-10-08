# Disable Language — manual setup guide

**Disable Language** (`disable_language`) lets you **switch off one or more of your site's
languages for public visitors** while keeping that language, its content, and all its
translations completely intact in the backend. It's the tool you reach for when a translation
isn't ready for the public yet: translators keep working on it behind the scenes, but
anonymous visitors never see it.

When you mark a language as disabled, the module does several things at once: it removes the
language from the language switcher block, strips its `hreflang` alternate links from the page
`<head>` (so search engines don't index half‑finished pages), drops its URLs from Simple XML
Sitemap output, and **redirects** any visitor who lands on a disabled‑language URL to a
fallback — by default the front page, or a per‑language "redirect to" language you choose. A
configurable allow‑list keeps important routes working: the password‑reset and user‑edit flows
are pre‑configured so reset links never break.

Two permissions decide who can still see disabled languages: *View disabled languages* lets
trusted users (translators, admins) preview and use them, and *Create content in disabled
language* keeps the language available in content‑form language selectors. The module depends
only on core's **Language** module. Two important cautions: it **cannot clear its own caches**,
so you must run a cache rebuild after changing its settings; and you should **never disable
every language** (or your only/default language) or the redirect logic can lock you out. The
installed release is a **release candidate** (`8.x-1.0-rc2`) — there is no stable 1.0 tag yet,
though the branch is Drupal 9/10/11 compatible.

This guide is written for a **human** managing languages in the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — disable a language, set its redirect fallback,
   configure the settings form and permissions, and remember the cache‑clear step.

## Where it lives in the admin menu

- **Configuration → Regional and language → Languages**
  (`/admin/config/regional/language`) — the language list gains a **Disabled** column, and
  each language's **Edit** form gains a *Disable language* checkbox.
- **Configuration → Regional and language → Languages → Disable language**
  (`/admin/config/regional/language/disable_language`) — this module's settings form (its
  `configure` link), for the redirect override routes and excluded paths.
- **People → Permissions** — grant *View disabled languages* and *Create content in disabled
  language*.
