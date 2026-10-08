<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Charts Twig exposes a single `chart()` Twig function that builds the Charts module's render element, so a chart can be produced directly in a template.

---

The Charts module normally renders through Views or a render array assembled in PHP. That is the right shape for a chart driven by site content, and the wrong shape when the data is already in the template — a component receiving a prepared array, a Twig-based design system, or a one-off visualisation in a node template where adding a preprocess function would be the only reason to write PHP at all.

The implementation is one class, `ChartsTwig`, registering `new TwigFunction('chart', …)` against the element info manager. Everything else — chart types, libraries, styling, the underlying JS — comes from Charts itself, which must be version 5 or later. What you get is the same render element you would have built in PHP, reachable from Twig.

The natural caution with any Twig function that takes structured input is where the data comes from. Values passed to `chart()` end up in a render array and, from there, in JavaScript configuration; keep the data on the server side of the boundary and do not pass anything user-supplied through it without deciding what escaping applies. For content-driven charts, Views plus the Charts module remains the better route — this is for the cases where the template already holds the numbers.

---

- Render a chart directly from a Twig template.
- Visualise data a component already holds.
- Add a chart to a node template without a preprocess function.
- Build a chart inside a design-system component.
- Chart values computed in a Twig loop.
- Produce a chart in a custom block template.
- Use the Charts module's libraries from Twig.
- Prototype a visualisation quickly in a theme.
- Chart data supplied by a paragraph's fields.
- Render several charts in one template.
- Keep chart markup alongside the rest of a component.
- Avoid writing PHP for a single one-off chart.
- Reuse a site's configured chart styling from a template.
- Decide between this and a Views-driven chart.
- Chart data assembled by a Twig macro.
- Add a visualisation to a paragraph template.
