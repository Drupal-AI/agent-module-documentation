# Disable Back Button — manual setup guide

**Disable Back Button** (`disable_browser_back_button`) stops the browser's Back
button from working on the pages you choose, by injecting a small piece of
JavaScript that traps the Back action and re-lands the visitor on the current page.
The usual reasons to want this are to stop someone from using history or the browser
cache to return to an authenticated page after logging out, or to lock a user onto a
particular flow — a quiz, an exam, a step-by-step form — where going back would
break things.

You control where it applies from the module's settings page: run it everywhere, or
only on an admin-defined list of paths. On matching pages the module attaches its
JavaScript library, which manipulates the browser's history (via `pushState` and
`popstate` handlers) so that pressing Back simply keeps the user where they are.

Be clear-eyed about what this does and does not do. **The protection is entirely
client-side.** It is a UX nicety, not a security control: a visitor with JavaScript
disabled, or who opens dev tools, bypasses it completely. Do not use it to protect
sensitive data. If your real goal is to keep people out of authenticated pages after
logout, that has to come from proper cache headers (for example
`Cache-Control: no-store`) and session handling — use this module alongside those,
for polish, not in place of them.

It needs nothing but Drupal core and runs on Drupal 9 and 10. Because it only adds a
small library, its performance cost is negligible, and disabling the module restores
normal Back behaviour immediately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — choose the pages where the Back button
   is disabled.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Disable Back configuration**
(`/admin/config/browser/noback/settings`) and requires the **Administer site
configuration** permission.
