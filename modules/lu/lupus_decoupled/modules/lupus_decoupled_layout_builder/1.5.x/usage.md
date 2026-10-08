<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lupus Decoupled Layout Builder supplies the base setup that lets Layout Builder-composed pages render through the custom-elements API.

---

Layout Builder is how a lot of Drupal sites let editors compose pages, and it is exactly the capability a naive decoupled build loses first: the layout is data in Drupal, the rendering is Drupal's, and a front end fetching entity fields sees none of it.

This submodule provides the base configuration so Layout Builder output flows through the same custom-elements pipeline as everything else. Sections and their blocks render server-side and arrive as elements the front end hydrates, so an editor composing a page in Layout Builder sees the result on the decoupled front end.

What to settle early is the **component contract**. Layout Builder produces sections with layouts and blocks; the front end has its own components. Deciding which Drupal layouts map to which front-end components, and what happens when an editor uses one the front end does not implement, is the design work — otherwise editors compose pages that render as unstyled elements.

---

- Compose a page in Layout Builder for a decoupled site.
- Render Layout Builder sections as custom elements.
- Let editors control page composition.
- Map Drupal layouts to front-end components.
- Handle a layout the front end does not implement.
- Keep inline blocks working in a decoupled build.
- Preserve section configuration in the front end.
- Avoid losing page composition when decoupling.
- Give editors a visual builder on a headless site.
- Plan the component contract with the front end.
- Debug a section rendering unstyled.
- Support per-entity layout overrides.
- Combine Layout Builder with custom elements.
- Reuse existing Layout Builder configuration.
- Evaluate progressive decoupling options.