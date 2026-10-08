<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A guardrailed AI sub-agent that edits page copy and images via chat.

---

Peak Web Agent adds a guardrailed "Web Design Editor" AI sub-agent (minion) that lets you edit website COPY and images on existing pages by chatting in plain language — routed by the Drup-AID Master Agent. It is content-values only: it cannot delete content or change site structure, and every change is a rollback-able Drupal revision. Part of the Peak Stack.

It runs through the AI Agents framework (gated by the Drup-AID cockpit permission); AI keys are handled by the `ai` module (env-backed). Because edits are AI-driven, review the guardrails and revisions. Depends on `ai`, `ai_agents`, and core `node`; supports Drupal 10.3+ and 11. Part of the Drup-AID project.

---

- Edit page copy/images via chat.
- Provide a guardrailed AI sub-agent.
- Be routed by the Master Agent.
- Edit content values only.
- Never delete content or structure.
- Record every change as a revision.
- Allow rollback.
- Run via AI Agents (permission-gated).
- Handle AI keys via the `ai` module.
- Depend on `ai`, `ai_agents`, core `node`.
- Support Drupal 10.3+ and 11.
- Belong to the Peak Stack.
- Support Drupal.
- Support Drupal.
- Support Drupal.
