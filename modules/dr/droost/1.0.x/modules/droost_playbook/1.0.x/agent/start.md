<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Playbook (droost_playbook) — agent index

Declares the Droost site-building methodology to AI agents as **served guideline topics** (SDC as the universal
display substrate, the tool flows, worked examples). Pure content — no PHP src. Depends only on `droost`.
Version **1.0.0-rc1** (dir 1.0.x). Core `^10.3 || ^11 || ^12`. Local development only.

## What it provides
- **2 guideline topics**, discovered by the base module's `GuidelineProvider` and served via the base
  `droost_guidelines` MCP tool (gated by mcp_server `access mcp server`):
  - `guidelines/topics/methodology.md` — topic `methodology`.
  - `guidelines/topics/theming.md` — topic `theming`.
- Both are listed in the AGENTS.md block written by `drush droost:install`.
- **No PHP src, routes, permissions, config, services, or Drush.** One kernel test (`PlaybookTopicTest`) asserts the
  topics are served.

## Mechanism (source)
- The base `GuidelineProvider` scans each enabled module's `guidelines/topics/*.md`; these two join the catalog.
  `getTopic()` sanitizes the requested name to `[a-z0-9_-]` — no path traversal.

## Docs
- The two topics and how they are served → [guidelines/methodology.md](guidelines/methodology.md).
