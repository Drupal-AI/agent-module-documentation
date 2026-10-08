<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Badge (views_id_card)

Badge is a Views **style plugin** (`id: badge`) that lays out each view result as an ID
card / badge. In the style settings you map existing view fields onto six named slots — a
unique ID, a person image, first name, last name, category, and a badge image — and the
module renders them through the `views-view-badge.html.twig` template with an attached
CSS/JS library (`badge/badge`).

---

## Summary

The module (project `views_id_card`, machine name `badge`) adds one Views format called
**Badge**. It `usesFields` (you add fields to the view as normal) and does **not** use a row
plugin. `template_preprocess_views_view_badge()` reads the configured field names from the
style options and calls `$style->getField()` for each row to build a `content` array
(`id`, `person_image`, `first_name`, `last_name`, `category`, `badge_image`) passed to the
Twig template. A default "Badge" view ships to help you get started (see
`/admin/structure/views`). Output is whatever the mapped Views field handlers render — no
extra user input is introduced, so it inherits Views' normal field sanitization.

Configuration is entirely per-view: edit a view, set **Format → Badge**, then open the
format settings to choose which field feeds each badge slot. Theme it by overriding
`views-view-badge.html.twig` and the `badge.css` library.

---

## Use cases

- Display a directory of staff or members as photo ID badges.
- Build a conference attendee badge list from a content type with name + photo fields.
- Render a team roster where each card shows a person image, name, and role/category.
- Produce printable event badges backed by a view of registrations.
- Show a gallery of certification cards with a category label per card.
- Map an image field to `badge_image` to overlay an organization or event logo.
- Use taxonomy term reference as the `category` slot to group people by department.
- Combine with a contextual filter to render badges for a single event or group.
- Style badges responsively by overriding the shipped `badge.css`.
- Attach custom JS behaviour via the `badge/badge` library for interactive cards.
- Start from the bundled default "Badge" view and adapt its field set.
- Feed the `id` slot from the node ID to give each badge a stable anchor.
- Create a "wall of members" front-page block using a Badge-format view display.
- Present award recipients as decorative cards with photo and category.
- Swap the Twig template to output vCard-like markup for each badge.
- Drive a lanyard/print stylesheet from the same Badge view for on-site printing.
