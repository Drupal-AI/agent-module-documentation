<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Mode Guidelines — agent index

Attach usage guidelines to display modes (view/form modes) and to the *creation* of new display modes,
shown as warning messages on Field UI forms. Depends on `field_ui`. No permissions of its own, no Drush.
Guideline output is `Xss::filterAdmin()`-escaped; only display-mode / site-config admins can set it.

- **Where guidelines are stored & shown; the settings form/route; config schema** →
  [configure/guidelines.md](configure/guidelines.md)

Key facts:
- Per-display-mode guideline = a `dmg` **third-party setting** on each `entity_view_mode` /
  `entity_form_mode` config entity (added to the mode add/edit forms via `hook_form_alter` +
  `#entity_builders`).
- Entity-type **creation** guidelines live in `dmg.settings` (`view`/`form` sequences of
  `{entity_type_id, guidelines}`), edited at
  `/admin/structure/display-modes/{type}/manage/{entity_type_id}/guidelines` (route `dmg.settings`,
  `administer site configuration`).
- `EntityDisplayModeListBuilder` overrides core's list builder to add a "Guidelines" column + "Set
  creation guidelines" action links.
