<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Log Analysis — agent orientation

**Machine name:** `ai_log_analysis`  
**Version dir:** `1.0.x`  
**Core:** `^10`  
**Dependencies:** drupal:ai  
**Configure route:** `ai_log_analysis.settings`

## What it does
Captures Drupal logs and uses an AI provider to analyze entries and suggest fixes.

## Where to look
- `ai_log_analysis.info.yml` — metadata and dependencies.
- `ai_log_analysis.routing.yml` / `.permissions.yml` / `.services.yml` — routes, permissions, services (where present).
- `src/` — controllers, forms, plugins and services.

See `../usage.md` for install, configuration and usage details.
