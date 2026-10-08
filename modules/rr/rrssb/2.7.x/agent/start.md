# RRSSB (Responsive Social Share Buttons) — agent index

Responsive social **share/follow** buttons, configured as reusable **button sets** and rendered via
a block, a Views field, or per content type. Icons/CSS/JS come from the external `rrssb/rrssb-plus`
library (a Composer dependency). No field type — buttons are render output.

- **Button sets: the `rrssb_button_set` config entity, its keys, the collection UI, per-node-type
  attachment** → [configure/button-sets.md](configure/button-sets.md)
- **Render buttons: the `rrssb_block` block, the `rrssb_buttons` Views field, `rrssb_get_buttons()`,
  `[rrssb:*]` tokens** → [api/render-buttons.md](api/render-buttons.md)
- **Add/alter buttons from your own module** → [hooks/buttons.md](hooks/buttons.md)
- **Drush command to regenerate library CSS** → [drush/gen-css.md](drush/gen-css.md)

Key facts: config entity type `rrssb_button_set` (prefix `rrssb.button_set`, one `default` set ships
on install); admin at `/admin/config/content/rrssb`; permission `administer rrssb`. Per-content-type
attachment is a third-party setting `node.type.<bundle>` → `third_party_settings.rrssb.button_set`.
