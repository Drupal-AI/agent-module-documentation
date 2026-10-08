<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Orchestration — agent index

**Connects Drupal with external platforms** (orchestrate integrations/workflows; submodules: AI agents / AI
function / ECA / tool). Provides permissions. Version **1.0.0**. Core `^11.2`.

Powerful integration/automation. **Security:** store platform credentials as **secrets** + HTTPS; the AI/ECA/
tooling submodules execute automations with the site's privileges (external reach) — **restrict who can
configure orchestrations** (trusted admins), review what each submodule enables (AI functions send data to
external LLMs). No access role beyond permission.
