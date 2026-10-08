<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Speculative Loading (speculative_loading) — agent index

**Emits one inline `<script type="speculationrules">` on every page so browsers prefetch/prerender same-site links the visitor is likely to click.**

- **Version:** 1.0.x (1.0.0-beta2) — core `^10.3 || ^11`, package Performance, depends on `system`.
- **How it works:** `hook_page_attachments` (`speculative_loading.module`) calls `plugin.manager.speculation_rules::getSpeculationRules()`, JSON-encodes the result, and attaches it as an inline speculation-rules script in `html_head`. No JS library, no per-visitor logic.
- **Config:** object `speculative_loading.settings` — `mode` (`prefetch`|`prerender`, default `prerender`), `eagerness` (`conservative`|`moderate`|`eager`, default `moderate`). Nothing else is configurable via UI.
- **No permissions of its own, no Drush commands.** Settings form gated by core `administer site configuration`.

## Docs
- [configure/settings.md](configure/settings.md) — settings form, route, config keys, the fixed exclude list and how the rule JSON is built.
- [extend/hooks.md](extend/hooks.md) — `hook_speculation_rules_href_exclude_paths_alter`, the `no-prerender`/`nofollow` opt-outs, and the (inert) `SpeculationRules` plugin type.
