# Configuration

Shariff has one **global settings form** that controls how the buttons look and
which networks they offer. Both placements — the block and the per-node field —
read their defaults from this form, and the block can override them per instance.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Web services → Shariff**, or navigate directly to
   `/admin/config/services/shariff`.

The form saves to the `shariff.settings` config object, so you can export it and
deploy consistent share settings across environments.

## Services (which networks appear)

The **Services** section is a drag-and-drop table where you tick the networks you
want and drag them into the order the buttons should appear. Out of the box only
**Twitter** and **Facebook** are enabled. The full list of available services is:
Twitter, Facebook, LinkedIn, Pinterest, VK, Xing, WhatsApp, AddThis, Telegram,
Tumblr, Flattr, Diaspora, Reddit, StumbleUpon, Weibo, Flipboard, Pocket, Print,
Tencent Weibo, QZone, Threema, Mail, Info, and Buffer. Unchecked services are
dropped when you save, and the row order becomes the button order.

## Appearance

- **Theme** — the button color scheme: `colored` (default), `grey`, or `white`.
- **CSS variant** — which stylesheet loads: `complete` (includes Font Awesome
  icons, the default), `min` (minimal — use this when your theme already loads
  Font Awesome), or `naked` (no styling at all, so you can style the buttons
  entirely from your theme).
- **Button style** — `standard`, `icon`, or `icon-count`. The `icon-count`
  option shows share counts, which requires a working backend URL (see below).
- **Orientation** — `horizontal` (default) or `vertical`. Use vertical to stack
  the buttons in a narrow sidebar.

## Sharing details

- **Fixed URL** (`shariff_url`) — a canonical URL to share instead of the
  auto-detected page URL. Leave empty to share the current page.
- **Fixed title** (`shariff_title`) — a share title used by Twitter/WhatsApp
  instead of the auto-detected page title.
- **Twitter "via"** (`shariff_twitter_via`) — a Twitter screen name to attribute
  shared tweets to.
- **Media URL** (`shariff_media_url`) — an image URL for services such as
  Pinterest.
- **Mail options** — a mail target (`shariff_mail_url`, e.g. a `mailto:` link)
  plus a preset subject and body for the E-Mail share button.
- **Referrer tracking** (`shariff_referrer_track`) — a string appended to the
  shared URL; leave empty to disable.
- **Info button** — an Info URL (`shariff_info_url`) linking to an explanation of
  the Shariff privacy approach, with a display mode (`blank`, `popup`, or
  `self`).
- **Flattr** — optional Flattr category and user settings.

## Share counts and the backend URL

- **Backend URL** (`shariff_backend_url`) — points at a running Shariff backend
  service that tallies share counts. It is validated as a URL. You need this for
  the `icon-count` button style to actually show numbers; without it, buttons
  still work but show no counts.

## Web Share API

- **Hidden when Web Share API is available** (`shariff_hidden`) — when ticked,
  the buttons hide themselves on browsers that support the native Web Share API,
  deferring to the device's own share sheet.

## Save

Click **Save configuration**. Changes apply to both the block (unless it
overrides them) and the node field immediately.

## Placing the buttons

### As a block

Go to **Structure → Block layout** (`/admin/structure/block`) and place the
**Shariff share buttons** block in any region. On the block's configuration form
there is a **Use Shariff default settings** checkbox (on by default): leave it
ticked to inherit the global settings above, or untick it to override any of the
same options — services, theme, orientation, and so on — for that one block.

### As a per-node display field

Shariff adds a hidden **Shariff sharing buttons** field to every content type's
display. To show it, go to **Structure → Content types → [your type] → Manage
display** (`/admin/structure/types/manage/<type>/display`) and drag the *Shariff
sharing buttons* row out of the *Disabled* section into a visible region, then
save. The buttons then appear on every node of that type, sharing the node's
canonical URL and title (using the Metatag title token if Metatag is installed).
Enable it only on the content types where you want share buttons.
