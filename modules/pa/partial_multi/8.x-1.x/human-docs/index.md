# Partially Multilingual — manual setup guide

**Partially Multilingual** (`partial_multi`) is for sites that are multilingual but
where **only some pages are actually translated**. On such a site a visitor
browsing in, say, Spanish can click through to a page that only exists in English
and end up at a URL like `/es/node/77` — the same English content that also lives
at its proper English alias, `/about`. Now the same content is reachable at two
URLs that differ only by a language prefix, which is bad for SEO (duplicate
content) and confusing for visitors.

This module quietly fixes that. It watches incoming requests, and when a URL asks
to view a **regular content (node) page in a language it has not been translated
into**, it issues a **permanent (301) redirect** to the URL for that content in its
source language. In the example above, `/es/node/77` redirects to `/about`, so the
content has a single canonical URL. Requests for pages that *are* translated into
the requested language, or that are not node pages at all, are left untouched.

There is **nothing to configure** — installing and enabling the module is the
entire setup. If you would like an alternative to compare it against, the
maintainer points to the more popular **Content Translation Redirect** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings and begins
redirecting untranslated node pages the moment it is enabled.

## How to use it

Enable the module on a site that already has multiple languages and content
translation configured. From then on, the redirect behavior is automatic: any
attempt to view an untranslated node in a non‑source language is permanently
redirected to the content's source‑language URL. You do not need to touch any
content type, field, or menu.

> **Note on release status:** at the time of writing there is no stable release
> covered by the security advisory policy. Weigh that against your needs — and
> consider Content Translation Redirect as an alternative — before using it on a
> production site.
