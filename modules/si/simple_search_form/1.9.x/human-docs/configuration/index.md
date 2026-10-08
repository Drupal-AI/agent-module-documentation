# Configuration

Simple Search Form has **no central settings page**. Everything is configured on
each **block instance** — so you can place several search boxes that point at
different result pages if you like.

## Place the block

1. Log in as an administrator and go to **Structure → Block layout**
   (`/admin/structure/block`).
2. Click **Place block** in the region where you want the search box (a header or
   sidebar is typical).
3. Find **Simple search form** (under the *Search* category) and place it.
4. The block's configuration form opens — fill it in as below, then **Save block**.

## Required settings

These two are mandatory:

- **Path** — the URL the form submits to. It must start with `/`, `?`, or `#`
  (for example `/search`). This is where the visitor lands with their query.
- **GET parameter** — the query‑string key your typed text is sent as (for
  example `search_api_fulltext`).

With just these two, submitting the form navigates the browser to
`path?parameter=<typed value>` — for example `/search?search_api_fulltext=drupal`.

## Input and label options

- **Input type** — how the text box renders:
  - **Search** (default) — the HTML5 `search` input, which gives a native clear (×)
    button in most browsers.
  - **Textfield** — a plain text input.
  - **Search API Autocomplete** — offered only when the Search API Autocomplete
    module is installed; adds live suggestions. (Its own sub‑settings — search id,
    display, filter, arguments — are covered in the agent docs at
    [`agent/api/integration.md`](../agent/api/integration.md).)
- **Label** — the search input's label (default *Search*).
- **Label display** — show the label **before** or **after** the input, or make it
  **invisible** (still present for screen readers).
- **Placeholder** — grey hint text shown inside the empty input.
- **CSS classes** — space‑separated classes added to the input, for theming.

## Submit button options

- **Show the submit button** — on by default. Turn it off to let users search by
  pressing Enter only.
- **Submit button label** — the button text (default *Find*).

## Behaviour options

- **Keep the submitted value in the input** — when on, the typed query stays
  visible in the box after the page reloads on the results page.
- **Preserve URL query parameters** — a list of existing query parameters (entered
  comma‑separated) to carry through when the form submits. Handy for keeping facets,
  pagination, or sort settings across a new search.

## Auto‑guessed defaults with Views

If the core **Views** module is enabled and you have a View **tagged
`simple_search_form`**, the block form pre‑fills the **Path** from that View's
routable (page) display URL, and the **GET parameter** from its exposed
`search_api_fulltext` filter identifier. You can still override either field. This
is the fastest way to wire a search box to a Search API results View — build the
View, tag it, and the block guesses the rest.

## A worked example

To feed a Search API results page at `/search`:

- **Path:** `/search`
- **GET parameter:** `search_api_fulltext`
- **Input type:** Search
- **Label display:** Invisible
- **Placeholder:** `Search the site…`
- **Keep the submitted value in the input:** on

Save the block. Typing "drupal" and submitting sends the visitor to
`/search?search_api_fulltext=drupal`, where your Views/Search API page renders the
matching results.
