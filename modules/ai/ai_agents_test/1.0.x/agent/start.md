<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Agents Test (ai_agents_test) — agent index

Content entity describing a test for an AI agent; runnable from the UI or exportable as config for
a test runner. Version **1.0.0-alpha4**, `lifecycle: experimental`. Core `^10.3 || ^11`.
Depends on `ai_agents:ai_agents`, `views`, `options`, `user`.

Permissions: `administer ai_agents_test` (**`restrict access: true`**), `view ai_agents_test`,
`edit ai_agents_test` — so test authors need not administer the agent framework.

The dual nature is the point: during development a test is an editable content entity; for a
pipeline the same test is exported configuration.

**Experimental + alpha, on top of a fast-moving `ai_agents`.** Good for a project actively
building agents; do not depend on the exported format for anything long-lived yet.