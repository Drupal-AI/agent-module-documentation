<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop UI Components supplies the Single Directory Components the suite's dashboard and admin screens are built from.

---

FlowDrop's administrative interface is substantial — a dashboard, run listings, job detail, a node palette, status indicators — and building it from SDC rather than ad-hoc templates means the pieces are consistent, reusable across the suite's eighteen submodules, and themeable by a site that wants the automation UI to match its admin design.

It is a hard dependency of the main `flowdrop` module, so it is present on any FlowDrop site rather than being an optional extra. Components observed include pills, badges, progress bars, action links, grids, page headers, detail sections, data viewers, plugin selectors and a job timeline.

**One environment caveat worth passing on.** These components are discovered by anything that enumerates SDC. On the review install, with **Canvas** also enabled, Canvas's `ComponentMetadataRequirementsChecker` ran over them and tripped an assertion, fataling the container build (see the `canvas_field_component` notes). FlowDrop itself was unaffected once Canvas was removed. Nothing here is wrong; it is worth knowing if a site runs both.

---

- Render FlowDrop's dashboard from components.
- Keep admin UI consistent across the suite.
- Theme the automation UI to match a site.
- Reuse a status badge across screens.
- Show a job timeline component.
- Display a progress bar for a run.
- Use a plugin selector component.
- Lay out a detail section consistently.
- Render a data viewer for node output.
- Build a new FlowDrop screen from existing components.
- Override a component in a theme.
- Understand FlowDrop's admin markup.
- Diagnose a container build that enumerates SDC.
- Check for Canvas interaction on the same site.
- Extend the suite with a matching UI.