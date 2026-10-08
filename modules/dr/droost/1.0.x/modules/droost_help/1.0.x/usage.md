<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Droost Help teaches humans and AI agents how to fully utilize Droost — a served guideline topic covering the whole tool surface and the dev loop, plus an in-app help page.

---

Droost is a large surface — about 60 MCP tools across 13 modules — and most projects use only the obvious few. Droost Help ships the guidance that maps the whole surface and the workflow that ties it together. For agents, it provides one on-demand guideline topic, `using-droost-fully` (`guidelines/topics/using-droost-fully.md`); the base module's `GuidelineProvider` discovers every enabled module's `guidelines/topics/*.md`, so this topic joins the catalog and is served over MCP when an agent calls the base module's `droost_guidelines` tool with `topic: using-droost-fully`. The topic name also appears in the AGENTS.md block that `drush droost:install` writes, so a cold agent is oriented to the complete surface automatically. For humans, it implements `hook_help` through an OOP `#[Hook]` class (`DroostHelpHooks`, registered as an autowired service) that renders an in-app help page at `/admin/help/droost_help` — it explains the surface, tells you to enable the opt-in submodules (`droost_profiler`, `droost_devel`, `droost_ai`), to build the brain (`drush droost:brain:build`), to index the code (`drush droost:search:index`), and to wire your editor (`drush droost:install`). The module has no routes, permissions, config, or Drush of its own; it depends only on `droost`. The topic content is served through the gated `droost_guidelines` tool (mcp_server `access mcp server` permission) and `GuidelineProvider::getTopic()` sanitizes the requested topic name, so there is no arbitrary-file exposure. Enable it wherever agents drive Droost; the droost_cms recipe enables it by default. Local development only.

---

- Orient a cold AI agent to the entire Droost tool surface, not just the obvious tools.
- Serve the `using-droost-fully` deep-dive over MCP via the base `droost_guidelines` tool.
- Have the topic auto-listed in the AGENTS.md block written by `drush droost:install`.
- Give a human developer an in-app help page at `/admin/help/droost_help` mapping the surface.
- Remind operators to enable the opt-in submodules (`droost_profiler`, `droost_devel`, `droost_ai`).
- Remind operators to build the brain (`drush droost:brain:build`) before capability tools answer.
- Remind operators to index the code (`drush droost:search:index`) for search tools.
- Remind operators to wire their editor with `drush droost:install`.
- Point at the comprehensive human guide shipped with the droost_cms recipe (`docs/fully-utilizing-droost.md`).
- Publish a project's own guideline topics through the same `guidelines/topics/*.md` seam.
- Enable it as part of the droost_cms recipe so agents get guidance by default.
- Keep the module dependency-light (only `droost`) and side-effect-free (no routes/config/permissions).
