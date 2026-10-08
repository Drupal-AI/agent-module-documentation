# Critical CSS UI — manual setup guide

**Critical CSS UI** (`critical_css_ui`) lets you manage "critical CSS" — the small
slice of styles needed to render the top of a page — directly from Drupal's admin
interface, storing each fragment as an entity in the database and inlining it into
the page so the first paint happens fast. Instead of relying on static critical-CSS
files baked into your theme's build process, you attach CSS fragments to specific
page contexts (a particular node, a content type, and so on) and the module inlines
only the CSS that context needs.

The problem it addresses is familiar: modern themes ship large CSS bundles that load
on every page even when most of the styles go unused, which slows the initial render
and hurts Core Web Vitals. That gets harder with Layout Builder or Paragraphs, where
each page can have a unique structure that a single static critical-CSS file cannot
adapt to. Critical CSS UI is context-aware and dynamic: each fragment is injected
only when its matching context is rendered, matching by priority from the most
specific (an exact page) down to a content-type fallback, while non-critical CSS is
loaded asynchronously. It is theme-independent, so you do not need to touch theme
files or build tooling, and the tab-based UI is friendly enough for non-developers to
manage.

One important caution: critical CSS is **CSS that gets inlined into your pages**, so
whoever can edit it can inject styles into what visitors see. Injected CSS can be
used for defacement or UI-redress tricks, so restrict the module's permission to
trusted users and treat these fields as trusted markup. The module supplies its own
permissions, has no dependencies, and supports Drupal 10 and 11. (This is an early
`1.0.0-alpha3` release.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create and manage critical CSS entities
   and attach them to page contexts.

## Where it lives in the admin menu

The module's settings and listing live under **Configuration → Development →
Performance → Critical CSS**
(`/admin/config/development/performance/critical-css`). It also adds a **Critical
CSS** tab on node edit pages and bundle-level options under **Structure → Content
types**.
