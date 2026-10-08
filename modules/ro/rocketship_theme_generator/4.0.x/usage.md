<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Rocketship Theme Generator scaffolds component-based subthemes for the Dropsolid Rocketship distribution, wiring up the `components` and `unified_twig_ext` Twig namespaces and responsive image setup expected by that framework.

---

The module provides a helper `rocketship_theme_generator_generate_theme_extention($module_name)` that instantiates `ThemeExtentionGenerator`, computes how deep the module is installed relative to the Drupal root, and generates a theme extension scaffold from bundled `templates/` and `scripts/`. It is a build/scaffolding utility used during theme development rather than a runtime feature: there are no routes, permissions, services, blocks or config. It depends on `components`, `unified_twig_ext` and core `responsive_image`. Because generation writes theme files to disk, it is intended for local/dev environments, not production request handling.

---

- Scaffold a new Rocketship-style component-based subtheme.
- Generate the Twig component namespaces used by Dropsolid Rocketship.
- Set up responsive image integration for a new theme.
- Speed up starting a Rocketship front-end build.
- Produce a consistent theme structure across projects.
- Bundle starter templates and scripts for component development.
- Wire `components` and `unified_twig_ext` into a generated theme.
- Provide a repeatable scaffold instead of manual copy-paste.
- Support Drupal 9.5/10 Rocketship front-end workflows.
- Keep component libraries organised from project start.
- Reduce boilerplate when spinning up Dropsolid sites.
- Generate theme extensions from a helper function during development.
- Standardise Twig extension usage for design systems.
- Serve as a developer-only tool kept out of production runtime.
- Bootstrap SDC-adjacent component theming for Rocketship.
