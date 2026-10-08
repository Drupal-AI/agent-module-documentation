# Configuration

Search API Spellcheck has no central settings page. You configure it by adding one of
its two area handlers to a **Search API view** and setting that handler's options in the
Views UI. You'll usually want the search view to have an **exposed fulltext filter**
(a `SearchApiFulltext` filter), because that is where each correction link places the
fixed keywords when a visitor clicks it.

## Add a correction area to a view

1. Go to **Structure → Views** (`/admin/structure/views`) and edit your Search API
   search view (a view whose base table is a Search API index).
2. Choose where the prompt should appear:
   - To show a single best‑guess *"Did you mean:"* link **above** the results, work in
     the **Header** section.
   - To show a bulleted list of keyword variations **below** the results, work in the
     **Footer** section.
3. Click **Add** next to that section and pick **Search API Spellcheck "Did You Mean"**
   or **Search API Spellcheck "Suggestions"**.
4. Set the options (below) and click **Apply**, then **Save** the view.

You can use both on one view — a single best guess in the Header and the full list of
variations in the Footer.

## The options

Each handler exposes a small set of options in its Views configuration form:

- **Count** *(Suggestions handler; default 1)* — the maximum number of suggestions the
  backend returns per search term. Raise it to offer more spelling alternatives.
- **Hide on result** *(default on)* — when ticked, the correction only appears if the
  view returned **no** results. Untick it to always show the correction, even when the
  search already found matches.
- **Collate** *(a defaulted option; on for "Did You Mean", off for "Suggestions")* —
  when on, the module asks the backend (Solr) to build one corrected phrase for the
  whole query rather than swapping each mistyped word individually. This usually gives a
  cleaner single "Did you mean" suggestion.

## How the correction behaves

- The **"Did You Mean"** handler emits one link, preferring the backend's collated
  phrase if available, otherwise swapping each misspelled word for its top suggestion.
  It only shows a link when the corrected phrase actually differs from what the visitor
  typed.
- The **"Suggestions"** handler expands the per‑word suggestions into every combination
  and lists each as its own link.
- Every link re‑runs the current view with the corrected keywords dropped into the
  exposed fulltext filter, while preserving the visitor's other query parameters such as
  facets and sort.

## Why you might see nothing

If corrections never appear, the most common reason is the **backend**: the feature only
works when the search server provides spellcheck data. Apache Solr does; the core
Database backend does not. Confirm your index is served by Solr and that Solr's
spellcheck/dictionary is configured for your content's language. Also check that the
view has an exposed fulltext filter so the correction links have somewhere to place the
fixed keywords.

## Deploying the setup

Because the area handler is stored inside the view, exporting the `views.view.<id>`
configuration carries the spellcheck wiring with it — so you can configure it once and
deploy it like any other view config.
