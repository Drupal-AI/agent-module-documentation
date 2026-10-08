# Configuration

All of this module's settings are appearance and licensing options for the hosted
accessibility widget — the toolbar's actual features are controlled remotely by
the vendor and your plan.

## Open the settings form

1. Log in as a user with the **All in One Accessibility settings** permission.
2. Go to **Configuration → Development → All in One Accessibility**, or navigate
   directly to `/admin/config/development/all-in-one-accessibility/ada_compliance`.

Your choices are saved into the `all_in_one_accessibility.userid.settings`
configuration object. Note there is no default config shipped, so nothing is stored
until you save the form once.

## Licence and content

- **Licence token** (`userid`) — paste the token you received from Skynet
  Technologies to activate the paid widget. Leave it blank to run the free
  version. Swap this value when moving from a trial to a paid plan.
- **Accessibility statement link** (`statement_link`) — the URL of your site's
  accessibility statement page, which the widget can link to.

## Appearance

- **Colour** (`colorcode`) — the widget's brand colour, entered as a hex value, so
  the floating button matches your theme.
- **Position** (`position`) — which corner the button sits in. The default is
  **bottom right**; other choices are bottom left, top right, and top left. Pick a
  corner that won't collide with an existing chat or cookie widget.
- **Widget size** (`widget_size`) — the button size (for example a regular size or
  an oversize button).
- **Icon type** (`aioa_icon_type`) and **icon size** (`aioa_icon_size`) — the
  icon style shown on the button and how large it is.

## Custom size and position

For finer control than the presets:

- **Custom size** toggles (`is_widget_custom_size`, and a separate mobile toggle)
  let you specify your own icon size values (`widget_icon_size_custom`, plus a
  mobile variant) instead of the preset sizes.
- **Custom position** (`is_widget_custom_position`) — when enabled, the button is
  placed by exact pixel offsets (**left**, **right**, **top**, **bottom**) rather
  than by a fixed corner. Use this to nudge the widget away from other floating
  elements.

## Save

Click **Save configuration**. The saved values are encoded into the external
widget's script URL and the toolbar reloads with your settings on the next page
view — it's embedded on every page automatically, so there's no block to place.
