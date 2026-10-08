# Status Messages — manual setup guide

**Status Messages** (`status_messages`) turns Drupal's ordinary status, warning,
and error messages — the "Your changes have been saved" strip you see after
submitting a form — into a floating popup ("toast") in the top‑right corner of the
page. Each message gets a close (×) button and fades out on its own after a number
of seconds you choose.

It works the moment you enable it: the module attaches a small CSS/JS library to
every page and re‑renders the core messages as the floating popup, so you get a
modern notification feel without any theming work. The only thing you configure is
how long a message stays before fading.

That single setting offers a handful of durations — 5, 10, 15, or 20 seconds — plus
a "Never" option that keeps messages on screen until the visitor dismisses them,
which is handy for important errors. The module has no dependencies on other
modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the one setting (auto‑fade time) and
   the permission that controls the settings form.

## Where it lives in the admin menu

Once enabled, the toast styling is active site‑wide immediately. Its settings form
sits at **Configuration → User interface → Status Messages**
(`/admin/config/user-interface/status-messages`).

## How to use it

There is nothing to place or embed — the module intercepts Drupal's existing
message output automatically. Enable it, then open the settings form to pick how
long messages stay before fading. To preview, do something that produces a message
(for example, save a node) and watch the toast appear in the top‑right corner.
