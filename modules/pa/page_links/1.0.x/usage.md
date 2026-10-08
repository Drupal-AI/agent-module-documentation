<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Page links surfaces the hyperlinks embedded in a Basic page's body directly on the node edit form, giving editors a compact "Page links" panel that lists each link, classifies it, and lets them act on it — without hunting through the WYSIWYG source.

---

The module implements `hook_form_node_page_edit_form_alter()` to add a collapsible "Page links [N]" group (in the form's advanced/sidebar area) whenever the body contains links. The `PageLinkService` (service id `page_links.service`) extracts anchors from the body HTML with a regex (`LINKS_PATTERN`), builds a themed table via `themeLinksTable()`, and classifies each URL as Local (no scheme, `L`) or Remote (has scheme, `R`) using `parse_url()`. Each row offers a delete control plus the resolved URL, and a submit action lets editors apply link changes back to the node. It targets the core `page` (Basic page) content type specifically, has no dependencies beyond core, defines no permissions (it rides the node edit form's own access), and adds no configuration UI or Drush commands.

---

- Give editors a quick inventory of every link in a Basic page's body.
- Distinguish internal (local) links from external (remote) links at a glance.
- Remove unwanted or broken links from a page without editing raw HTML.
- Show a link count badge so editors know how link-heavy a page is.
- Review outbound links before publishing for compliance/branding.
- Keep link management inside the node edit form's advanced sidebar.
- Audit a page's links during content cleanup or migration QA.
- Spot accidental external links that should be internal (or vice versa).
- Let non-technical editors manage links via a table UI instead of the source view.
- Speed up editorial review of link-heavy landing pages.
- Surface link data only when links exist (panel is hidden otherwise).
- Reuse the `page_links.service` extraction logic in custom code.
- Classify link types programmatically for reporting.
- Reduce reliance on the WYSIWYG "source" button for link edits.
- Help maintain link hygiene on long-lived Basic pages.
