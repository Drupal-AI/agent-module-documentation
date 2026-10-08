<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Help — served topic & help page

## Enable
```bash
drush en droost_help -y   # depends only on droost; the droost_cms recipe enables it by default
```

## The served topic (`using-droost-fully`)
`guidelines/topics/using-droost-fully.md` is an on-demand deep-dive that maps Droost's whole surface (~60 MCP
tools across 13 modules) and the plan -> code -> test -> document dev loop. It is **not** served by this module
directly: the base module's `GuidelineProvider` scans every enabled module's `guidelines/topics/*.md`, so this
topic joins the catalog, and an agent retrieves it by calling the base **`droost_guidelines`** MCP tool with
`topic: using-droost-fully`. The topic also appears in the `AGENTS.md` block that `drush droost:install` writes,
so a cold agent is pointed at it automatically. Serving is gated by mcp_server's `access mcp server` permission,
and `GuidelineProvider::getTopic()` strips the requested name to `[a-z0-9_-]` before resolving it to a file — so a
caller cannot read files outside the topic dirs.

## The in-app help page
`DroostHelpHooks::help()` (an OOP `#[Hook]`, wired as an autowired service; `droost_help.module` bridges the legacy
`hook_help`) returns a render array for `help.page.droost_help` (`/admin/help/droost_help`). It explains the surface
and lists the "turn the whole surface on" steps:
- Enable the opt-in submodules: `droost_profiler` (then enable profiling on its settings page), `droost_devel`
  (needs `drupal/devel`), `droost_ai` (needs `drupal/ai`; unlocks semantic search + AI codegen).
- Build the brain: `drush droost:brain:build` (the `droost_capabilities` / `droost_architecture` tools stay empty
  until you do).
- Index the code: `drush droost:search:index`.
- Wire your editor: `drush droost:install`.

It also points at the comprehensive human guide shipped with the droost_cms recipe (`docs/fully-utilizing-droost.md`)
and the general `/admin/help/droost` page.

## Publishing your own topics
Any enabled module can add `guidelines/topics/<name>.md`; `GuidelineProvider` picks it up and `droost_guidelines`
serves it. This is the seam droost_playbook and site-specific modules use.
