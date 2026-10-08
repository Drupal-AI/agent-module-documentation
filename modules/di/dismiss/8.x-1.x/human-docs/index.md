# Dismiss — manual setup guide

**Dismiss** (`dismiss`) adds a small "close" (✕) button to Drupal's status,
warning, and error messages — the notices that appear in the messages area at the
top of a page. Click it and the message goes away, without needing a page reload.
It is a deliberately lean, jQuery‑powered UI enhancement in the "User interface"
category, and it applies to Drupal's standard messages output.

The problem it solves is message clutter. On busy admin and editorial screens,
status and warning messages can stack up and stay on screen until the next page
load, pushing the actual content down. Dismiss lets a user clear the ones they have
read, for a tidier interface. There is also an optional setting to **auto‑hide
status messages** after a moment (warnings and errors are deliberately left in
place, since those usually need attention).

Dismiss works the moment you enable it — no configuration is required for the close
button. It is purely presentational: it does not change which messages Drupal
generates and has no effect on access or behaviour. It has no dependencies beyond
Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the optional auto‑hide setting for
   status messages.

## Where it lives in the admin menu

Dismiss adds no menu items of its own; the close button simply appears on every
Drupal message once the module is enabled. The one optional setting (auto‑hide) is
on the module's small settings form — see [Configuration](configuration/index.md).
