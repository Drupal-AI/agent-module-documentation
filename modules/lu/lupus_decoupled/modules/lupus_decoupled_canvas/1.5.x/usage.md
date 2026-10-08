<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lupus Decoupled Canvas configures theming for Drupal Canvas's editor routes and previews on a decoupled site.

---

Canvas is a visual page builder whose editing experience runs inside Drupal, while the site the editor is building runs somewhere else. That mismatch produces a specific problem: the editor's routes and its preview need a theme, and on a decoupled site the front-end theme is not Drupal's.

This submodule handles that configuration, so Canvas's editing UI and previews behave sensibly in a decoupled setup rather than rendering against whatever theme happens to be active.

**Note on documenting this one.** Canvas could not be kept enabled on the review install — its SDC component discovery asserted and fataled the container build with third-party components present (see `canvas_field_component` and the `canvas` notes). This submodule is therefore described from source and from its stated purpose. If you are combining Canvas with Lupus Decoupled, expect to resolve that interaction first; the failure is a development-environment one (assertions are compiled out in production PHP) but it stops local work dead.

---

- Theme Canvas editor routes on a decoupled site.
- Make Canvas previews render sensibly.
- Combine a visual builder with a decoupled front end.
- Keep the editing UI usable in Drupal.
- Preview decoupled output from Canvas.
- Configure theming for editor-only routes.
- Avoid previews rendering against the wrong theme.
- Plan a Canvas plus Nuxt build.
- Resolve the Canvas SDC assertion issue first.
- Understand why previews look wrong.
- Separate editing theme from front-end presentation.
- Evaluate Canvas for a decoupled project.
- Check assertions configuration in development.
- Audit an existing Canvas decoupled setup.
- Document the Canvas interaction for the team.
