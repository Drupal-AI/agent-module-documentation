# Configuration

All of Site Status Message's options live on one settings form.

## Open the settings form

1. Log in as a user with the **`administer site status message`** permission (an
   administrator by default).
2. Go to **Configuration → System → Site status message**, or navigate directly to
   `/admin/config/system/site-status-message`.

## The fields

- **Enable message** (`enable`) — the master on/off switch. Tick it to show the banner;
  untick it to clear the banner instantly without uninstalling the module.
- **Status message** (`message`) — the banner text itself, up to **256 characters**.
  When the **Token** module is installed the field supports tokens (a token-browser link
  is shown so you can pick from the available tokens). The text is passed through
  Drupal's XSS filter before it is rendered, so only safe markup survives — and since
  only administrators can set it, this keeps the banner safe from injected markup.
- **Read more page** (`showlink`) — tick to append an optional "read more" link after
  the message.
  - **More information page** (`link`) — an autocomplete field to pick the internal
    **node** the link should point to.
  - **More information link text** (`readmore`) — the text shown for that link.
- **Display options** (`display_options`) — where the banner appears:
  - **Public-facing pages** — show it to visitors only.
  - **Admin pages** — show it in the administrative area only.
  - **Both** — show it everywhere.

## Save

Click **Save configuration**. The banner is emitted at the top of every matching page
(via Drupal's `page_top` region). Beyond the display scope you choose, each banner is
also shown only to viewers who have the core **access content** permission, so it follows
the same basic visibility rule as ordinary site content.

## Turning it off later

To remove the banner, simply untick **Enable message** and save — there is no need to
uninstall the module.
