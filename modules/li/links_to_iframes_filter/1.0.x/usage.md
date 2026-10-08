<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Links to Iframes Filter provides a text filter that replaces configured links with iframe embeds.

---

Links to Iframes Filter **replaces configured links with iframe embeds** — a text-format filter that, using an
admin-managed mapping of link → iframe markup, swaps matching links in processed text for the corresponding iframe
(e.g. turn a known video URL into its embed). It depends on core Filter and provides its own permissions.

Use it to auto-embed known links. It is a content-display/filter feature, and its trust model is admin-curated:
the iframe markup comes from an **admin-configured mapping** (not from arbitrary user-supplied URLs), and matching
is limited to the configured links. Security notes: because the mapping's **iframe markup is admin-defined and
rendered into pages**, restrict who can edit the mappings (its permission) to trusted users, and be aware iframes
embed third-party content (privacy/clickjacking considerations); also control which roles have the **text format**
that includes this filter. It has no access-control role beyond its permission. Configure the link→iframe
mappings.

---

- Replace configured links with iframes.
- Use an admin-managed link→iframe mapping.
- Auto-embed known links.
- Depend on core Filter + provide permissions.
- Serve content display/filtering.
- Match only configured links.
- Take iframe markup from ADMIN config (not arbitrary user URLs).
- Restrict who edits the mappings (admin-defined markup is rendered).
- Control which roles have the text format + mind iframe privacy/clickjacking.
- Have no access-control role beyond permission.
- Configure the link→iframe mappings.
- Handle link→iframe replacement.
- Embed links.
- Configure the mappings.
- Swap links.
- Handle the filter.
- Render iframes.
- Map links.
- Restrict the config.
- Provide link-to-iframe filtering.
