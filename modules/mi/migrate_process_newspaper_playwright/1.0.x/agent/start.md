<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Process Newspaper Playwright (migrate_process_newspaper_playwright) — agent index

**Migrate process plugin that scrapes articles via the Python Newspaper3/4k + Playwright wrapper.**

- **Version:** 1.0.x (1.0.0)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends:** migrate; Composer `2dareis2do/newspaper-playwright-wrapper`; a server with Python3 + Playwright.
- **Plugin id:** `migrate_process_newspaper_playwright`. Config: `debug`, `command`, `cwd`.
- **Service:** `...MigrateProcessNewspaperPlaywright` (logger channel arg).
- **Security:** developer tool, no routes/UI; **spawns a local Python process** using `command`/`cwd` from migration config (developer-controlled, not request input); only absolute http(s) URLs are scraped.

See [api/plugin.md](api/plugin.md).
