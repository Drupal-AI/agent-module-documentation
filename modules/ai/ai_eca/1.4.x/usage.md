<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI ECA integration (ai_eca) is a deprecated AI-project submodule whose installed 1.4.x code is only a migration shim to the standalone drupal/ai_integration_eca module.

---

AI ECA integration historically provided ECA (Event-Condition-Action) action/condition plugins so no-code ECA models could invoke AI operations from the Drupal AI module. That functionality was moved out to the contributed module drupal/ai_integration_eca in AI 1.2.0, and ai_eca is deprecated and scheduled for removal in AI 2.0.0. The version on disk here (part of the ai project, 1.4.x) ships no plugins, routes, services, permissions or config schema — its only code is the update hook ai_eca_update_11001, which rewrites existing ECA configuration to reference the new module (module dependency ai_eca -> ai_integration_eca and plugin IDs ai_eca_* -> ai_integration_eca_*), installs ai_integration_eca, and then uninstalls ai_eca. It depends on ai, core file, eca and eca_content, and supports Drupal 10.3+ and 11.

---

- Recognize ai_eca as a deprecated AI submodule, not a module to adopt on new sites.
- Understand that ai_eca's ECA AI plugins have moved to drupal/ai_integration_eca.
- Plan a migration off ai_eca before upgrading the AI project to 2.0.0 (which removes it).
- Run `composer require drupal/ai_integration_eca` before running the update hook.
- Let the update hook ai_eca_update_11001 rewrite existing ECA models to the new plugin IDs.
- Have the update hook automatically install ai_integration_eca when it is present.
- Have the update hook automatically uninstall ai_eca once the replacement is active.
- See warnings logged when an ECA config references an ai_eca_* plugin with no ai_integration_eca_* equivalent.
- Identify ECA configs still depending on the ai_eca module dependency.
- Keep an existing site running on ai_eca temporarily while planning the switch.
- Read this doc set to know exactly what the installed code does before touching it.
- Confirm no custom code references the ai_eca_* ECA plugin IDs before removal.
- Locate the replacement module (ai_integration_eca) for current AI + ECA automation.
- Audit dependencies: ai_eca requires ai, file, eca and eca_content.
- Run database updates (drush updatedb) to trigger the migration during a controlled deploy.
- Restore an ECA model whose ai_eca action was dropped because no replacement plugin exists.
- Document a legacy site's AI-plus-ECA setup and its migration path.
- Verify the AI project version to know whether ai_eca still ships (removed in 2.0.0).
- Avoid building new ECA-driven AI workflows on ai_eca; build them on ai_integration_eca instead.
- Understand the deprecation issue at drupal.org/project/ai/issues/3503947.
