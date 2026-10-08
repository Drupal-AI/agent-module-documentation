<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Site Manager (ai_site_manager) — agent index

**Interprets a plain-English admin request into one previewed command (module enable/uninstall, cache clear, maintenance mode) that only an admin can confirm and execute; full audit log.**

- **Version:** 1.0.x  •  **Core:** ^10.3 || ^11  •  **Package:** AI  •  **Depends on:** `ai`, `system`
- **Routes:** `/admin/config/ai/site-manager` (dashboard, `access ai site manager`), `/history` and `/settings` (`administer ai site manager`).
- **Plugins:** `AICommand` — `ModuleCommand`, `CacheCommand`, `MaintenanceModeCommand`.
- **Interpretation:** configured AI provider (via AI Core, no stored key) or keyword fallback; preview + risk level shown before running.
- **Security:** Two-step human-in-the-loop. Preview needs `access ai site manager`; **confirm/execute re-checks the restricted `administer ai site manager` permission** in both `ChatForm` `#access` and `confirmSubmit()` (which re-validates before executing). Flood-limits prompts to cap AI cost. Reviewed SOUND — no security findings.

See [configure/usage.md](configure/usage.md).
