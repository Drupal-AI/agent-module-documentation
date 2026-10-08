<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Help (droost_help) — agent index

Teaches humans and AI agents how to fully utilize Droost's ~60-tool surface: one served guideline topic
plus an in-app help page. Depends only on `droost`. Version **1.0.0-rc1** (dir 1.0.x).
Core `^10.3 || ^11 || ^12`. Local development only.

## What it provides
- **1 guideline topic**: `guidelines/topics/using-droost-fully.md` — discovered by the base module's
  `GuidelineProvider` and served to agents via the base `droost_guidelines` MCP tool (topic
  `using-droost-fully`). Also listed in the `drush droost:install` AGENTS.md block.
- **hook_help**: `DroostHelpHooks::help()` (OOP `#[Hook]`, autowired service) renders `/admin/help/droost_help`.
- **No routes, permissions, config, Drush, or entities of its own.**

## Mechanism (source)
- `droost_help.module` delegates `droost_help_help()` to `DroostHelpHooks` (a `#[LegacyHook]` bridge).
- The topic is plain Markdown; serving/gating is entirely the base module's (`droost_guidelines` tool, gated by
  mcp_server `access mcp server`; `GuidelineProvider::getTopic()` sanitizes the topic name — no path traversal).

## Docs
- The served topic, the help page, and the setup checklist → [guidelines/help.md](guidelines/help.md).
