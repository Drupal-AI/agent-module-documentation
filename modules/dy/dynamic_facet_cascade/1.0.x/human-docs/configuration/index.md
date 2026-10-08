# Configuration

Dynamic Facet Cascade builds on facets that already exist for your search view, so
the setup order matters: **create the facets first**, then build a **preset** that
chains them into a cascade, and finally place the resulting **block**. All preset
management lives at **Configuration → Search and Metadata → Dynamic Facet Cascade**
(`/admin/config/search/dynamic-facet-cascade`).

## Step 1 — Create the facets

The preset form can only offer facets that already exist for your search view — one
per drop‑down you plan to expose (one for each cascade level such as Make, Model,
Version, and one for each dominant dimension such as Year or Type).

1. Go to **Configuration → Search and Metadata → Facets**
   (`/admin/config/search/facets`) and click **Add facet**.
2. **Facet source:** select the **page display of your Search API view** (for
   example `search_api:views_page__car_search__page_1`). The facet must be attached
   to the view's display — facets created for other sources will **not** appear in
   the preset form.
3. **Field:** pick the indexed taxonomy‑term field for that drop‑down.
4. Save, and repeat for every cascade level and dominant dimension.

> **Empty facet drop‑downs on the preset page?** This step is almost always what's
> missing — the module lists only facets whose source matches the selected view.

## Step 2 — Create a preset

Back on the Dynamic Facet Cascade page, click **Add Preset** and fill in:

- **Label** — a human‑readable name for the preset.
- **Machine name** — used as the block ID.
- **Search View Path** — the path of the Search API view page that displays the
  results.
- **Facet Value Type** — how the selected term is encoded in the redirect URL:
  - **`tid`** — the numeric term ID (`?f[]=brand:42`). The most performant option and
    safe for all term names.
  - **`name`** — the raw term label (`?f[]=brand:Toyota`). Requires the Facets to be
    configured to accept names.
  - **`slug`** — a CSS‑cleaned, lower‑cased label (`?f[]=brand:toyota`). Gives
    human‑friendly URLs.
- **Cascade on existing content only** — controls the cascade mode (see below).

## Step 3 — Define the cascade levels

Define the ordered chain of drop‑downs. Each level maps to one Facets entity
configured for the chosen view:

- **Facet** — select from the Facets entities attached to the chosen view. The module
  automatically derives the vocabulary, URL alias, and the inter‑level reference
  field that links a parent term to its children, so each drop‑down narrows the next.

Order the levels the way you want visitors to choose (e.g. Make, then Model, then
Version), and save the preset.

## Cascade modes

The **Cascade on existing content only** option decides how each drop‑down's options
are computed. When enabled, the cascade only offers values that actually appear in
indexed content (querying the same Search API index the view is built on), so
visitors never see a combination that would return zero results. Leave it off if you
want the drop‑downs to follow the taxonomy relationships regardless of whether
matching content currently exists.

## Step 4 — Place the block

Each saved preset becomes a block identified by its machine name. Place it above your
search‑results view:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find your preset's block and **Place block** in the region above the search view.
3. Configure its visibility so it appears on the search page, and save.

## Verify it worked

Visit the search page: the cascade drop‑downs should appear, each one narrowing the
next (e.g. picking *Toyota* limits the Model list to Toyota models). Making your
selections and submitting should redirect you to the Views results page, pre‑filtered
with the chosen facet values in the URL.
