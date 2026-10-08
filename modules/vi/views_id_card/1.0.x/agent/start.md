<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Badge (views_id_card) — agent start

**What**: Views style plugin (`@ViewsStyle id="badge"`) rendering results as ID badges.
Project `views_id_card`; the info.yml machine name is **`badge`** (that is the plugin id and
the name Drupal enables). Depends on `views`.

## Set up
1. Enable: `drush en badge -y` (project dir on disk is `views_id_card`).
2. Edit a view, add the fields you want (photo, names, category, badge image).
3. **Format → Badge**, then in the format settings map each slot:
   `id_field`, `person_image_field`, `first_name_field`, `last_name_field`,
   `category_field`, `badge_image_field` (all are `select` lists of the view's fields).

## Key facts
- No routes, no permissions, no config entities of its own. All config lives in the view.
- Style class: `Drupal\badge\Plugin\views\style\BadgeStyle` (`usesFields=TRUE`,
  `usesRowPlugin=FALSE`).
- Preprocess: `template_preprocess_views_view_badge()` in `badge.theme.inc` builds the
  per-row `content` array and attaches library `badge/badge`.
- Theme: override `views-view-badge.html.twig`; restyle via `badge.css`.
- A default **Badge** view is installed as a starting point.

## Notes
- Output is rendered Views field output; no additional input is introduced by the module.
