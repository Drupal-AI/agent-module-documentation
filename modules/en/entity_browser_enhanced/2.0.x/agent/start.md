<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enhanced Entity Browser — agent index

Attaches an "enhancer" (CSS/JS behaviour) to each **View** widget of an Entity Browser.
No settings page (`configure: null`), no permissions, no Drush. Depends on `entity_browser`.

- **Assign an enhancer to a widget; the exact config object and keys** →
  [configure/assign-enhancer.md](configure/assign-enhancer.md)
- **Define your own enhancer (`*.enhancers.yml` plugin type)** →
  [plugins/enhancers.md](plugins/enhancers.md)

Key facts:

- Config object: **`entity_browser_enhanced.widgets.<entity_browser_id>`**, keys are the
  **widget UUIDs** from `entity_browser.browser.<id>.widgets`, values are enhancer ids
  (`multiselect`, `autoselect`) or `_none_`.
- Only widgets of plugin **`view`** get the *Select enhancer* dropdown.
- Plugin type id `entity_browser_enhanced_plugin`, manager service
  `plugin.manager.entity_browser_enhanced_plugin`, YAML discovery file `*.enhancers.yml`.
- Enhanced forms get classes `entity-browser-enhanced` + the definition's `form_extra_class`,
  and `drupalSettings.entity_browser_enhanced.<id>.cardinality` when used as a field widget.
