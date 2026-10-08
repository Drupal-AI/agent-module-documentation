Node Link Report provides a per-node block that renders the node, extracts every anchor from the resulting HTML, and cURLs each unique link to flag broken, redirected, unpublished, skipped, and accessibility-problem links.

---

The module ships one block plugin, "Node Link Report" (`node_link_report_block`), that you place via Block layout and that only renders on node view, node edit, and/or node preview routes (per the admin settings) for users holding the `view node link report` permission. On render it renders the current node into HTML with a bogus view mode (so no page template runs), parses it with `DOMDocument`, dedupes the anchors, drops non-cURLable schemes (`mailto`, `tel`, `sms`, `im`) and self/skip-pattern URLs, then issues parallel HEAD requests with `curl_multi_*` (falling back to a full GET for 400/405/501/503). Links returning 200/301/302/304/307/308 are "good" (or "redirected" if they land elsewhere); internal failures are checked against the path/alias system to detect links to unpublished entities; everything else is "bad". A separate accessibility pass flags anchors with empty `href`, empty/undescriptive link text, or images missing meaningful `alt`. Results are cached in the default cache bin for 24 hours per node (tag `node_link_report` + `node:{nid}`) and invalidated on node save and on settings save; previews are never cached. Configuration lives at `/admin/config/content/node_link_report` (route `node_link_report.node_link_report_admin_form`, gated by `administer content`) and covers external-link checking, which report sections to show, a custom cURL user-agent, internal/skip domains, skip path patterns, and an alternate decoupled-frontend domain. Requires PHP's DOM extension (phpDom); depends on core `path_alias`. Note links are tested anonymously, so content not visible to anonymous users shows as broken.

---

- Surface broken outbound and internal links on a node without leaving the page.
- Give editors a link-health panel on the node edit form before publishing.
- Show a link report on node preview while drafting content.
- Detect links that point to unpublished nodes/terms instead of just marking them broken.
- Flag links that silently redirect elsewhere (non-trailing-slash redirects).
- Report accessibility issues: images used as links without meaningful alt text.
- Report accessibility issues: links whose text is empty or not descriptive.
- Provide an editor-facing accessibility guidance link next to flagged links.
- Optionally report "good" links too, to audit every link on a page.
- Optionally list skipped links (mailto/tel/sms and deliberately excluded ones).
- Enable or disable checking of external links site-wide.
- Restrict which roles can see the report via the `view node link report` permission.
- Set a custom User-Agent for the link-checking cURL requests.
- Treat additional domains (multi-domain sites) as internal so they are checked as internal links.
- Exempt specific external domains from processing (e.g. login-walled sites that falsely read as broken).
- Skip internal paths by pattern (e.g. `/node/*/edit`, `/user/*`) to reduce noise and load.
- Validate links against a separate decoupled/headless frontend domain.
- Cache reports for 24 hours to keep repeated cURL load down on high-traffic nodes.
- Place the report block in any region via Block layout.
- Combine with BigPipe so the (slow) cURL report streams in without blocking the page.
- Audit a single node's links on demand by visiting it with the block enabled.
