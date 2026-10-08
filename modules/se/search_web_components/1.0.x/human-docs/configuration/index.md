# Configuration

Unlike many modules, Search Web Components has no single settings form. Its
configuration happens in two places: on the **Search API endpoint** you create,
and on the **page** where you place the component blocks. You will need the
**Administer search api endpoint** permission (an administrator by default) for
the endpoint work.

## 1. Create and index your content

Before anything else you need a working **Search API index** over the content
you want searchable, and that index needs to be populated. This is standard
Search API setup and is not specific to this module.

## 2. Create a decoupled Search API endpoint

Go to **Configuration → Search and metadata → Search API Endpoints**
(`/admin/config/search/search-api/endpoints`) and create a new endpoint pointed
at your index. This endpoint is the JSON API the components will call from the
browser.

## 3. Configure the "Search Web Components" settings on the endpoint

Open the endpoint's edit form. Search Web Components adds its own settings there.
Sensible defaults are seeded automatically when the endpoint is created, so you
can start from a working baseline and adjust:

- **Sort options** — define the sorts a visitor can choose. Each entry is written
  as `field|order|label` (for example a relevance sort, or a date sort in
  descending order with a friendly label).
- **Page-size options** — the choices offered by the "results per page"
  component, letting visitors show, say, 10, 25 or 50 results at a time.
- **Display modes** — the modes the results switcher offers, such as a **list**
  view and a **grid** view.
- **Result-to-element mappings** — this is the heart of the configuration: it
  decides which component renders which kind of result. By default results render
  as pretty-printed JSON (useful while you are wiring things up); you map a result
  type to an HTML element so it renders as a proper rendered field instead. You
  can add and delete mappings through the mapping forms on the endpoint.

These settings are stored as third-party settings on the endpoint's config
entity and are injected into every endpoint JSON response, so the components on
the page configure themselves from what you set here.

## 4. Place the components on a page

With the **Block** submodule enabled, go to **Structure → Block layout** (or use
Layout Builder) and place the components you want:

- A **search box** block for the input.
- A **results** block to render matches.
- **Facet** blocks (button, checkbox, dropdown, or dropdown-html) for filtering —
  these need the **Facets** submodule and configured facets on your index. You can
  override a facet's label per block placement.
- **Sort**, **pager**, and **results-per-page** blocks for controls.
- An **applied facets** block to show the active filters, a **results summary /
  count**, and a **no results** message component.
- A **results switcher** to toggle grid/list.
- A **dialog toggle** for a mobile/off-canvas search panel.

If you would rather not place blocks one by one, the **Layout** submodule's one-
or two-column search layouts come pre-wired with the search regions and the
required container and library. Block placements can also point at a remote
endpoint via manual entry, and per-block config (JSON) can override result
fields and mappings for that placement.

## A note on facets

With the **Facets** submodule, the facet edit form is reorganized into
interface / processing / advanced sections, and the endpoint response carries the
built facet data — counts, active values and children (hierarchy) — so the SWC
facet widgets can render and update entirely client-side.

## Save and test

After saving the endpoint settings and placing the blocks, visit the page as a
regular visitor. Typing in the search box should return results instantly and
facets/sorts/pager should update the list without a full page reload. If results
appear as raw JSON, revisit the result-to-element mappings in step 3 and map the
result type to a rendered HTML element.
