<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webvisor x-frame (xframe_allow_webvisor) — agent index

A single-purpose module that lets **Yandex Metrica WebVisor** (session-replay analytics) load the
site inside an iframe. It registers one kernel-response event subscriber that sets a
`Content-Security-Policy: frame-ancestors …` header allowing the Yandex WebVisor / Metrica origins.

- Package **Security**. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 8.x-1.8.
- **No** configuration form, config objects, config schema, permissions, routes, services beyond the
  subscriber, hooks, Drush commands or submodules. Enabling the module is the whole setup.
- No dependencies (no `dependencies` in `xframe_allow_webvisor.info.yml`, no `composer.json`).

## What it provides

- **`xframe_allow_webvisor.subscriber`** (`xframe_allow_webvisor.services.yml`) → class
  `Drupal\xframe_allow_webvisor\EventSubscriber\XframeSubscriber`, tagged `event_subscriber`.
  It subscribes to `KernelEvents::RESPONSE` and, in `onKernelResponse()`, sets the
  `content-security-policy` header to a fixed `frame-ancestors` value. See below.

## Solution docs

- **The subscriber, the exact header value, and how framing is enabled** →
  [api/subscriber.md](api/subscriber.md)
