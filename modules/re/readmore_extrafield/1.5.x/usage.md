<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Read More Extra Field turns the "Read more" link into an **extra field**, so it can be positioned and reordered in Manage Display like any other field instead of being fixed inside the node links.

---

Core renders "Read more" as part of the node links — the group that also carries comment and contextual links — and that group has a fixed position at the bottom of the rendered entity. A design that wants the link directly under the summary, above a set of tags, or inside a card's footer therefore requires a template override, and the override has to reproduce link-rendering logic that core changes between versions. This module reframes the link as an extra field: it appears in Manage Display for each view mode, can be dragged into position, and can be hidden per view mode without touching a template. `templates/readmore-extrafield.html.twig` gives themers a hook of their own. The module is four files, with core `field` as its only dependency and a core range of `^9 || ^10 || ^11`. Because it is a display concern only, it changes nothing about the node or its links — the core "Read more" remains available if you would rather use both.

---

- Move the Read more link above other fields.
- Position Read more inside a card layout.
- Hide Read more on selected view modes.
- Reorder Read more in Manage Display.
- Avoid a template override for link placement.
- Put Read more directly under the teaser text.
- Theme the link with its own template.
- Keep placement in exportable display config.
- Match a design comp's teaser layout.
- Show Read more above tags.
- Give each view mode its own link position.
- Reduce theme code for a common need.
- Style the link independently of node links.
- Support a card-based listing design.
- Configure placement without a developer.
- Keep core's node links untouched.
- Add Read more to a custom view mode.
- Improve teaser scanability.
