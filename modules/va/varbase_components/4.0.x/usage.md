Varbase Components (4.0.x) is the components-handler module of the Varbase distribution, rebuilt around Drupal Canvas (the `cva` module): it migrates every component reference when the default theme changes, heals stale SDC component version hashes, hides administrative Canvas components, and adds Views plugins that render a view through a Single Directory Component.

---

The 4.0.x line dropped the old UI Patterns / UI Icons recipe and now depends only on `drupal/cva` (~1) and core `views`; it ships no components, templates or libraries of its own. Its core piece, `ActiveThemeChangeSubscriber`, listens on the config `SAVE` event and — only when `system.theme:default` changes and both the old and new themes set `auto_switch_components: true` in their `.info.yml` — runs a full re-theming migration across the whole site: it regex-rewrites the old theme's machine name, `themes/(contrib|custom)/<theme>/` paths and `sdc.<theme>.` component IDs across all active config, rewrites `dependencies.theme` lists, clones Canvas `page_region` config entities to the new theme, rewrites the `component_id` column in every `component_tree` content-field table, replaces old theme filesystem paths in text/body fields, and heals stale `component_version` hashes in config and content. A second concern is version-healing: Canvas regenerates its SDC component config entities (with new version hashes) on cache rebuild, module install and theme install, so `VarbaseComponentsHooks` is weighted heavier than Canvas and calls `heal()` from the `rebuild`, `modules_installed` and `themes_installed` hooks to rewrite any config/content still pinning an old hash to the active version. Third, it curates the Canvas component library — a `component_presave` hook and `hook_install()` create/keep the `hidden_canvas_components` list disabled (admin/duplicate blocks and SDCs), and `themes_uninstalled` deletes orphaned `sdc.<theme>.*` component configs. It also still exposes an `active_theme` Twig variable, ships an `aos` (Animate-On-Scroll) library, provides two Views plugins (`components_views_style`, `components_exposed_form`) that render a view or its exposed filters through an SDC, and three Drush commands (`switch-theme`, `fix-versions`, `scan-refs`). The `~11.4.0` core pin ties the site's core updates to the Varbase release cycle.

---

- Automatically migrate all component references when re-theming a Varbase/Canvas site from one theme to a sibling.
- Rewrite `sdc.<oldtheme>.*` component IDs to `sdc.<newtheme>.*` across all active config on a default-theme change.
- Rewrite the `component_id` column in every `component_tree` content-field table when the theme switches.
- Clone Canvas `page_region` entities (Canvas header/footer) to the new theme so the site keeps its regions after a switch.
- Replace hardcoded `themes/contrib|custom/<oldtheme>/` filesystem paths in body/text fields with the new theme's path.
- Rewrite `dependencies.theme` lists in config to point at the new theme.
- Heal stale SDC `component_version` hashes automatically after a cache rebuild, module install or theme install.
- Silence Canvas's "Component version … not found, falling back to active version" render warning.
- Repair demo/authored content (canvas_page, nodes) that pins an old component version after a component edit.
- Manually run a full theme switch with `drush varbase-components:switch-theme <old> <new>` (with `--dry-run`).
- Manually repair every stale component version with `drush varbase-components:fix-versions <theme>`.
- Audit which configs and content rows still reference an old theme with `drush varbase-components:scan-refs <theme>`.
- Opt a custom theme into the auto-migration by adding `auto_switch_components: true` to its `.info.yml` (both source and target must set it).
- Keep administrative/duplicate Drupal Canvas components (AI dashboard, project browser, Webshare share) out of the editor component library by default.
- Add or change the hidden component list by overriding `varbase_components.settings:hidden_canvas_components` (no settings UI).
- Re-enable a hidden Canvas component manually when a site builder does want it (only the initial status is enforced).
- Remove orphaned `sdc.<theme>.*` Canvas component configs automatically when a theme is uninstalled.
- Reference `{{ active_theme }}` in a template to get the site default theme's machine name.
- Render a Views listing through a Single Directory Component by choosing the "Component" (`components_views_style`) style and a rows slot.
- Map static values onto an SDC's props from the Views style options form (typed per the component schema).
- Render a view's exposed filter form through an SDC with the "Component" (`components_exposed_form`) exposed-form plugin.
- Expose only components that declare `use_in_views: true` (and, for the style, a `rows` slot) in the Views plugin selectors.
- Attach the AOS (Animate On Scroll) vendor library via `varbase_components/aos`, initialized as a Drupal behavior respecting reduced-motion.
- Understand why enabling this module also requires the Drupal Canvas (`cva`) module.
- Plan core updates around the `~11.4.0` pin that travels with the Varbase release cycle.
