<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IA Creation Kit (iack) — agent index
**Uploads an IA spreadsheet and drives an AI agent to create vocabularies, content types, and fields.**

- **Version:** 1.0.x
- **Core:** ^10.3 || ^11
- **Depends on:** ai_agents, ai_assistant_api (Composer: `phpoffice/phpspreadsheet`)
- **Route:** `iack.upload_information_architecture` → `/admin/config/ai/iack` (form)
- **Permission:** `upload information architecture` (restrict access: TRUE)
- **Service:** `iack.iack_helper` (`IackHelper`) parses XLSX → prompts → `ai_assistant_api.runner`
- **Template:** `template/iatemplate.xlsx`

**Security:** single admin form gated by a dedicated restricted permission; it commands an AI agent that can create site structures (high-impact) — grant only to trusted admins. External LLM calls occur inside the configured AI provider, not this module.
