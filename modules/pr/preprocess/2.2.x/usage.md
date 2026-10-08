<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Preprocess provides a plugin type that lets you move `hook_preprocess_HOOK()` logic out of THEME.theme / MODULE files into small, focused **Preprocess plugin** classes, each declaring the single theme hook it handles.

---

It is a developer API module with no UI, settings, permissions or Drush. It defines a plugin type discovered from `Plugin/Preprocess/` (plus `*.preprocessors.yml`) with a manager service `preprocess.plugin.manager` and an orchestrator `preprocess.manager`. Each plugin implements `PreprocessInterface::preprocess(array $variables): array` (usually by extending `PreprocessPluginBase`) and is tagged with a `hook` — the theme hook whose variables it should modify, exactly matching `hook_preprocess_HOOK`. The module's own `hook_preprocess()` runs on every theme hook, asks the manager for the plugins registered for that hook (and for the resolved theme-hook *suggestions*, e.g. `node__article`), and runs each plugin's `preprocess()` in turn. A `hook_theme_registry_alter()` makes the module's global preprocessor run **last**, so plugin changes apply on top of core/theme preprocessing. Plugins can be registered two ways: **annotations** (`@Preprocess(id, hook)` on the class — module-only, since annotation discovery doesn't scan themes) or a **`THEME_OR_MODULE.preprocessors.yml`** file mapping a plugin id to `class` + `hook` (works for modules **and themes**). Theme-provided plugins are only active when that theme (or a base theme of it) is the active theme. The result is structured, per-hook preprocessing without long conditional blocks in one giant preprocess function.

---

- Move a bloated `THEME_preprocess_node()` into one Preprocess plugin per hook.
- Add a computed variable to `node` templates via a small `@Preprocess(hook = "node")` plugin.
- Preprocess only `node__article` (a suggestion) without `if ($hook == 'node__article')` guards.
- Let a theme register preprocessing through a `THEME.preprocessors.yml` file (no PHP hook needed).
- Register a module's preprocessor with a class annotation instead of editing the `.module` file.
- Keep each theme hook's preprocessing in its own class for readability and testing.
- Add body/wrapper variables to `page` templates from a dedicated plugin.
- Attach a library or extra data to `block` variables via a Preprocess plugin.
- Scope a preprocessor to a theme so it only runs when that theme is active.
- Share preprocessing logic across projects by shipping Preprocess plugins in a module.
- Unit-test preprocessing logic in isolation (a plugin is a plain class with one method).
- Preprocess `image` variables (e.g. add attributes) from a theme via YAML registration.
- Avoid merge conflicts in a shared `.theme` file by splitting preprocessing into files.
- Order preprocessing predictably (the module's dispatch runs last in the registry).
- Add variables to `field` or `views_view` templates through focused plugins.
- Provide preprocessing from a base theme and have it apply to sub-themes automatically.
- Replace a set of `hook_preprocess_HOOK` implementations with a directory of plugin classes.
- Let multiple modules each contribute a plugin for the same hook, all run in turn.
- Add front-end variables for a component library without touching global preprocess functions.
- Gradually refactor legacy preprocessing hook-by-hook into plugins.
