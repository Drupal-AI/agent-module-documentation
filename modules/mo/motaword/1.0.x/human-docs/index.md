# MotaWord — manual setup guide

**MotaWord** (`motaword`) translates your Drupal site into **100+ languages**
using **MotaWord Active Serve**, a CDN-based translation delivery service. You
write your content in one language; visitors read it in theirs. The translations
live and are served on MotaWord's global CDN rather than being stored in Drupal,
so adding languages doesn't bloat your database — and when you edit a node, term,
menu, theme string, or block, MotaWord re-translates it behind the scenes so the
translations stay fresh.

The module is essentially a **connector**: the real work — choosing which
languages to support, tuning the AI translation, editing translations in a
side-by-side editor, ordering professional human translation, and managing
glossaries and style guides — happens in your **MotaWord dashboard**. On the
Drupal side you install the module, paste an **Active token** for your MotaWord
project, and the module configures itself from the project's metadata. A language
switcher is injected into pages so visitors can change language, and you can tag
your own links (for example `localize-page-as-fr`, `localize-as-es-MX`, or
`nolocalize`) to control localisation. It's multisite-aware, with per-site
configuration, and supports **Drupal 9, 10, and 11** (PHP 8.0+).

> **Security-advisory note:** this module is **not covered** by Drupal's security
> advisory policy. Evaluate accordingly before production use.

The **Active token** is a credential tied to your MotaWord project — store it
securely (environment-backed) and keep it out of version control. Be aware, too,
that your content is processed by MotaWord (a third party), which is a privacy
consideration.

> If instead you want to send *specific pages* to MotaWord for one-off human
> translation jobs, use the separate `tmgmt_motaword` module — the two can work
> side by side.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — paste your Active token and let the
   module configure itself.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → MotaWord**
(`/admin/config/motaword`). See [Configuration](configuration/index.md).
