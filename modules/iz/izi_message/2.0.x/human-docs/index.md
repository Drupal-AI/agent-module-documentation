# Izi Message — manual setup guide

**Izi Message** (`izi_message`) restyles Drupal's status messages as light,
responsive notification panels. Instead of the block of plain text that core
renders in the status‑messages region at the top of the page, your "Changes have
been saved" confirmations, warnings, and errors appear as elegant toast‑style
notifications powered by the iziToast JavaScript library.

It solves a small but real annoyance: on a long form, core drops its confirmation
message at the very top of the page while your eyes are still at the bottom, so
you never see it. Izi Message shows the notification where you're actually
looking, in an application‑style panel that doesn't push the rest of the layout
around. The module is deliberately small — a stylesheet, a settings form, and a
few helpers — and depends only on Drupal core.

One thing worth getting right is accessibility. A message that appears and then
fades away must stay on screen long enough to read, and **error and validation
messages ideally should not auto‑dismiss at all** — those are exactly the ones a
person needs to re‑read while fixing a form. A common, sensible approach is to
apply the treatment to your admin theme only, so editors get the nicer
confirmations while front‑end validation keeps core's persistent behaviour.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form for message
   position, timing, and appearance.

## Where it lives in the admin menu

Once enabled, Izi Message takes over the rendering of status messages
site‑wide. Its settings form sits at **Configuration → Development → Izi message
settings** (`/admin/config/development/izi_message/settings`), reachable by any
user with the **Administer site configuration** permission.
