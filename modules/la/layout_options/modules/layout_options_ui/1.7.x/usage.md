Layout Options UI is a submodule of Layout Options that lets you retrofit existing core/contrib layouts to use the Layout Options plugin — via an admin form — so their YAML-defined options appear without redefining the layouts.

---

The submodule adds a settings form at *Configuration → System → Layout Options*
(`/admin/config/system/layout_options/config`, route `layout_options_ui.settings`, gated by
`administer site configuration`). The form lists every discovered layout and lets you tick the
ones that should be "overridden". Choices are stored in the `layout_options.settings` config
object under `layout_overrides`, a map keyed by `{provider}__{layout_id}` with boolean values
(e.g. `layout_discovery__layout_onecol: true`). At layout discovery time
`layout_options_ui_layout_alter()` (a `hook_layout_alter` implementation) reads that config and,
for every enabled key, calls `$definition->setClass('\Drupal\layout_options\Plugin\Layout\LayoutOptions')`
— swapping the layout's plugin class to the Layout Options one so the parent module's option
controls apply. It has no plugins, permissions or Drush of its own; it is a thin
config-plus-alter bridge that activates Layout Options on layouts you didn't author. Remember to
rebuild the layout plugin cache after changing the overrides (the form does this for you).

---

- Enable Layout Options on the core one-column layout without redefining it.
- Add styling options to the core two-column section layout from the admin UI.
- Retrofit a contrib/theme layout to use the Layout Options plugin.
- Pick exactly which layouts should gain option controls via checkboxes.
- Turn Layout Options on/off for a layout by toggling its `layout_overrides` entry.
- Centralize which layouts are "option-enabled" in one config object for deployment.
- Activate Layout Options across a Layout Builder site without custom code.
- Override several core layouts at once from a single settings form.
- Export the `layout_options.settings` config so overrides travel between environments.
- Read `layout_overrides` to audit which layouts currently use the Layout Options class.
- Swap a layout's class back to core by unticking it in the form.
- Enable options for a specific layout id whose provider you don't control.
- Combine with a theme's `[theme].layout_options.yml` to apply that theme's option set to core layouts.
- Provide site builders a supported path to Layout Options instead of editing `*.layouts.yml`.
- Apply option controls to `layout_onecol`, `layout_twocol`, and similar core layouts.
- Manage the class-swap declaratively rather than via a custom `hook_layout_alter`.
- Roll out Layout Options to selected layouts gradually.
- Keep authored layouts untouched while still gaining Layout Options behavior.
