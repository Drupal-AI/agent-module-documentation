# Development Assistant — manual setup guide

**Development Assistant** (`development_assistant`) provides developer conveniences
that help while building and testing a site in the browser. It's a companion to the
**Browser Development** module: it reuses the configuration that Browser Development
creates, and — importantly — it can be **uninstalled on production**, which lets you
keep those development helpers out of a live environment to avoid the security and
performance costs of leaving them enabled.

It's a small, focused development tool with no third-party dependencies and, per the
maintainers, **no configuration** — you install it, enable it, and use it in
development. It ships its own permission, supports Drupal 9, 10 and 11, and is
**not** covered by Drupal's security advisory policy, so review it before relying on
it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the maintainers confirm there is nothing to
configure. Install it, use it during development, and uninstall it on production.

## How to use it

1. Install and enable it in your development environment (alongside the Browser
   Development module, whose configuration it uses).
2. Under **People → Permissions**, grant its permission to your developer roles.
3. Use the browser-development conveniences while building and testing. When you
   deploy to production, uninstall this module to keep the helpers off your live
   site.
