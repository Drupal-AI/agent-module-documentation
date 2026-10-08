# Advance Script Manager — manual setup guide

**Advance Script Manager** (`advance_script_manager`) lets administrators add
custom script snippets — typically third-party tracking, analytics, or marketing
tags — and have them injected into the site's pages, without editing theme
templates. Each snippet has an enable/disable toggle and per-script visibility
rules, and new snippets are **disabled by default** so nothing goes live by
accident. Under the hood it adds the snippets to the page head via Drupal's page
attachments.

**Please read this before you install: this is a deliberately powerful and
dangerous capability.** A snippet is arbitrary code that runs in every visitor's
browser on every matching page. Anyone who can manage scripts here can therefore
run any JavaScript they like for all your visitors — which is effectively the
same as full control of the site (stealing session cookies, defacing pages,
exfiltrating data). The module handles this correctly: the ability is gated by
the `advance_script_manager_settings` permission, which is marked *restricted*
(Drupal's permissions page shows a security warning next to it), and scripts
start disabled. But the responsibility is yours — grant that permission **only to
fully trusted administrators**, never to content editors. Treat it the same way
you would treat a PHP-eval or raw-JavaScript capability.

If you add tracking or marketing tags, remember they also raise privacy and
consent obligations — pair them with a cookie-consent solution.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add and manage script snippets, set
   visibility, and the permission that guards it all.

## Where it lives in the admin menu

Once enabled, the script manager is reachable from its configuration route
(`advance_script_manager.advance_script_controller_build`). The
`advance_script_manager_settings` permission controls who can see and use it — set
it on the **People → Permissions** page.
