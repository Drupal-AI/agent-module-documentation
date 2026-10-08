# Configuration

Setting up Flyout Menu is two steps: adjust the settings form, then place the two blocks
where you want them.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → User interface → Flyout Menu**, or navigate directly to
   `/admin/config/user-interface/flyout-menu` (route `flyout_menu.settings`).

This form controls the flyout's **behaviour and appearance** — how the panel opens and
how it looks. The module ships sensible defaults, so you can leave the form untouched
and still get a working flyout; adjust it when you want to change the default styling or
behaviour. Save the form when you are done.

## Place the two blocks

Flyout Menu does its real work through two blocks, placed from **Structure → Block
layout**:

1. **Flyout menu (toggle)** — the open/close control. Place it in the region where you
   want visitors to tap to open the menu, typically the site header.
2. **Flyout menu (panel)** — the sliding panel itself. Place it in a region and give it
   the content you want inside the drawer (for example your main menu).

Because the toggle and the panel are separate blocks, you can position them
independently — the toggle in the header and the panel content elsewhere — and you can
place the pattern in more than one region if you need it.

Each block follows the usual core block settings, so you can restrict it by page, role,
or content type using the standard **Visibility** conditions on the block's
configuration.

## Theming (optional)

The flyout is styled by the module's own front‑end library, built from SCSS. If you want
custom markup, the module's **templates are overridable** — copy the relevant template
into your theme and adjust it there. This is why the project describes itself as built
with theme developers in mind: the defaults work immediately, but nothing stops you from
restyling the panel to match your design.
