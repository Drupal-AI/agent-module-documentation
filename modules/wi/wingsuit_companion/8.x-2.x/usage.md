<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Wingsuit companion is the Drupal half of Wingsuit, a front-end design-system toolkit where components are developed outside Drupal (Storybook, hot reloading) and served into Drupal without mapping code. The main module does one concrete thing: it registers a read-only `ws-assets://` stream wrapper that resolves to the front-end project's built `dist` directory, configured at `/admin/wingsuit-companion/form/config`. Four submodules bridge that build into UI Patterns, Layout Builder, link attributes and Page Manager.

---

The pain Wingsuit targets is that Drupal is a slow, coupled place to iterate on components; a designer wants a dev server and isolated rendering, Drupal offers a cache rebuild. Wingsuit keeps the component in a front-end project with its own build, and this module makes the built output addressable from Drupal. The mechanism in `wingsuit_companion` itself is small: a `LocalReadOnlyStream` subclass (`WingsuitStreamWrapper`, scheme `ws-assets`) whose directory path is the `dist_path` config value, a single admin `ConfigForm` (`dist_path`, `only_own_layout`, `auto_fill_link_url`), the `administer wingsuit configuration` permission (`restrict access: true`), and an install hook that seeds `dist_path`. Everything else is in the submodules. `wingsuit_ui_patterns` is where the real integration lives: a UI Patterns pattern plugin (`id = "yaml"`) with a `LibraryDeriver` that scans the configured `dist_path` for `*.wingsuit.yml` / `*.wingsuit.yaml` files and derives each as a UI Pattern, plus a Twig extension adding `ws_itok()` (deployment-identifier cache key) and `uuid()`. It also filters patterns by a `visibility` key (only those including `drupal`) and can hide all non-Wingsuit layouts when `only_own_layout` is on. Its dependency stack is heavy: `ui_patterns (>=1.1)`, `ui_patterns_layouts`, `ui_patterns_settings (>=2.0)`, `ui_patterns_extends`, `components`. `wingsuit_lb` reskins the Layout Builder "choose section / choose block" browser and adds a section-library "Add to library" button (depends on `layout_builder_browser >=1.7`, `field_group`, `gin_lb >=1.0.0-rc7`, `section_library`). `wingsuit_link` maps a `button` pattern's variant and settings onto the core link widget via `link_attributes` + `ui_patterns_settings`, optionally auto-filling the pattern's `url` setting from the link. `wingsuit_page_manager` supplies a theme negotiator (priority 41) that switches Page Manager layout-builder steps to the default frontend theme and tweaks `gin_lb` toolbar visibility.

Adopting Wingsuit is a workflow decision, not just a module install: it presumes a front-end project, a build step producing a `dist/app-drupal` directory, and a team that wants component development outside Drupal. On a site without that build, the stream wrapper resolves to nothing and the UI Patterns deriver finds no files. Note also that on a bare install only the main module is enabled — the submodules require their contrib dependencies (`ui_patterns_settings`, `ui_patterns_extends`, `components`, `layout_builder_browser`, `gin_lb`, `section_library`, `link_attributes`) to be present first.

---

- Serve a front-end project's built assets into Drupal through a `ws-assets://` stream wrapper.
- Reference built design-system assets as `ws-assets://…` from Twig templates and libraries.
- Point Drupal at the `dist/app-drupal` output of a Wingsuit/Storybook build.
- Configure the components/`dist` path at `/admin/wingsuit-companion/form/config`.
- Develop Drupal components outside Drupal with hot reloading, then consume them without mapping code.
- Derive `*.wingsuit.yml` component definitions as UI Patterns (`wingsuit_ui_patterns`).
- Expose front-end components as placeable UI Patterns in Layout Builder / Display Suite.
- Restrict shown patterns to those whose `visibility` includes `drupal`.
- Hide all non-Wingsuit layouts in Layout Builder (`only_own_layout`).
- Use `ws_itok()` in Twig to cache-bust generated SVGs by deployment identifier.
- Generate a unique DOM id in Twig with `uuid()`.
- Reskin the Layout Builder block/section browser to the Wingsuit UI (`wingsuit_lb`).
- Add an "Add to library" section-library button on node layout-builder forms.
- Map a `button` pattern's variant and settings onto Drupal link fields (`wingsuit_link`).
- Auto-fill a button pattern's `url` setting from the linked field's URL.
- Force Page Manager layout-builder steps to render in the frontend theme (`wingsuit_page_manager`).
- Keep component source and build tooling out of the Drupal repository.
- Share the same component library between Drupal and other consumers.
- Restrict who may change the asset/`dist` path with `administer wingsuit configuration`.
- Install the UI Patterns / Layout Builder contrib stack before enabling the bridge submodules.
- Diagnose `ws-assets://` assets that resolve to nothing (empty or wrong `dist_path`).
- Audit which components a site actually consumes from the Wingsuit build.
