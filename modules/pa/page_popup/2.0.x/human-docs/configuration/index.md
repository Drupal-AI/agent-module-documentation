# Configuration

Page popup is configured from a single admin page, where you add a popup message
and then adjust how and where it appears.

## Open the settings page

1. Log in as a user with the right permission (an administrator by default — the
   module ships its own permissions, set under **People → Permissions**).
2. Go to **Configuration → System → Page popup**, or navigate directly to
   `/admin/config/system/page_popup` (config route `page_popup.admin`).

## Add a popup message

On the configuration page, add a **popup message** entity — this holds the content
the visitor will see. Once the message exists, use the popup settings to adjust its
appearance and behavior.

## Style and behavior options

For each popup you can set:

- **Message text** — the content shown in the popup.
- **Text color** and **background color** — the popup's colors.
- **Font size** — the size of the message text.
- **Width** and **height** — the popup's dimensions.
- **Position** — where the popup appears on screen.
- **Popup delay** — how long to wait after the page loads before the popup shows.

You can also **disable** a popup message without deleting it, so a notice can be
switched off and back on as needed.

## Targeting pages

Configure which pages the popup appears on so it only shows where you intend — for
example a specific landing page or campaign page.

## Save

Save the configuration, then visit a targeted page as a visitor to confirm the
popup appears with the styling and delay you set.
