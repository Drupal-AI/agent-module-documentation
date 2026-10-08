<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Display Mode Guidelines lets site builders attach free-text usage guidelines to individual display modes (view modes and form modes) and to the *creation* of new display modes for an entity type, shown as warning messages on the relevant Field UI forms to curb uncontrolled proliferation of display modes.

---

The module (depends on `field_ui`) works entirely through Field UI form alters and a settings form. Per-display-mode guidelines are stored as a `dmg` third-party setting on each `entity_view_mode` / `entity_form_mode` config entity: `hook_form_alter` adds a required `Configuration Guidelines` rich-text field to the mode add/edit forms and an `#entity_builders` callback saves it, while the display (Manage display) edit forms render the stored guideline as a `messages--warning` block through `Xss::filterAdmin()`. Entity-type-level *creation* guidelines live in `dmg.settings` (a config object with `view` / `form` sequences of `{entity_type_id, guidelines}`) and are edited via `SettingsForm` at `/admin/structure/display-modes/{type}/manage/{entity_type_id}/guidelines` (route `dmg.settings`, gated by `administer site configuration`); "Set creation guidelines" action links appear on the view/form mode collection pages. Those creation guidelines then render as a warning at the top of the "add display mode" form for the matching entity type. A `EntityDisplayModeListBuilder` overrides core's list builder to add a "Guidelines" column. All guideline output is admin-XSS-filtered; input is only editable by users who can administer display modes / site configuration. There are no permissions of its own and no Drush.

---

- Show editors a warning describing how a specific view mode should be used.
- Show editors a warning describing how a specific form mode should be used.
- Display creation guidelines before someone adds a *new* view mode for an entity type.
- Display creation guidelines before someone adds a *new* form mode for an entity type.
- Discourage uncontrolled proliferation of one-off display modes.
- Document the intended purpose of a "Teaser" or "Card" view mode inline.
- Give a design-system team a place to record display-mode conventions.
- Add a "Guidelines" column to the view/form mode admin listing for at-a-glance context.
- Record naming or reuse rules for display modes next to where they are created.
- Provide governance guidance without a separate wiki or external doc.
- Set per-entity-type creation guidance (e.g. stricter rules for `node` than `media`).
- Use rich text (admin-filtered HTML) to format guideline messages with links and emphasis.
- Onboard new site builders with contextual display-mode instructions.
- Remind editors which display mode maps to which frontend template.
- Keep guideline text in config so it ships with configuration exports.
- Warn against creating redundant display modes that duplicate existing ones.
- Centralize editorial-experience conventions for display modes in one module.
- Surface guidance exactly at the moment of display-mode creation/editing.
