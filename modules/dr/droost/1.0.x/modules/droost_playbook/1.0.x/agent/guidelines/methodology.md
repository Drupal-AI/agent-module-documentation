<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Playbook — the served methodology topics

## Enable
```bash
drush en droost_playbook -y   # depends only on droost; the droost_cms recipe enables it by default
```

## The topics
Droost Playbook ships only content — two on-demand Markdown topics under `guidelines/topics/`:

- **`methodology`** (`guidelines/topics/methodology.md`) — the Droost way of building a site: **SDC (Single
  Directory Components) as the universal display substrate**, the introspect -> compose -> verify tool flows to
  follow, and worked examples.
- **`theming`** (`guidelines/topics/theming.md`) — the theming methodology.

## How they reach an agent
The module has no serving code of its own. The base module's `GuidelineProvider` discovers every enabled module's
`guidelines/topics/*.md`, so both topics join the catalog. An agent retrieves one by calling the base
**`droost_guidelines`** MCP tool with the matching `topic` (`methodology` or `theming`). Both names are also written
into the `AGENTS.md` deep-dive-topics list by `drush droost:install`, so a cold agent is pointed at them
automatically. Serving is gated by mcp_server's `access mcp server` permission; `GuidelineProvider::getTopic()`
strips the requested name to `[a-z0-9_-]` before resolving it to a file.

## No code, one test
There is no `src/`, no routes, no permissions, no config, no services and no Drush. The only PHP is
`tests/src/Kernel/PlaybookTopicTest.php`, which asserts the topics are served. To add project methodology, drop
another `guidelines/topics/<name>.md` into any enabled module — the same seam.
