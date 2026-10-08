<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preprocess — agent index

A **developer API**: a plugin type that replaces `hook_preprocess_HOOK()` with focused
**Preprocess plugin** classes, one per theme hook. No UI, settings, permissions, Drush or
config (`configure: null`); the module just discovers and runs plugins.

- **Write a Preprocess plugin (annotation & `*.preprocessors.yml`), the `hook` key, base class /
  interface, module vs theme discovery** → [plugins/preprocess-plugin.md](plugins/preprocess-plugin.md)
- **How dispatch works (services `preprocess.manager` / `preprocess.plugin.manager`, hook
  suggestions, ordering) and how to call the manager** → [api/manager.md](api/manager.md)

Key facts:
- Plugin dir `src/Plugin/Preprocess/`; interface `PreprocessInterface::preprocess(array
  $variables): array`; base class `PreprocessPluginBase`; annotation
  `Drupal\preprocess\Annotation\Preprocess` with keys **`id`** and **`hook`**.
- `hook` = the theme hook to preprocess, matching `hook_preprocess_HOOK` (e.g. `node`,
  `node__article`, `page`, `block`, `image`).
- Register via **annotation** (modules only) or **`NAME.preprocessors.yml`** (`id: {class, hook}`
  — modules **and** themes). Annotation discovery does not scan themes.
- Theme plugins are only active when that theme (or its base theme) is the active theme.
- Manager services: `preprocess.plugin.manager` (the plugin manager) and `preprocess.manager`
  (dispatch). Clear caches (`drush cr`) after adding/changing a plugin.
