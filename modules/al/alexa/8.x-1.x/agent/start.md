<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alexa — agent orientation

**Machine name:** `alexa`  
**Version dir:** `8.x-1.x`  
**Core:** `^8 || ^9 || ^10`  
**Dependencies:** none  
**Configure route:** `n/a`

## What it does
Receives Amazon Alexa skill requests at a callback, validates signatures, and dispatches events.

## Where to look
- `alexa.info.yml` — metadata and dependencies.
- `alexa.routing.yml` / `.permissions.yml` / `.services.yml` — routes, permissions, services (where present).
- `src/` — controllers, forms, plugins and services.

See `../usage.md` for install, configuration and usage details.
