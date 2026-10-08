# Configuration

There is no global settings page for Search API Sorts. Instead you configure sorting
**per display** — once per place your index is shown — and then place a block to render
the sort links.

## 1. Open the Manage sort fields form

1. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`) and open your index.
2. Click the **Sorts** tab
   (`/admin/config/search/search-api/index/{index}/sorts`). This lists the index's
   displays — each Views page/block on the index, each Search API Pages page, and so on.
3. Choose the display whose results you want to sort. You'll land on its **Manage sort
   fields** form.

Both screens require Search API's **Administer Search API** permission — the module
adds no permission of its own.

## 2. Enable and configure sort fields

The Manage sort fields form lists the fields that can be used as sort options. For each
one you can:

- **Enabled** — tick this to make the field a selectable sort option. (Only enabled
  fields are saved; un‑ticking a field removes its configuration.)
- **Default sort** — a radio; pick the single field that should be used when no explicit
  sort has been chosen. If you set none, results fall back to a built‑in **Relevance**
  option.
- **Default order** — `Ascending` or `Descending`, used as the field's initial
  direction.
- **Label** — the human‑readable text shown on the sort link (e.g. show "Newest"
  instead of a raw field machine name).
- **Weight** — controls the order the sort links appear in.

Only **single‑value string or number fields** are offered. Fulltext fields and
multi‑value (list) fields are skipped because they don't sort cleanly. A synthetic
**Relevance** option is always available.

Save the form. Each enabled field is stored as its own small configuration entity, so
your sort setup can be exported and deployed like any other config.

## 3. Place the "Sort by" block

The sort links are rendered by a block, and there is **one block per display** so the
right options show in the right place:

1. Go to **Structure → Block Layout** (`/admin/structure/block`) and click **Place
   block** in your chosen region.
2. Search for **Sort by** — the block for your display is labelled "Sort by (*your
   index*)".
3. Place it and save.

The block shows nothing when the matching display isn't on the current page, or when no
sort fields are enabled for it. Otherwise it renders your sort links (ordered by
weight), with an ascending/descending arrow on the active one.

## How visitors sort

Clicking a sort link updates two query parameters on the results page — `sort` (the
field) and `order` (`asc` or `desc`) — so links are shareable and bookmarkable. Clicking
the already‑active option flips its direction. When no parameters are present, the
display's default sort applies.

## Caching / performance note

Because Search API may read from an external backend, results can't be cached, and the
sort block is set to never cache. Enable core's **BigPipe** module so the block is
lazy‑rendered after the main results rather than blocking the whole page.

## Restyling the sort links

The links render through the `search-api-sorts-sort.html.twig` template (theme hook
`search_api_sorts_sort`). Override that template — or the surrounding
`item_list__search_api_sorts` — in your theme to change the markup or styling. Each
link exposes `label`, `url`, `order`, `active`, and an order indicator.

## Overriding the sort in code

Developers can rewrite the active or default sort programmatically with
`hook_search_api_sorts_active_sort_alter()` and
`hook_search_api_sorts_default_sort_alter()`. See the
[`agent/`](../agent/hooks/alter-sort.md) docs for details.
