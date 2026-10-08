<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Droost Playbook declares the Droost site-building methodology to AI agents as served guideline topics — SDC as the universal display substrate, the tool flows to follow, and worked examples.

---

Droost Playbook is the methodology layer of Droost, and it is pure content: it ships two on-demand guideline topics — `guidelines/topics/methodology.md` (the Droost way of building a site: SDC as the universal display substrate, the plan/introspect/compose tool flows, and worked examples) and `guidelines/topics/theming.md` (the theming methodology). The base module's `GuidelineProvider` discovers every enabled module's `guidelines/topics/*.md`, so these topics join the catalog and an agent retrieves them by calling the base `droost_guidelines` MCP tool with the matching `topic`. Their names also appear in the AGENTS.md block that `drush droost:install` writes, so a cold agent is pointed at the methodology automatically. The module contains no PHP `src`, no routes, permissions, config or Drush commands; it depends only on `droost` and carries a single kernel test (`PlaybookTopicTest`) asserting the topics are served. Serving is gated by mcp_server's `access mcp server` permission and the base `GuidelineProvider::getTopic()` sanitizes topic names, so there is no arbitrary-file exposure. Enable it on sites built the Droost way; the droost_cms recipe enables it by default. Local development only.

---

- Teach an AI agent the Droost site-building methodology via served guideline topics.
- Serve the `methodology` topic through the base `droost_guidelines` tool (SDC as the universal display substrate).
- Serve the `theming` topic through the base `droost_guidelines` tool.
- Have both topics auto-listed in the AGENTS.md block written by `drush droost:install`.
- Point a cold agent at the tool flows to follow (introspect -> compose -> verify) before it builds.
- Give an agent worked examples of the Droost way rather than ad-hoc, version-stale patterns.
- Keep the methodology as a file-based, framework-free content pack (no PHP, no config, no side effects).
- Enable it on sites built the Droost way so agents build consistently.
- Enable it as part of the droost_cms recipe by default.
- Publish additional project methodology through the same `guidelines/topics/*.md` seam.
- Verify topics are served via the shipped `PlaybookTopicTest` kernel test.
- Keep the module dependency-light (only `droost`).
