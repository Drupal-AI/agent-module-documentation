# Configuration

Custom Search has **no single settings page**. You configure it in two places: the
**Custom Search block** (through Block layout) controls the search box that visitors
use, and each **core Search page's** settings form controls what happens on the
results page. This page covers both.

## Part 1 — The Custom Search block

### Place the block

Go to **Structure → Block layout** (`/admin/structure/block`), click **Place block**
in the region you want, and choose **Custom Search**. You can place more than one
block with different scopes — for example a "Search news" box in a header and a
"Search docs" box elsewhere.

### Block settings

The block's configuration form is organised into groups. You don't have to use all
of them — a minimal block is just the search box.

**Search box** — the text input:

- **Label** and whether it's visible.
- **Placeholder** — the greyed‑out hint inside the empty field.
- **Title / hint** text.
- **Size** — the visible width of the input, in characters.
- **Max length** — the maximum number of characters allowed.

**Submit button:**

- **Text** — the button label, or
- **Image path** — point to an image/icon to use a graphical button instead of a
  text one.

**Content‑type selector** — lets a visitor limit the search to chosen content types:

- **Types** — which content types the selector offers.
- **Selector type** — a **dropdown** or **checkboxes** (checkboxes let visitors pick
  several types at once).
- **Label** and its visibility.
- An **"‑ Any ‑"** option with its own text, and switches for whether choosing "Any"
  *restricts* to the selected types and whether it is *forced*.
- **Excluded** types to keep out of results.
- Which **search page** the block submits to.

**Taxonomy selector(s)** — one or more term selectors, each with:

- A **selector type** (dropdown/checkboxes).
- A **depth** setting, to include child terms below the chosen term.
- A **label** and the **"‑ Any ‑"** ("all") text.

**Criteria** — extra query toggles the visitor can use before searching. Each of
**or** (any of these words), **phrase** (exact phrase), and **negative** (without
these words) can be shown or hidden and given its own label.

**Search API** — if you use Search API, set the **page** here to route the block's
query to a Search API page instead of core search.

**Languages** — a language selector, where applicable.

Each selector and criterion has a **weight** and **region** so you can order and
position the pieces within the form. Save the block. When a visitor submits, their
chosen content types, taxonomy terms, and criteria are appended to the search query
to narrow the results.

## Part 2 — The core search results and forms

When you install Custom Search, it seeds settings for each of your core search
pages (for example the *Content* search, `node_search`). You reach these options not
on a module page but on the **search page's own settings form**, where Custom Search
injects them.

### Where to edit

Go to **Configuration → Search and metadata → Search pages**
(`/admin/config/search/pages`) and **edit** the search page you want to customise.
The extra Custom Search options appear on that form.

### What you can control per search page

- **Show the search form** on the results page (on or off).
- **Advanced (refine) form** — whether it's visible, whether it's collapsible, and
  whether it starts collapsed. You also choose which **content types**, **criteria**,
  and **languages** the advanced form offers visitors.
- **Displayed info** — which per‑result details are shown (author, content type,
  date, and so on).
- **Results filter** — an optional filter to re‑scope results after searching, with
  its own position, label, and "any" text.

When you add new content types or languages to your site later, Custom Search
automatically adds them to these per‑page settings, so you don't have to revisit
this form every time.

### Inspecting the settings from the command line

The per‑page results configuration lives in the `custom_search.settings.results`
config object, keyed by search page id. You can inspect it with Drush:

```bash
drush config:get custom_search.settings.results
drush config:get custom_search.settings.results node_search
```

## Optional: popup search box

The module ships templates and a small CSS/JS library for an optional popup/overlay
search box — a compact trigger that expands into the search form. It's driven by the
module's theming assets rather than a settings toggle, so enabling it is a theming
task on top of the block placement above.
