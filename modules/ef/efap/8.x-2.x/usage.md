<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extra Field as Plugin (efap) defines a Drupal plugin type so developers can declare entity display "extra fields" (pseudo-fields) as annotated plugin classes instead of writing the hook boilerplate by hand.

---

Extra Field as Plugin (efap) is a developer/API module. Drupal's "extra fields" are pseudo-fields that show up on an entity type/bundle's *Manage display* page and render computed or display-only output rather than stored field data; normally you expose them through `hook_entity_extra_field_info()` and render them in `hook_entity_view()`. efap replaces that boilerplate with a discoverable plugin type: it registers a plugin manager (`efap.plugin_manager`) that scans each module's `src/Plugin/ExtraField/` directory for classes annotated with `@ExtraField` and implementing `ExtraFieldInterface` (usually by extending `ExtraFieldBase`). The module's own `hook_entity_extra_field_info()` and `hook_entity_view()` implementations iterate every discovered plugin, call its `info()` to advertise the field and its `view()` to render output only when the display component is enabled. Each plugin declares which entity type, bundle and field id it targets, and produces a standard Drupal render array — so the visible output, its escaping and any access checks are entirely the plugin author's responsibility. The package is `Code`; it has no configuration UI, no permissions and no runtime dependencies beyond Drupal core. A legacy Drupal Console `generate:efap` command (plus a Twig scaffold template) can scaffold a new plugin class, but is optional and unrelated to how the fields render at runtime.

---

- Add a computed "extra field" to node displays without writing `hook_entity_extra_field_info()` by hand.
- Expose a display-only pseudo-field on a specific content type via a plugin class.
- Register an extra field for users, taxonomy terms, media, or any entity type.
- Scope a pseudo-field to a single bundle from within the plugin's `info()` method.
- Render a formatted "full name" field combining first/last name properties.
- Show a computed price, total, or subtotal on a commerce/product display.
- Display a "related content" or "read next" block as an orderable extra field.
- Add a social-share or print-this row that editors can position on *Manage display*.
- Surface an entity's computed status or badge as a toggleable display component.
- Render a call-to-action button that only appears in certain view modes.
- Provide a "last updated" or reading-time indicator as a pseudo-field.
- Inject a QR code or barcode derived from the entity into its display.
- Add a map or embed generated from the entity's address/coordinate properties.
- Keep display logic in a testable, autoloaded class instead of a procedural hook.
- Let site builders reorder and hide the extra field per view mode like a real field.
- Inject services into a field via `ContainerFactoryPluginInterface` in the plugin.
- Migrate legacy `hook_entity_view()` markup into discrete, discoverable plugins.
- Organize many pseudo-fields across a module as one plugin directory.
- Scaffold a new extra-field plugin with the `generate:efap` Drupal Console command.
- Ship reusable extra-field plugins as part of a contrib or custom module.
- Provide a container-wrapped render array (with a clean CSS class) as a base to build on.
- Conditionally render output per view mode using the `$viewMode` argument.
- Depend on efap from another module and implement `ExtraFieldInterface` plugins.
- Standardize how a team defines display-only fields across multiple projects.
- Replace one-off preprocess hacks with structured, per-entity extra fields.
