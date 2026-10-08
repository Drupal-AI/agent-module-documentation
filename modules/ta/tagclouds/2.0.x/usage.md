TagClouds generates weighted "tag cloud" pages and blocks from your taxonomy terms, sizing each term by how many things are tagged with it. It is a lightweight, out-of-the-box fork of Tagadelic with no database of its own.

---

The module reads taxonomy term usage and assigns each term a **weight level** (a CSS class `level1`…`levelN`) based on how often it is used, so popular terms render larger. Global behaviour is set on one settings form at `/admin/config/content/tagclouds` (route `tagclouds.admin_page`, config object `tagclouds.settings`): `sort_order` (title/count/random, asc/desc), `display_type` (`style` = sized tags, or `count` = show counts), `display_node_link`, `display_more_link`, `page_amount` (tags per page, 0 = all), `levels` (number of size levels, default 6), and `language_separation`. It exposes dynamic **pages** — `/tagclouds/list/{vocabulary}` (term list with descriptions) and `/tagclouds/chunk/{vocabulary}` (the cloud) — plus a legacy `/tagclouds` route, all gated by `access content`. It also provides a **derived block** (`tagclouds_block`, one derivative per vocabulary via a deriver) whose per-block settings let you choose the vocabulary machine name, number of tags, and a sort order that can override the global default. Two services do the work: `tagclouds.tag` (`TagService`) fetches and sorts weighted terms, and `tagclouds.cloud_builder` (`CloudBuilder`) renders them. The settings page is protected by the `administer tagclouds settings` permission. Theme hooks `tagclouds_list_box` and `tagclouds_weighted` (plus templates) and a CSS library (`tagclouds/clouds`) control the look; it also integrates with multilingual (i18n/content_translation) to optionally separate tags per language.

---

- Add a sidebar tag-cloud block for your "Tags" vocabulary sized by popularity.
- Show a full-page cloud of all terms in a vocabulary at `/tagclouds/chunk/tags`.
- List a vocabulary's terms with descriptions at `/tagclouds/list/{vocabulary}`.
- Size popular tags larger and rare tags smaller using weight levels.
- Configure the number of size levels (e.g. 6, 9 or 12) for finer or coarser clouds.
- Sort tags alphabetically, by usage count, or randomly (asc/desc).
- Switch a cloud between "styled" sizing and showing the raw usage count per tag.
- Limit how many tags appear on a page or in a block (0 = show all).
- Place separate tag-cloud blocks for different vocabularies on one page.
- Override the global sort order for an individual block.
- Link a tag directly to the single node when only one item uses it.
- Add a "more tags" link when not all tags fit.
- Build a folksonomy navigation cloud for a blog or news site.
- Provide a topic cloud that grows organically as content is tagged.
- Style size levels with your own CSS by targeting the `levelN` classes.
- Separate tag clouds per language on a multilingual site.
- Restrict who can change tag-cloud settings via the administer tagclouds settings permission.
- Expose a cloud of product categories on a commerce site.
- Give visitors a visual index of the most-discussed subjects.
- Render a cloud with the `tagclouds_weighted` theme hook in a custom template.
- Use `tagclouds.tag` service to fetch weighted terms programmatically.
- Drive a cloud from any vocabulary by machine name via block config.
- Create an at-a-glance popularity view of taxonomy terms without writing SQL.
