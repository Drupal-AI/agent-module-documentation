# Configuration

Setting up Google Reviews is two steps: enter your Google credentials on the
settings page, then place one or both blocks.

## Open the settings page

1. Log in as a user with the **Administer Google Reviews configuration**
   permission.
2. Go to **Configuration → System → Google Reviews**, or navigate directly to
   `/admin/config/system/googlereviews`.

Settings are stored in the `googlereviews.settings` config object.

### The settings, field by field

| Field | Default | What it does |
|---|---|---|
| **Google Places API version** | Legacy | Choose **legacy** Places API or the new **Places API v1**. This changes how the request URL and authentication are built — pick the one your API key/project supports. |
| **API URL** | `https://maps.googleapis.com/maps/api/place/details/json` | The base request URL. For v1 the Place ID is appended to this URL; for legacy it is used as‑is with query parameters. Leave the default unless you route through a proxy. |
| **Google auth key** | *(empty)* | Your Google API key. On the legacy API it is sent as a `key=` query parameter; on v1 it is sent as an `X-Goog-Api-Key` header. |
| **Google Place ID** | *(empty)* | The default Google Place ID used when a block doesn't override it. |
| **Cache max‑age** | 86400 (24 hours) | How long (in seconds) block output is cached, to keep you within your Places API quota. |

If either the auth key or the resolved Place ID is empty, the blocks render
nothing and show an admin‑only error message linking back to this form.

## Place the blocks

Add the blocks through **Structure → Block layout** (or Layout Builder). There
are two:

### Google Reviews List

Renders individual review cards. Its options:

- **Maximum reviews** — how many reviews to show, 1–5 (default 5).
- **Sort order** — **Newest** or Google's **Most relevant** (most‑relevant is a
  legacy‑API feature).
- **Place ID** — override the global default for this block, so you can show a
  different location per block/page.
- **Moderation settings:**
  - **Minimum rating** — hide reviews below this star rating.
  - **Filtered words** — a comma‑separated list; a review is hidden if any of
    these words appears in the review text or the reviewer's name.

### Google Reviews Rating

Renders your aggregate rating, a rating percentage, the total review count, and a
link to the location on Google. Its only option is a **Place ID** override.

Both blocks respect the **Cache max‑age** you set above.

## Theming

The blocks render through two templates —
`googlereviews-reviews-block.html.twig` and
`googlereviews-rating-block.html.twig`. Copy either into your theme to restyle
the review cards or rating markup. Review values (author, text, rating) are
passed as variables and Twig auto‑escapes them.

## Multiple locations

To show reviews for more than one location, place multiple blocks and give each
its own **Place ID** override.
