<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# More Global Variables (mgv) — agent index

Exposes a `global_variables` object (paths, page title, language, site info, social-sharing URLs) to
**every** Twig template via `hook_template_preprocess_default_variables_alter`. No config, no
permissions, no Drush. Defines the **GlobalVariable** plugin type; each value is a plugin. Drupal
10.3+/11/12, no contrib deps.

- **Every built-in `global_variables.*` value + Twig usage** → [api/variables.md](api/variables.md)
- **The GlobalVariable plugin type: add your own variable, dependencies, context-awareness, cache
  metadata** → [plugins/global_variable.md](plugins/global_variable.md)

Key facts:
- Manager `MgvPluginManager` (service `Drupal\mgv\MgvPluginManagerInterface`, alias
  `plugin.manager.mgv`), discovery in `Plugin/GlobalVariable`, attribute `#[Variable('id')]`
  (legacy `@Mgv` annotation deprecated in 2.3.0).
- Plugin id with `\` → nested Twig key: `social_sharing\facebook` → `global_variables.social_sharing.facebook`.
- Failing/unavailable plugins are skipped silently (see `MgvPluginManager::getVariables()`).
