<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Enhanced Entity Browser lets you attach a pluggable "enhancer" (extra CSS + JavaScript behaviour) to each **View** widget of an Entity Browser, shipping two ready-made enhancers: Enhanced Multiselect and Enhanced Autoselect.

---

The module does not replace Entity Browser — it adds usability polish to the `view` widget only. It defines a small YAML-discovery plugin type, `entity_browser_enhanced_plugin`, whose definitions live in any module's `*.enhancers.yml` file and carry four required keys: `id`, `label`, `form_extra_class` and `library`. The manager service is `plugin.manager.entity_browser_enhanced_plugin` (`EntityBrowserEnhancedPluginManager`, YamlDiscovery on `enhancers`). Via `hook_form_alter()` the module adds a **Select enhancer** dropdown to every View widget row on the Entity Browser widgets configuration form (`entity_browser_widgets_config_form`), and its extra submit handler stores the choice in a plain config object named `entity_browser_enhanced.widgets.<entity_browser_id>`, keyed by the **widget's UUID** with the enhancer id (or `_none_`) as value. When an actual Entity Browser form is built, the same hook reads that config, attaches the matching library, adds the classes `entity-browser-enhanced` plus the enhancer's `form_extra_class` to the form, and — if the browser is used as a field widget — passes the field's cardinality into `drupalSettings.entity_browser_enhanced.<enhancer_id>.cardinality`. The bundled **multiselect** enhancer hides the checkboxes, makes the whole entity tile clickable, enforces cardinality client-side, disables the submit button until something is selected, and submits on double-click; **autoselect** makes a row click immediately add the entity via Entity Browser's `add-entities` event. A `hook_library_info_alter()` also removes Lightning Media's `browser.styling` library to avoid conflicting styles. There is no settings page of its own (`configure: null`), no permissions and no Drush commands.

---

- Turn a media/image Entity Browser grid into a click-anywhere tile selector instead of checkboxes.
- Let editors double-click a thumbnail to pick it and submit the browser in one gesture.
- Respect an image field's cardinality so editors cannot select more items than the field allows.
- Prevent an empty submit by disabling the "Select entities" button until something is chosen.
- Give an unlimited-cardinality field a true multi-select browser experience.
- Apply the Lightning-style media browser look without installing Lightning.
- Add auto-select behaviour so a single click adds the entity straight to the selection list.
- Style a specific Entity Browser differently by choosing a different enhancer per widget.
- Ship a custom enhancer from your own module by adding a `mymodule.enhancers.yml` file.
- Point an enhancer at a **theme** library so the browser matches your design system.
- Provide different enhancers for a "browse media" widget and an "upload" widget in the same browser.
- Roll out a consistent selection UX across several entity browsers via exported config.
- Debug which enhancer a browser uses with `drush config:get entity_browser_enhanced.widgets.<browser>`.
- Disable an enhancer again by setting the widget's UUID value to `_none_`.
- Add keyboard-friendly debounced filtering to browser exposed filters (`.keyup-change` behaviour).
- Improve editorial throughput on image-heavy content types.
- Standardise media picking UX between paragraph, node and block forms that share one browser.
- Keep Entity Browser's own View widget configuration untouched while changing only presentation.
- Build a "one click to add" gallery picker for a media reference field.
- Attach extra client-side validation styling to selected entities via the enhancer's CSS.
- Migrate a bespoke entity-browser JS tweak into a reusable, config-selectable enhancer plugin.
- Give content editors visual feedback (selected state styling) on chosen entities.
- Avoid theme-level JS overrides by moving behaviour into a declarative plugin.
- Audit or diff enhancer assignments per entity browser as normal configuration.
- Remove Lightning Media's conflicting `browser.styling` library automatically.
