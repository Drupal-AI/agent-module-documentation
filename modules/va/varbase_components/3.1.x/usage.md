<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Varbase Components is the components-handler module of the Varbase distribution. It ships no components, templates, libraries, or config of its own — it is glue that installs the UI Patterns + UI Icons SDC theming stack (via a recipe), exposes an `active_theme` Twig variable, and rewrites theme references in config when the default theme changes.

---

The module has three concrete jobs. First, on install it runs the bundled core recipe in `recipes/default/`, which installs and imports the config of the UI Patterns family (`ui_patterns`, `ui_patterns_layouts`, `ui_patterns_library`, `ui_patterns_views`, `ui_patterns_field_formatters`, `ui_patterns_field_group`, `ui_patterns_ds`) and the UI Icons family (`ui_icons`, `ui_icons_patterns`, `ui_icons_field`, `ui_icons_picker`, `ui_icons_library`); its composer requirements additionally pull in `ds`, `field_group` and `storybook`. So enabling this one module stands up the whole SDC/UI-Patterns component tooling Varbase relies on. Second, `VarbaseComponentsHooks::preprocess()` — a `#[Hook('preprocess')]` — sets `$variables['active_theme']` to the site's default theme machine name for every template, so Vartheme component templates can key off it. Third, `ActiveThemeChangeSubscriber` listens on the config `SAVE` event; when `system.theme:default` actually changes **and both** the old and new themes declare `auto_switch_components: true` in their `.info.yml`, it does a bulk regex find-and-replace of the old theme's machine name with the new one across all active config — most importantly `core.entity_view_display.*` entries (where UI Patterns/DS bind components per view mode) and each config's `dependencies.theme` list. This is a config-migration step, not a render-time switch: it exists so that component configuration bound to one Vartheme BS5 subtheme keeps working after you re-theme the site to a sibling subtheme. Note the `~11.4.0` core pin ties the site's core updates to Varbase's release cycle; `varbase_components_update_200001()` also uninstalls the old experimental `sdc` module now that SDC is in core.

---

- Install the full UI Patterns + UI Icons SDC theming stack in one step by enabling this module.
- Bootstrap Varbase / Vartheme BS5 component-based theming on a fresh site.
- Enable Storybook-driven SDC component development for a Varbase site.
- Expose the default theme machine name to every Twig template as `active_theme`.
- Reference `{{ active_theme }}` inside a component or theme template to build theme-aware markup or asset paths.
- Auto-migrate component config when switching between Vartheme BS5 subthemes.
- Re-theme a Varbase site to a sibling subtheme without hand-editing `core.entity_view_display.*` config.
- Keep UI Patterns / Display Suite bindings valid across a theme change.
- Rewrite `dependencies.theme` references in config after swapping the default theme.
- Opt a custom theme into auto config migration by adding `auto_switch_components: true` to its `.info.yml`.
- Understand why enabling one Varbase module also enabled a dozen ui_patterns/ui_icons modules.
- Audit an inherited Varbase installation's component tooling and where it came from.
- Trace which module installed and imported the UI Patterns config on a Varbase site.
- Debug a theme-switch that unexpectedly rewrote entity view display config (check `varbase_components` log entries).
- Decide whether the module belongs on a non-Varbase site (it works, but pins core to `~11.4.0`).
- Plan core updates around the `~11.4.0` pin that travels with the Varbase release cycle.
- Confirm both source and target themes set `auto_switch_components` before relying on auto-migration.
- Review the config log channel `varbase_components` to see which configs were rewritten during a theme change.
- Clean up the deprecated experimental `sdc` module automatically on update.
- Investigate why a component renders correctly on the front end but its config still points at an old theme name (auto-switch skipped because a theme lacked the flag).
