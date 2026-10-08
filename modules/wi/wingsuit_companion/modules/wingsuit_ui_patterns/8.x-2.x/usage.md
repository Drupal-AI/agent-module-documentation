<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Wingsuit UI Patterns turns components defined in a Wingsuit front-end project into UI Patterns pattern plugins, and adds the Twig extensions they need.

---

This is the submodule that makes Wingsuit useful rather than merely present. Without it, a Wingsuit build is a stream wrapper pointing at some compiled assets; with it, each component declared in the front-end project's `wingsuit.yml` becomes a pattern Drupal knows about — selectable in UI Patterns layouts, usable from field templates, and addressable from Twig.

That is the whole promise of the toolkit: a designer builds a card in a project with hot reloading and a pattern library, and a site builder places that same card in Drupal without either of them writing an integration.

**Its dependency list is the heaviest in the suite and it could not be enabled on the review install.** It needs `ui_patterns (>=1.1)`, `ui_patterns_layouts`, `ui_patterns_settings (>=2.0)`, `ui_patterns_extends` and `components`; the last three were not present, so `drush en wingsuit_ui_patterns` failed. That is not a defect — the dependencies are honestly declared — but it means adopting Wingsuit's component integration is an install of six modules, not one, and the UI Patterns stack should go in first.

Worth noting that the ecosystem has moved: core's Single Directory Components now cover much of what UI Patterns was built for. On a new project, weigh whether the Wingsuit-to-SDC path is shorter than the Wingsuit-to-UI-Patterns one before committing to this dependency chain.

---

- Expose front-end components as UI Patterns.
- Declare components in wingsuit.yml.
- Place a designer-built card in Drupal.
- Use a Wingsuit component in a UI Patterns layout.
- Call a component from a Twig template.
- Add Twig extensions for component rendering.
- Share one component between Drupal and a pattern library.
- Avoid writing an integration per component.
- Install the UI Patterns stack before this module.
- Understand the six-module dependency chain.
- Diagnose an enable that fails on missing dependencies.
- Compare the UI Patterns path with core SDC.
- Plan a component workflow for a new project.
- Audit which components a site consumes.
- Keep component source outside the Drupal repo.
- Give designers hot reloading without leaving Drupal behind.