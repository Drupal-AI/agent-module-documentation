# HTML5 History — manual setup guide

**HTML5 History** (`html5history`) is an extremely lightweight developer module that
exposes the browser's **HTML5 History API** — `pushState` and `replaceState` — to
Drupal's front‑end JavaScript. The History API lets JavaScript change the URL in the
address bar and manage the browser's back/forward history *without* triggering a full
page reload, which is the foundation of single‑page‑app‑style navigation.

The module does two things. First, it exposes the History interface to Drupal's
**AJAX command system**, so AJAX responses can update the URL. Second, it provides a
way to **hook into `pushState` and `replaceState` events**, giving front‑end code a
lightweight way to react when the history state changes (a common gap when working
with the raw History API).

This is purely a developer/front‑end integration. It has no admin pages, no
settings, no permissions, and no content or access‑control role — you use it from
your own JavaScript or AJAX code.

> **Maintenance note:** this project is marked *seeking a new maintainer* and is in
> maintenance‑fixes‑only mode, and it is not covered by Drupal's security advisory
> policy. It's small and self‑contained, but factor that status into your decision
> for a long‑lived production site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it's a JavaScript integration
you drive from your own front‑end code.

## Where it lives in the admin menu

HTML5 History adds no admin page and has no settings. Once enabled, its JavaScript
integration is available to your front‑end and AJAX code — see the module's own
documentation for the exact hooks and how to attach them.
