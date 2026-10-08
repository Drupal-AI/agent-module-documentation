<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LLMs.txt Gen (llms_txt_gen) — agent index

**Auto-generates `llms_txt_section` entities listing published nodes grouped by content type, as markdown links to each node's `.md` URL.**

- **Version:** 1.0.x
- **Core:** ^10.3 || ^11
- **Dependencies:** llms_txt:llms_txt, markdownify:markdownify_path
- **Service:** `llms_txt_gen.generator` → `LlmsTxtGenerator::generate()` / `deleteAll()`
- **Triggers:** `hook_cron`, install hook (creates "LLMs.txt Raw" format + initial run), Drush `llms-txt-gen:generate` (`llms-gen`) / `llms-txt-gen:delete` (`llms-del`)
- **Route:** `llms_txt_gen.settings` → `/admin/config/search/llms-txt-gen` (perm `administer llms_txt_gen`)
- **Config:** `llms_txt_gen.settings` → `selected_bundles`, `bundles_default`
- **Security:** No security findings. Config route permission-gated. Although the node query uses `accessCheck(FALSE)` for performance, each node is re-checked with `->access('view', AnonymousUserSession)` before inclusion (llms.txt is public), and node titles are markdown-escaped to block link injection.

See [drush/commands.md](drush/commands.md) and [configure/settings.md](configure/settings.md)