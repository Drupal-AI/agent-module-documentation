Enhanced Button Link extends Drupal core's Link field with a widget and formatter that render links as Bootstrap buttons, with configurable style (btn class), size, disabled status and target — optionally overridable per link.

---

The module adds a formatter, `enhanced_button_link_formatter` ("Enhanced Button Link", extends core `LinkFormatter`), and a widget, `enhanced_button_link_widget` ("Enhanced Button Link", extends core `LinkWidget`), for `link` fields. The formatter renders each link as an `<a>` with Bootstrap classes (`btn` + a chosen `btn-*` type, plus `btn-lg`/`btn-sm` for size, `disabled` + `aria-disabled` for disabled status, and `target="_blank"` for new-tab), and supports token replacement in the link title. A global settings form at `/admin/config/content/enhanced-button-link` (route `enhanced_button_link.admin_settings`, permission `administer site configuration`) stores config `enhanced_button_link.settings`: `button_link_styles` (a map of Bootstrap class → label, editable as `class|Label` lines) and four `override_*` toggles (type/size/status/target). When an override toggle is on, the widget exposes the matching per-link select so editors can override the formatter's default for that individual link; otherwise the formatter's fixed setting is used. `EnhancedButtonLinkHelper` parses/serialises the styles textarea and validates each entry — CSS classes are checked with `Html::cleanCssIdentifier()` and labels with `Html::escape()`, rejecting values that change under sanitisation. A small library (`enhanced_button_link.field`) supports optional inline button layout. Requires core Link and a Bootstrap-based theme for correct appearance. No permissions or config schema of its own; config is invalidated via the `enhanced_button_link__field_formatter` cache tag.

---

- Render a Link field as a Bootstrap primary/secondary/etc. button.
- Offer editors a curated list of button styles (btn classes) to choose from.
- Set a default button style, size, status and target on the field's display.
- Let editors override the button style per individual link when enabled.
- Choose button size (normal / large / small) per link or as a default.
- Mark a button as disabled (adds `disabled` + `aria-disabled`, `role="button"`).
- Open a button link in a new tab (`target="_blank"`) or the same window.
- Use outline button variants (btn-outline-*) from the default styles list.
- Restrict which override options editors can change via the settings form toggles.
- Add custom Bootstrap button classes by editing the `class|Label` styles list.
- Use tokens in the button link title (entity token replacement).
- Display multiple button links inline via the bundled field library.
- Build call-to-action buttons from a standard Link field without custom code.
- Keep button styling consistent across content by centralising the styles list.
- Validate admin-entered button classes/labels against unsafe characters.
- Extend available styles by defining CSS classes in the theme and adding them to config.
- Provide accessible disabled buttons for unavailable actions.
- Reuse core Link field behaviour (URL validation, internal/external links) with button rendering.
- Theme inline button layout by overriding the `enhanced_button_link.field` library.
- Give marketers control of button appearance without touching templates.
