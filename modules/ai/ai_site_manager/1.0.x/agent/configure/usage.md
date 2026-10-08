<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Site Manager — configure & safety model

**Prerequisite:** the AI (Artificial Intelligence) module with a configured provider (optional — without one, interpretation falls back to keyword matching). No API key is stored here; provider calls go through AI Core.

**Routes / permissions:**
- `/admin/config/ai/site-manager` — chat dashboard; needs `access ai site manager` (preview only).
- `/admin/config/ai/site-manager/history` — audit log; needs `administer ai site manager`.
- `/admin/config/ai/site-manager/settings` — provider/model + flood limit; needs `administer ai site manager`.

**Two-step safety model (`ChatForm`):**
1. **Analyze** — user describes a task; it is interpreted into one command/action/parameters and previewed with a risk level. Counts toward the per-user flood limit (bounds AI cost).
2. **Confirm** — the confirm button's `#access` requires `administer ai site manager`; `confirmSubmit()` re-checks the same permission and re-validates the action before calling `commandManager->execute()`. Preview-only users cannot execute.

**v1 command plugins (`AICommand`):** `ModuleCommand` (enable/uninstall), `CacheCommand` (clear caches), `MaintenanceModeCommand` (toggle). Every interpretation and execution is written to the audit history.
