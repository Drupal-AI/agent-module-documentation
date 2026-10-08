# DDECK PWA — manual setup guide

**DDECK PWA** (`ddeck_pwa`) layers iOS and mobile-UX polish on top of the contrib
[PWA](https://www.drupal.org/project/pwa) module, turning a Drupal Progressive
Web App into something that feels much closer to a native, installable app —
especially on Apple devices.

The base PWA module handles the manifest and service worker, but it leaves several
gaps that iOS in particular cares about. DDECK PWA fills them: it injects
Apple-specific meta tags (`apple-mobile-web-app-capable`, the status-bar style,
and the home-screen app title), serves **Apple splash screens** for a wide range
of iPhone and iPad resolutions, provides **theme-controlled manifest icons**
(72px through 512px), and can render a **bottom navigation bar** as a Single
Directory Component (SDC) for an app-shell feel. Splash and icon assets are pulled
from your active theme's `pwa/` directory and are only injected when the matching
image file actually exists, so there's a graceful fallback when you haven't
supplied every size.

The module needs configuration to be useful. It has a small settings form (the
Apple app title and a toggle for the navigation bar), and — importantly — you
supply the splash-screen and icon PNGs yourself by placing them in your theme's
`pwa/` folder. It depends on core's **SDC** and on the contrib **PWA** module,
which must be installed and configured for the manifest and service worker.
Supports Drupal 10 and 11. This is a minimally maintained project not covered by
Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the base PWA module.
2. [Configuration](configuration/index.md) — the settings form (Apple app title,
   navigation toggle) and how to supply theme icons and splash screens.

## Where it lives in the admin menu

DDECK PWA's own settings form sits at **Configuration → Web services → DDECK PWA**
(`/admin/config/services/ddeck-pwa`), gated by the **Administer DDECK PWA**
(`administer ddeck pwa`) permission. The manifest and service-worker settings
themselves stay in the base **PWA** module, and the DDECK PWA form links across to
them.
