<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Read time displays an estimated "X min read" line on nodes, calculated as the word count of chosen text fields divided by an assumed words-per-minute and shown as a placeable pseudo-field.

---

Configuration is per content type: a "Read time" tab on each node type's edit form lets you enable the feature, pick which text fields (and paragraph reference fields) are counted, set the words-per-minute divisor (default 225), choose a format (hours & minutes or minutes only, in short or long wording), and set a display template with a `:read_time` token. Enabling a type exposes a `read_time` pseudo-field you position at Manage Display, per view mode, so the estimate can appear on full nodes, teasers and listings consistently. The value is computed by stripping tags from the selected fields and dividing `str_word_count` by the words-per-minute, then cached in a dedicated `read_time` database table and recomputed whenever the node is inserted or updated. Because it is cached, changing the words-per-minute or the counted fields does not retouch already-saved nodes until each is re-saved. The module has no global settings page, defines no permissions or drush commands, and requires only core's node module (with optional support for Paragraphs).

---

- Show a "5 min read" line on articles.
- Set reader expectations before they start.
- Help readers decide what to read now versus save.
- Display reading time in a teaser view mode.
- Add reading time to a content listing.
- Configure the assumed reading speed per content type.
- Count only the body field toward the estimate.
- Include additional text fields in the estimate.
- Count text inside referenced Paragraphs.
- Show reading time as "1 hour, 5 minutes".
- Show reading time as compact "65 mins".
- Add a custom label around the number via the display template.
- Position the read-time field with Manage Display.
- Show reading time only on the full node, not teasers.
- Give a blog a familiar reading-time convention.
- Display reading time per content type.
- Show read time in a card component.
- Support a documentation site's article navigation.
- Add reading time to search-result rows.
- Signal article length consistently across templates.
- Improve a magazine-style article index.
- Refresh a node's estimate by re-saving it after tuning the speed.
