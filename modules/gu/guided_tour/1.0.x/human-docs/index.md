# Guided Tour — manual setup guide

**Guided Tour** (`guided_tour`) adds step‑by‑step interactive tours to your
Drupal site, built on the **Driver.js** library. A tour highlights UI elements
one at a time with tooltips — ideal for onboarding new visitors or explaining a
feature — and, unlike Drupal core's Tour module, it works for **anonymous** as
well as authenticated users and needs **no custom plugin code**: administrators
build tours through a UI, defining the steps in YAML.

It is a front‑end onboarding/UX feature with no content model or access role of
its own. Tours can be targeted precisely: show different tours to different
**roles**, aim a tour at a specific **route** (or all pages), and filter by
content **bundle**. It supports Shadow DOM / Web Components, offers a configurable
dismissal cookie so a tour doesn't nag returning visitors, and can place a
**replay button** (as a floating action button or inline) so people can run a tour
again.

A companion **Chrome extension** is available to speed up authoring: it lets you
click any element on a page to copy its CSS selector, ready to paste into the YAML
step editor.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which fetches the
   Driver.js library) and enable the module.
2. [Configuration](configuration/index.md) — create a tour, define its steps in
   YAML, and set role/route/bundle targeting.

## Where it lives in the admin menu

Tours are managed at **Administration → Configuration → User interface → Guided
Tour**, where you click **Add tour** to create one.
