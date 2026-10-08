<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
D2: Text Filter adds a text-format filter that turns `[d2]...[/d2]` blocks in content into inline SVG diagrams.

---

D2: Text Filter (`d2_filter`) is a submodule of D2: Declarative Diagramming. It registers a single filter plugin, `filter_d2` ("D2 Filter"), of type `TYPE_TRANSFORM_IRREVERSIBLE` with weight `-10`. When applied to a text format, the filter scans processed text for `[d2]...[/d2]` blocks and replaces each block's contents with an SVG produced by the parent module's `Drupal\d2\D2Helper::getSvg()` (which caches results and shells out to the `d2` CLI binary). Its filter tips show editors a short D2 example. The submodule depends on `d2:d2` and has no configuration of its own — you enable it, then add "D2 Filter" to the desired text format(s) under Administration > Configuration > Content authoring > Text formats and editors, and control who may use those formats through the standard text-format permissions.

---

- Let content editors embed diagrams inline with `[d2]...[/d2]` blocks.
- Add "D2 Filter" to a Full HTML, Basic HTML, or custom text format.
- Render sequence, flow, and architecture diagrams straight from body text.
- Keep diagram source in the content and regenerate the SVG on render.
- Reuse the parent module's caching so repeated views skip re-running the CLI.
- Choose which roles can author diagrams by assigning the enabling text format.
- Show editors quick D2 syntax help via the filter's tips (short and long).
- Combine D2 diagrams with other filters on the same text format.
- Document workflows or data models directly inside nodes, comments, or blocks.
- Avoid uploading static diagram images by generating them from markup.
- Provide inline diagramming without an in-browser JavaScript renderer.
- Order the filter (weight -10) to run before most other text filters.
- Enable diagram authoring per text format rather than site-wide.
- Support multiple `[d2]` blocks within a single piece of content.
