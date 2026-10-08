<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Wayback Filter fights link rot: on nodes older than a configurable number of years it adds Internet Archive Wayback Machine links to the outbound links in the content, pointing at a snapshot near the node's creation date.
---
It provides a text-format filter plugin (`wayback_filter`) that, when a full node is being viewed, looks up the node's `created` timestamp, and if the node is old enough regex-scans the body for `<a href>` links. For each `http(s)` link (skipping existing `web.archive.org` links) it builds `https://web.archive.org/web/<YmdHis>/<original-url>` and either appends a small icon link after the original (`append` mode) or rewrites the original link's href to the Wayback URL (`replace` mode). A companion `hook_preprocess_node` does the same for configured **link fields** (experimental), building Wayback links via `Url::fromUri()`. The icon, hover title, behaviour mode and age threshold are set at `/admin/config/content/wayback_filter`.

Security posture: the filter does **not** fetch any URL server-side — it never makes an outbound HTTP request; it only string-builds `web.archive.org` URLs from links already present in the (already text-filtered) content, so there is no SSRF surface. The node-age query uses `->condition('nid', $arg[1])` with the value passed as a bound parameter (not concatenated SQL). Output XSS risk is low: the URL captured by the `href="([^"]*)"` regex cannot contain a quote, and the injected icon/title strings come from admin-controlled config (settings form requires `administer site configuration`); the filter's output is returned as a `FilterProcessResult` and should be ordered late in the text-format pipeline. Setup: configure the settings form, then enable "Wayback Filter" on a text format and place it near the end of the filter order.
---
- Add Wayback links to outbound links on old articles.
- Append an archive icon after each link in aged nodes.
- Replace original links with Wayback snapshots (replace mode).
- Set the age threshold (years) before Wayback links appear.
- Show Wayback links on all nodes by setting the threshold to 0.
- Choose the icon/emoji used for the Wayback link (e.g. 🏛️).
- Set the hover title text for Wayback links.
- Enable the filter on a specific text format.
- Order the filter late in the text-format processing pipeline.
- Style Wayback links via the `.wayback-link` CSS class.
- Apply Wayback links to configured link fields (experimental).
- List link-field machine names to process on the settings form.
- Snapshot links near each node's original creation date.
- Skip links that already point at web.archive.org.
- Preserve original link text while swapping the href (replace mode).
- Combine with the External Links module (with CSS to hide extra icons).
- Mitigate link rot for a long-lived content archive.
- Keep new content untouched while archiving old content's links.
- Restrict settings changes to site-configuration admins.
- Apply only in the `full` node view mode.
