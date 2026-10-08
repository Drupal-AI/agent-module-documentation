# Remove Meta Info — manual setup guide

**Remove Meta Info** (`remove_meta_info`) is a lightweight hardening utility that
removes the **Drupal-generated meta information** from your site's output — most
notably the `generator` meta tag in the HTML `<head>` that announces "this site
runs Drupal." Trimming that kind of informational metadata reduces
**fingerprinting**: it makes it a little less obvious to automated scanners and
casual attackers exactly what software (and sometimes what version) your site is
running.

The module is deliberately small — essentially a single PHP file with no external
dependencies — and it works across Drupal 8, 9, 10, and 11. Once enabled it does
its job automatically; there is no form to fill in.

Two things to keep in perspective:

- **This is defense-in-depth, not a fix.** Hiding the generator tag makes
  fingerprinting slightly harder, but it is **no substitute for keeping Drupal and
  your modules patched**. A hidden version number does not protect an unpatched
  vulnerability.
- **Only informational metadata should be removed.** The value of removing a
  generator tag is that it serves no functional purpose. Be careful, as a general
  principle, not to strip meta tags or headers that *do* matter — SEO/canonical
  tags, or security headers like Content-Security-Policy and X-Frame-Options.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** — the module removes the Drupal-generated meta
information automatically once enabled.

## How to use it

There is nothing to configure. Enable the module and the Drupal-generated meta
information is stripped from the output. To confirm, view the page source of any
front-end page and check that the `<meta name="generator" ...>` tag (which Drupal
normally emits) is gone.
