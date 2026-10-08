# Configuration

Search API block has no central settings page. You configure it by **placing the
Search API form block** and filling in its settings — each placed block carries
its own configuration.

## Before you start

You need an existing **Search API view page** with an exposed keyword filter (or
any page that accepts the keyword as a query parameter). The block only submits
*to* that page; it runs no search of its own. Make a note of two things:

- the page's **path**, e.g. `/search`;
- the **machine name of the exposed keyword filter** — core's default is `keys`.

## Place the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region you want, find **Search API form**, and
   click **Place block**.
3. Fill in the settings (below), then **Save block**.

## The settings, field by field

- **Search page** *(required)* — the path the form submits to, e.g. `/search`.
  It must start with a slash; the block refuses a path that doesn't. Supports
  tokens if the Token module is installed.
- **Submit method** — **GET** *(default)* puts the keyword in the URL query
  string, so results pages are shareable and bookmarkable. **POST** keeps the
  keyword out of the URL.
- **Input name** — the name of the search input, which must match your view's
  exposed keyword filter machine name (e.g. `keys`, or a custom `query`/`search`).
  If left blank it falls back to `keys`.
- **Placeholder** — placeholder text shown inside the input, e.g. *Search
  products…*. Supports tokens.
- **Submit button label** — the text on the button (falls back to *Search*).
  Supports tokens.
- **Label** — the input's title/label (falls back to *Search*). Supports tokens.
- **Label visibility** — how the label is shown: **Invisible** *(default,
  screen-reader only)*, **Before** the input, **After** the input, or as an
  **Attribute**.
- **Pass GET parameters** — off by default. Turn it on if your target path
  already carries query parameters (for example pre-set facets) that you want to
  survive submission; they are re-emitted as hidden fields.

## Save and test

Click **Save block**. Type a keyword into the block on the front end and submit —
you should land on your Search API search page with the keyword applied. The
module deliberately strips Drupal's internal form fields so the resulting search
URL stays clean and cacheable.

You can place multiple Search API form blocks, each pointing at a different
search page, and use core's block visibility settings to control where each one
appears.
