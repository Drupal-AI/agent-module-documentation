<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SDC Component Library renders a single preview page listing every Single Directory Component (SDC) on the site, so designers and developers can see the whole component set in one place without a separate Storybook installation.

---

Single Directory Components landed in Drupal core as the standard way to package a component — its Twig template, CSS, JavaScript and metadata in one folder with a schema describing its props and slots. What core does not provide is a way to *look* at them: components are only visible where they happen to be used, so a design system built from SDC has no gallery. The established answer is Storybook, which means a Node toolchain, a parallel rendering environment and the ongoing risk that a story drifts from the component. This module takes the lighter route — a page (default `/sdc-component-library`, configurable) that renders each component through Drupal itself. The controller pulls every definition from core's SDC plugin manager, looks for a sibling `<machine>.story.twig` file, and includes it so what you see is exactly what the site renders; components without a story file show a "missing" placeholder instead. Each entry also gets a copyable `{% include %}` snippet built from the component's own `*.component.yml` example props, and an in-page axe-core accessibility scan flags obvious WCAG issues. A settings form lets you change the page path (it rebuilds the route), and a single permission `access sdc component library` controls who reaches the page. Core requirement is `^10.3 || ^11`, matching SDC's availability.

---

- Preview every SDC component on one page.
- Give designers a component gallery.
- Check that a component renders correctly.
- Avoid setting up a Storybook installation.
- Review the component set with a stakeholder.
- Verify component props from the schema.
- Onboard a developer to the design system.
- Spot components that lack a `.story.twig` file.
- Compare component variants side by side.
- Document a front-end library in-site.
- Test components after a theme change.
- Render components exactly as the site does.
- Copy a ready-made `{% include %}` snippet for a component.
- Run a quick axe-core accessibility check on a component.
- Move the preview page to a custom path (e.g. `/components`).
- Restrict the gallery to developer roles.
- Audit a design system's component coverage.
- Demonstrate components during a design review.
- Debug a component's slot and prop handling.
- Keep component previews in step with the code.
