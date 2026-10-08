# Script Manager — manual setup guide

**Script Manager** (`script_manager`) lets a trusted administrator register HTML
and JavaScript snippets — analytics tags, a tag-manager container, a marketing
pixel, a chat widget, a cookie-consent bootstrap — and have Drupal inject them
into the top or bottom of your pages, without editing theme templates. Each
snippet is stored as configuration, so you can export it and deploy it across
environments like any other config.

Every snippet you create is a small **script** entity with a label, a machine
name, the snippet text, a **position** (top of the page, bottom of the page, or
"not shown"), and an optional set of **visibility** rules that use exactly the
same conditions as core block placement — request path, user role, language, and
so on. On every non-admin page, Script Manager evaluates each snippet's
visibility rules and, where they pass, emits the snippet. Tracking scripts are
automatically skipped in the admin UI, so your analytics never counts your own
back-end clicks.

> **Important — this is a powerful, trusted feature.** Snippets are output
> **verbatim and unescaped** on purpose: that is the only way a real
> `<script>` tag can run. As a result, anyone who holds the **Administer
> scripts** permission can inject arbitrary client-side code across your whole
> site. Treat that permission as equivalent to full site-wide script injection
> and grant it only to fully trusted roles. This is by design, not a bug.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create and manage snippets, choose
   their position, and scope them with visibility rules.

## Where it lives in the admin menu

Snippets are managed at **Structure → JavaScript Snippets**
(`/admin/structure/scripts`), behind the **Administer scripts** permission. There
is no separate top-level settings page — the collection listing is the whole UI.
