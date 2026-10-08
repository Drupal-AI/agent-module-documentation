Adds a "Buy Me a Coffee" donation button (block) and an optional site-wide floating support widget to a Drupal site, configured from a single settings form.

---

The Buy Me a Coffee module (`bmc`) wires the hosted Buy Me a Coffee platform into Drupal without any custom coding. An administrator enters their Buy Me a Coffee account username and customizes appearance (button text, font, cup/background colors, and widget message/position) on one config form at `/admin/config/bmc-configuration`. The module then renders the platform's official CDN scripts in two ways: a placeable **block** ("Buy Me a Coffee", plugin id `by_mee_coffee_block`) that outputs the donation button, and — when the widget is enabled — a **floating support widget** injected into the `<head>` of every non-admin page via `hook_page_attachments_alter()`. All donation processing happens on Buy Me a Coffee's own site; the module makes no server-side API calls and stores no payment data. Depends only on core `block`. Provides one restricted permission (`administer bmc`), a custom `bmc_color_picker` form element for swatch/custom-hex color selection, and a help page.

---

- Let site visitors tip or donate to a content creator without leaving your Drupal site (floating widget) or by clicking through to your Buy Me a Coffee page (button).
- Place a "Buy Me a Coffee" donation button in any theme region using the block system (Block layout UI).
- Add the donation button inside a specific view mode or layout via Layout Builder / block placement.
- Enable a floating support widget that appears bottom-right (or bottom-left) on every front-end page.
- Configure your Buy Me a Coffee account username once and have both the button and widget use it.
- Customize the button label text (up to 25 characters, e.g. "Support my work").
- Choose the button font from a preset list (Cookie, Lato, Arial, Comic, Inter, Bree, Poppins).
- Pick the coffee-cup color and button background color from preset swatches or a custom hex value using the built-in color picker.
- Set the floating widget's brand color, description text, and hover message.
- Align the floating widget to the Right or Left and fine-tune its side/bottom spacing in pixels.
- Keep the widget off admin pages automatically (it is suppressed on any path starting with `/admin`).
- Monetize a blog, podcast site, or portfolio with a low-friction "tip jar" call to action.
- Collect small donations for a non-profit or community project directly from the site.
- Give independent artists, musicians, or writers a fan-support channel embedded in their site.
- Restrict who can change donation settings by granting the `administer bmc` permission to trusted roles only.
- Show the donation button on selected pages only by using core block visibility conditions (paths, content types, roles).
- Temporarily switch off the floating widget (uncheck "Enable Widget") while keeping the button block in place, or vice versa.
- Preview and thank the module author, or test the integration, from the module's help page at `/admin/help/bmc`.
- Provide a consistent supporter call-to-action across the whole site while controlling its position and colors to match your theme.
- Avoid a third-party contrib payment stack when you only need a simple external donation link/widget.
