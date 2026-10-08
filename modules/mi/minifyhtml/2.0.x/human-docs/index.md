# Minify Source HTML — manual setup guide

**Minify Source HTML** (`minifyhtml`) shrinks the size of every page Drupal
sends to the browser by stripping the redundant whitespace — and, optionally,
the HTML comments — out of the fully rendered markup. Your Twig templates stay
readable on disk; only the finished response that travels over the wire is
compacted. Smaller responses mean less bandwidth and, often, a slightly faster
perceived load.

It works differently from the older Minify module: instead of touching just the
content region, it minifies the *entire* page. It hooks in at the very last
moment before the response is sent — and, importantly, before Drupal's page
cache stores it — so the cached copy is already small and there is virtually no
extra work on a cache hit. Content that must not be altered (`<pre>`,
`<textarea>`, `<iframe>`, inline `<script>` and `<style>`, structured-data
`application/ld+json` blocks, and IE conditional comments) is carefully
protected and restored intact.

Minification is **off out of the box** — enabling the module changes nothing on
its own. You turn it on from Drupal's core **Performance** settings page, where
the module adds its options under *Bandwidth optimization*. It depends only on
core's System module and has no third-party libraries. If a minification pass
ever runs into trouble, the module logs a warning and quietly serves the
original, unminified page, so a bad edge case never breaks your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turn minification on, choose whether
   to strip comments, and exclude pages, on the core Performance form.

## Where it lives in the admin menu

The module has no admin page of its own. Its settings are folded into Drupal's
core Performance form at **Configuration → Development → Performance**
(`/admin/config/development/performance`), in the **Bandwidth optimization**
section. Seeing and changing those fields requires the *Administer minify HTML*
(`administer minifyhtml`) permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the Performance form and tick **Minify Source HTML's HTML** — nothing is
   minified until you do.
3. For the biggest win on anonymous traffic, keep Drupal's core **Internal Page
   Cache** enabled, so the minified page is cached once and reused.

By default the admin section of your site (`/admin*`) is excluded, so the admin
theme is never touched. See [Configuration](configuration/index.md) for the full
field-by-field walkthrough.
