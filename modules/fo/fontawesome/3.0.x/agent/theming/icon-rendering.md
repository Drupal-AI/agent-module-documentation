# Icon field & theming

## Field plugins
- Field type `fontawesome_icon` (`src/Plugin/Field/FieldType/FontAwesomeIcon.php`) — stores
  `icon_name`, serialized `settings`, and `style`.
- Widget `fontawesome_icon_widget` — autocomplete icon picker + advanced per-icon settings
  (size, rotate, flip, animation, power transforms, mask, duotone) gated by the
  `access fontawesome additional settings` permission.
- Formatter `fontawesome_icon_formatter` — renders the icon; setting `layers` (bool) prints
  multi-value fields as stacked FA layers.

## Theme hooks / templates
- `fontawesomeicon` → `templates/fontawesomeicon.html.twig`. Variables: `tag`, `iconset`,
  `icon`/`name`, `style`, `settings`, `transforms`, `mask`, `css`. Emits
  `<{tag} class="{iconset} {style} {name} {settings}" data-fa-transform data-fa-mask style>`.
- `fontawesomeicons` → `templates/fontawesomeicons.html.twig`. Variables: `icons`, `layers`;
  wraps in `.fa-layers.fa-fw` when `layers` is set.

Override either template in your theme to change the markup.
