<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Checklist adds a Checklist API checklist that guides and tracks the installation and configuration of the AI module stack (oriented to DXPR CMS), auto-detecting which AI modules are already enabled.

---

AI Checklist is a thin integration with the contributed Checklist API (`checklistapi`) module. It defines a single checklist, "AI checklist", via `hook_checklistapi_checklist_info()` in `ai_checklist.module`, surfaced at `/admin/config/ai/ai-checklist`. The checklist items are declared statically in `ai_checklist_checklistapi_checklist_items()` and grouped into sections — Initial Setup, AI Image Features, AI Content Features, Content Analysis, Supporting Tools, and Privacy and Permissions. Each task can carry a `#module` key (a Drupal project machine name) or a `#configure` key (a settings route name). A post-processing pass, `_ai_checklist_preprocess_checklist_items()`, walks every item and: pre-checks the task when the referenced module is already enabled (`moduleHandler()->moduleExists()`), appends the `composer require drupal/<module>` command to the description, adds a "Download" link to the drupal.org project page, adds an "Install" link to the modules list (only if the current user can reach `system.modules_list`), and adds a "Configure" link when the referenced settings route both exists and is accessible to the current user. Checklist API itself stores completion state and timestamps, so the module never persists data of its own. It provides no routes, permissions, services, entities, plugins, config, or Drush commands beyond the two hook functions; all state, storage, and the checklist UI/permissions come from Checklist API.

It is an onboarding and progress-tracking aid: it organizes the AI-setup journey and records what is done, but it does not install modules, change configuration, or perform any AI work itself.

---

- Track installation and configuration progress for the AI module stack from one page.
- Auto-detect which AI modules are already enabled and pre-check those tasks.
- Guide a first-time AI implementation section by section.
- Step through Initial Setup: DXPR API key, Key module, core AI module, DXPR AI provider, provider key configuration.
- Step through AI Image Features: AI Image Alt Text install, configuration, and alt-text generation permissions.
- Step through AI Content Features: AI Agents, AI Content Strategy, CKEditor AI Agent.
- Step through Content Analysis: Analyze framework, AI Brand Voice, AI Sentiment, Basic Content Info, Page Views.
- Step through Supporting Tools: Markdownify and Markdownify Path.
- Step through Privacy and Permissions: Klaro consent, AI permission review, feature testing.
- Get a `composer require drupal/<module>` command inline for each module task.
- Jump straight to each module's drupal.org project page via a Download link.
- Jump to the core modules list (anchored to the module) via an Install link when permitted.
- Jump to a module's settings form via a Configure link when the route exists and is accessible.
- Save checklist progress with timestamps through Checklist API.
- Produce a shareable setup-progress report for a team or client.
- Standardize AI onboarding across multiple Drupal sites.
- Ensure prerequisites like credential storage and provider selection are not missed.
- Use as the AI-setup companion inside a DXPR CMS install.
- Reach the checklist from Configuration > Development, or at `/admin/config/ai/ai-checklist`.
- Rely on Checklist API for state storage and the checklist permission model.
