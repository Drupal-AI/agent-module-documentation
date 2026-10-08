<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Read More Extra Field turns the "Read more" link into an **extra field**, so it can be positioned and reordered in Manage Display like any other field, and it adds per-view-mode settings for the link's label, CSS classes, and `title`/`rel`/`target` attributes.

---

Core renders "Read more" as part of the node links group, which has a fixed position at the bottom of the rendered entity, so any other placement normally needs a template override. The 3.x line reframes the link as an `ExtraFieldDisplay` plugin built on the `extra_field` and `extra_field_plus` contrib modules (both hard dependencies, alongside core `field`). The plugin targets all node bundles (`node.*`) and appears in Manage Display for every view mode, where it can be dragged into position, hidden per view mode, and — unlike the 1.x version — configured. Its settings form exposes a link **Label**, extra **Link classes**, and **`title`**, **`rel`** and **`target`** attribute values; when the optional `token` module is enabled, the label, classes and title accept tokens (resolved against the host entity). The link always points at the node's canonical route and carries a `readmore-extrafield-link` class. Output is themed through `templates/readmore-extrafield.html.twig`, whose variables changed in 3.x (`title`, `url`, `attributes`, `entity`, `view_mode`) and which now offers a rich set of theme suggestions by view mode, entity type, bundle and entity id. Settings are stored in the view display config (schema `field.formatter.settings.extra_field_readmore_extrafield`) and export with `drush cex`.

---

- Move the Read more link above other fields in Manage Display.
- Position Read more inside a card layout.
- Hide Read more on selected view modes.
- Reorder Read more without a template override.
- Put Read more directly under the teaser text.
- Change the link label (e.g. "Continue reading").
- Use a token in the link label, so it reflects the node title.
- Add custom CSS classes to the Read more link.
- Set a `title` attribute for accessibility or tooltips.
- Open the link in a new tab via a `target` attribute.
- Set `rel="nofollow"` (or similar) on the link.
- Give each view mode its own link label and styling.
- Theme the link with its own template and per-view-mode suggestions.
- Keep placement and link settings in exportable display config.
- Match a design comp's teaser layout.
- Show Read more above tags.
- Style the link independently of core's node links.
- Support a card-based listing design.
- Configure placement and attributes without writing code.
- Keep core's node links untouched (both can appear).
- Add Read more to a custom view mode.
- Improve teaser scanability.
