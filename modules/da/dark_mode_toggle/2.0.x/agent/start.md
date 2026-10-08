# Dark Mode Toggle — agent index

A front-end theme switcher. Provides one **Block plugin** (`dark_mode_toggle`) that renders
Light / Dark / System buttons. Client JS toggles `data-dmt-mode` (`dark`|`light`) and
`data-dmt-source` (`user`|`system`) on `<html>` and persists the choice in `localStorage`
key `dmt-mode`. **No settings form, no configure route, no permissions, no Drush, no config
schema.** Its only persistent state is the block placement. The theme's CSS does the actual
restyling based on the attribute.

- **Place the toggle / the attribute + localStorage contract for theme CSS** →
  [configure/place-block.md](configure/place-block.md)
- **Override the button markup, the `dark_mode_toggle` theme hook & template** →
  [theming/template.md](theming/template.md)

Key facts: block plugin id `dark_mode_toggle` (admin label "Dark Mode Toggle"); theme hook
`dark_mode_toggle` → `templates/dark-mode-toggle.html.twig`; libraries
`dark_mode_toggle/dark-mode-toggle` (+ `dark-mode-toggle.init`, header). Buttons carry
`data-dmt-preference="light|dark|system"`; container carries `data-dmt-container`.
