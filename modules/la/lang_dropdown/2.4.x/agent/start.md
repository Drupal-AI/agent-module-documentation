# lang_dropdown — agent index

Language Switcher Dropdown renders core's language switcher as a `<select>` dropdown.
It ships one block plugin (`language_dropdown_block`, derived per language type) and no
admin settings page — you place and configure the block through core's Block layout UI.
Depends only on core `language`.

- **Place & configure the block, settings keys, config entity** → [configure/lang_dropdown.md](configure/lang_dropdown.md)
- **The block plugin id, derivatives, widget/display option values** → [plugins/lang_dropdown.md](plugins/lang_dropdown.md)

Quick facts:
- Block plugin id: `language_dropdown_block` (deriver adds `:language_interface`, etc.).
- Configure route (`configure` in info.yml): `block.admin_display` (Block layout).
- Each placed block is a `block.block.{id}` config entity; settings live under `settings:`.
- Output type key `widget`: 0 select, 1 msDropdown, 2 Chosen, 3 ddSlick.
- Label format key `display`: 0 translated-current, 1 native, 2 langcode, 3 translated-target.
- No permissions, no Drush commands, no plugin types defined. Config schema: yes.
