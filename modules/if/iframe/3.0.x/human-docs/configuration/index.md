# Configuration

Iframe has **no central settings page**. Everything is configured per field, using
Drupal's normal Field UI on the content type (or other entity) you add it to. There
are three places involved: **Manage fields** (the field's own settings and
defaults), **Manage form display** (the widget editors use), and **Manage display**
(the formatter that renders it).

## Step 1 — add the field

1. Go to, for example, **Structure → Content types → Article → Manage fields → Add
   field**.
2. Choose the **Iframe** field type and give the field a label.
3. Save through the field creation steps.

An iframe field stores a source URL plus a set of attributes: a title, a heading
level, width, height, CSS class, frame border, scrolling, transparency, fullscreen,
and token support.

## Step 2 — field settings (Manage fields)

On the field's edit page you set the site‑wide **defaults** for the styling
attributes that editors do not necessarily control:

- **CSS class** — a class applied to iframes from this field.
- **Header level** — the heading level (h1–h4) used for the title, for accessible
  heading order.
- **Frame border** — whether a border is drawn around the embed.
- **Scrolling** — automatic, disabled, or enabled scrollbars.
- **Transparency** — allow CSS transparency on the iframe.
- **Allow fullscreen** — whether embedded players may go fullscreen.
- **Token support** — none, tokens in the title only, or tokens in the title and URL
  (the last two require the Token module).

## Step 3 — choose the widget (Manage form display)

On **Manage form display**, pick which widget editors see. This is how you decide
how much they can change:

- **URL only** (`iframe_url`) — editors enter just the URL; width and height come
  from the field defaults.
- **URL with height** (`iframe_urlheight`) — URL plus height; width stays fixed.
- **URL with width and height** (`iframe_urlwidthheight`) — URL, width and height
  (this is the default).

Each widget has its own settings (via the gear icon) for the default width, height,
header level and class, plus an **Expose class** checkbox that lets authors add
their own CSS class per iframe, and defaults for frame border, scrolling,
transparency, fullscreen and token support. Widget settings override the field
settings where they are set.

### Sizing values

Width and height accept:

- A plain number for **pixels** — for example `600`.
- A number with `%` for a **percentage** of the container — for example `100%`.
- **em/rem** and viewport units (`vw` for width, `vh` for height).

Two special CSS classes change sizing behaviour:

- **`iframe-responsive`** — treats the width and height as an **aspect ratio** (for
  example 4:3) so the embed scales responsively with its container.
- **`autoresize`** — attempts to auto‑fit the height to same‑origin embedded
  content.

## Step 4 — choose the formatter (Manage display)

On **Manage display**, pick how the stored value is rendered:

- **Title, over iframe** (`iframe_default`, the default) — the iframe with its title
  as a heading above it.
- **Iframe without title** (`iframe_only`) — just the iframe.
- **A link with the given title** (`iframe_asurl`) — a plain link using the title
  text, rather than an embed.
- **A link with the URI as the title** (`iframe_asurlwithuri`) — a plain link that
  shows the URL.

## Deploying

All of this — field settings, widget settings and formatter settings — is stored as
configuration, so it exports and deploys between environments with `drush
config:export` / `config:import`.

## Theming the output

The rendered iframe uses a themeable `iframe.html.twig` template. To customise the
markup, copy that template into your theme and adjust it there. The module also
ships a small CSS/JS library that backs the responsive and autoresize class
behaviours.
