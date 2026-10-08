<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
D2 renders SVG diagrams from D2, a text-based declarative diagram language, by driving the d2 command-line binary.

---

D2: Declarative Diagramming turns D2 markup (for example `Alice -> Bob`) into an SVG image. It ships a small helper class, `Drupal\d2\D2Helper`, that wraps the `consensus/php-d2` library: the library locates the `d2` executable in the Composer vendor directory and runs it through Symfony Process, streaming your diagram source in on STDIN and reading the SVG back from STDOUT. `D2Helper::getSvg()` caches results in the default cache bin keyed by a SHA-256 of the input (recommended for anything rendered repeatedly), while the underlying `D2::generateSvg()` produces an uncached SVG. Modules can append extra CLI flags (such as `--sketch`) by implementing `hook_d2_command_options()`. A `view d2 diagram errors` permission controls whether a failed render surfaces the d2 CLI error to the current user or silently returns an empty string. The optional `d2_filter` submodule exposes this as a text-format filter so editors can embed diagrams inline using `[d2]...[/d2]` blocks. The module requires the `d2` Go binary to be installed on the server; the README documents a Composer-based helper for deploying it.

---

- Render an SVG diagram from D2 diagram syntax.
- Embed inline diagrams in body text with `[d2]...[/d2]` blocks (via the `d2_filter` submodule).
- Add a "D2 Filter" to any text format and pick which roles may use that format.
- Generate architecture, sequence, flow, and entity-relationship diagrams as SVG.
- Produce diagrams from content stored as plain text rather than uploaded images.
- Call `(new D2Helper())->getSvg($d2_input)` from custom code to render a cached diagram.
- Call `(new D2Helper())->getSvg($d2_input, $d2_options)` to pass per-call CLI options.
- Call `(new \Consensus\PhpD2\D2())->generateSvg($d2_input)` for an uncached, direct render.
- Cache expensive renders automatically, keyed by a hash of the diagram source.
- Reuse a cached SVG on repeated views instead of re-running the CLI each time.
- Add global d2 CLI flags (e.g. `--sketch`, themes, layout engine) via `hook_d2_command_options()`.
- Let developers render diagrams inside blocks, fields, or custom render arrays.
- Show d2 CLI error output to trusted users while hiding it from everyone else.
- Grant "View D2 diagram errors" to editors debugging broken diagram source.
- Keep diagram source in version control or content and regenerate the image on demand.
- Generate diagrams during content display without an in-browser JavaScript renderer.
- Standardize on a text-based diagram format instead of binary drawing files.
- Document systems and workflows directly inside node content.
- Provide a lightweight alternative/counterpart to MermaidJS-based diagramming.
- Deploy the `d2` binary alongside Drupal via the Composer helper described in the README.
