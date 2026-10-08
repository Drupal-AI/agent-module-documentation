# Configuration

All of Recite Me Connector's settings live on one form. Until you fill in your
Recite Me service details here, the widget has nothing to load, so this is a
required step rather than optional tuning.

## Open the settings form

1. Log in as a user with the **access administration pages** permission (an
   administrator by default).
2. Go to `/admin/config/reciteme_connector/recitemeconfig`.

## The settings, field by field

- **Service URL** — the Recite Me service URL from your Recite Me account. This is
  where the widget's JavaScript is loaded from.
- **Service Key** — the site key Recite Me issues you. As noted in the overview,
  this is a public client-side value; it is exposed in the page's JavaScript by
  design, which is how the widget authenticates from the browser.
- **Enable Recite me throughout the site** — the site-wide autoload toggle. When
  ticked, the widget loads on every page automatically and you do not need to
  place a block. Leave it unchecked if you would rather control placement with
  the ReciteMe block.
- **Enable fragment** — a CSS selector that scopes the widget to a specific part
  of the page instead of the whole document. Use this if Recite Me should only
  apply to a particular content region.
- **Widget text** — the label shown on the launcher when you are not using custom
  images. This is the fallback text visitors click to open the toolbar.
- **Launcher images** — two optional image uploads, a **background image** and a
  **hover image** for the launcher button, so you can style the toolbar trigger
  to match your site. Uploaded images are stored under `public://recite_me/`. If
  you leave these empty, the widget falls back to the text label above.

## Save

Click **Save configuration**. Then make the widget visible one of two ways:

- **Site-wide:** tick **Enable Recite me throughout the site** on this form, or
- **By block:** go to **Structure → Block layout**, place the **ReciteMe block**
  in the region where you want the launcher to appear.

Load a front-end page as a visitor and confirm the Recite Me launcher shows and
opens the assistive toolbar.

## Theming (optional)

The module ships a Twig template, `recite-me-block.html.twig`. Copy it into your
theme to customise the launcher markup. One thing to preserve when you do: the
HTML tag is rendered with the `raw` filter (`{{ html_tag | raw }}`) — keep the
`raw` filter, otherwise the tag is printed as escaped plain text instead of being
rendered. You can also override the module's CSS libraries in your theme to
restyle the widget.
