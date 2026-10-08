# Acquia CMS Toolbar Gin — manual setup guide

**Acquia CMS Toolbar Gin** (`acquia_cms_toolbar_gin`) is the small bridge that lets
you run the modern **Gin** admin theme *together with* the Acquia CMS Toolbar.
Gin restyles Drupal's whole administration experience; on its own it can clash with
the Acquia CMS toolbar styling. This module reconciles the two so the toolbar
renders correctly under Gin and the admin looks consistent.

It is **distribution configuration and glue** — it adds no settings and no new
features of its own. It simply depends on **Acquia CMS Toolbar**
(`acquia_cms_toolbar`) and coordinates it with the Gin theme. Enable it on an
Acquia CMS site where you have chosen Gin as the administration theme; there is
nothing to configure.

Treat the Acquia CMS modules as a set adopted together, not as standalone features
to cherry-pick.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   set Gin as the admin theme.

## Where it lives in the admin menu

There is no settings page. Its effect appears in the **admin toolbar** once Gin is
your active administration theme — the toolbar sits and styles correctly under Gin.

## How to use it

Set **Gin** as your site's administration theme (Appearance →
`/admin/appearance`), make sure **Acquia CMS Toolbar** is enabled, then enable this
module. From that point the toolbar and Gin work together with no further steps.
