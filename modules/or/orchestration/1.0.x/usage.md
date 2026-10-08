<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Orchestration connects the Drupal site with external platforms.

---

Orchestration connects Drupal with external platforms — a framework for orchestrating integrations/
workflows across systems, with submodules for AI agents (`orchestration_ai_agents`), AI functions
(`orchestration_ai_function`), ECA integration (`orchestration_eca`) and tooling (`orchestration_tool`). It
provides its own permissions, in the Web services package.

Use it to orchestrate cross-platform integrations and AI/automation workflows. It is a powerful integration/
automation feature. Security-relevant points: it connects to external platforms with **credentials — store
those as secrets** and operate over HTTPS; the AI/ECA/tooling submodules can execute automations/actions, so
those run with the site's privileges — **restrict who can configure orchestrations** (an orchestration is
executable automation with external reach) to trusted admins, and review what each submodule enables (e.g.
AI functions that call external LLMs send data out). It has no access-control role beyond its permission.
Configure the platform connections and orchestrations.

---

- Connect Drupal with external platforms.
- Orchestrate cross-platform workflows.
- Provide AI-agents/AI-function/ECA/tool submodules.
- Provide its own permissions.
- Store platform credentials as secrets.
- Operate over HTTPS.
- Run automations with the site's privileges.
- Restrict who can configure orchestrations (trusted admins).
- Review what each submodule enables.
- Mind AI functions sending data to external LLMs.
- Have no access-control role beyond permission.
- Configure platform connections.
- Handle orchestration.
- Configure workflows.
- Handle integrations.
- Handle credentials securely.
- Configure the platform.
- Orchestrate integrations.
- Restrict orchestration config.
- Connect external platforms.
