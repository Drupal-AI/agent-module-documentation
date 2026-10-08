# Configuration

## Global settings — `/admin/config/content/enhanced-button-link`
Route `enhanced_button_link.admin_settings` (`_permission: 'administer site configuration'`),
form `SettingsForm`, config object `enhanced_button_link.settings`. Defaults in
`config/install/enhanced_button_link.settings.yml`:
- `button_link_styles` — map of Bootstrap class → label (defaults: `btn-primary`…`btn-outline-dark`).
  Edited in the form as one `class|Label` pair per line. `EnhancedButtonLinkHelper::parseConfigsFromValue()`
  validates: class must survive `Html::cleanCssIdentifier()` unchanged, label must survive
  `Html::escape()` unchanged, else a form error.
- `override_type`, `override_size`, `override_status`, `override_target` — booleans (defaults
  1/1/0/1). Each toggles whether the widget exposes that per-link override select.

Submit invalidates cache tag `enhanced_button_link__field_formatter`.

## Widget — `enhanced_button_link_widget`
`src/Plugin/Field/FieldWidget/EnhancedButtonLinkWidget.php` (extends core `LinkWidget`, field type
`link`). Adds a "Button Link Options" details element containing `type` / `size` / `status` /
`target` selects; each is `#access`-gated by the matching `override_*` config flag (the whole
details area is hidden if none are enabled). Values are stored in the link item's `options` array.

## Formatter — `enhanced_button_link_formatter`
`src/Plugin/Field/FieldFormatter/EnhancedButtonLinkFormatter.php` (extends core `LinkFormatter`).
`defaultSettings()`: `type` (`btn-primary`), `size` (`normal`), `status` (`enabled`),
`inline_buttons` (0), `target` (`same_window`). `settingsForm()` hides core link options
(`trim_length`, `url_only`, `url_plain`, `rel`) and adds required Type/Size/Status/Target selects +
an "inline buttons" checkbox.

`viewElements()` per link: chooses each attribute from the per-link `options` value when the
matching `override_*` flag is on and the option is set/non-default, else the formatter setting.
Builds classes `btn` + `<type>` (+ `btn-lg`/`btn-sm`), adds `disabled`/`aria-disabled`/`role=button`
when status is disabled, `target="_blank"` for new-tab. The link title is run through
`Token::replace()` with the entity as context. Attaches library
`enhanced_button_link/enhanced_button_link.field` and cache tag `enhanced_button_link__field_formatter`;
adds class `enhanced-button-link-inline` when inline buttons are enabled.

## Constants
`EnhancedButtonLinkInterface` defines the option values: `TYPE_DEFAULT`, `SIZE_DEFAULT|NORMAL|BIG|SMALL`,
`STATUS_DEFAULT|ENABLED|DISABLED`, `TARGET_DEFAULT|SAME_WINDOW|NEW_TAB`, `INLINE_BUTTONS`.
