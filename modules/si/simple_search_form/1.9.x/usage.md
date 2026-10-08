Simple Search Form provides a configurable "Simple search form" block: a single text input plus submit button that, on submit, redirects the visitor to a chosen path with the typed text as a URL GET parameter (e.g. `/search?search_api_fulltext=hello`).

---

The module ships one Block plugin, `simple_search_form_block` (admin label "Simple search form", category Search). You place it via Block layout and configure two required fields — **Path** (`action_path`, the URL to submit to, must start with `/`, `?`, or `#`) and **GET parameter** (`get_parameter`, the query-string key). The form uses `method="get"` with no form token, so submitting simply navigates to `action_path?get_parameter=<value>`; a `#after_build` callback strips Drupal's internal `form_id`/`form_build_id` from the query string. The block form exposes many options: input element type (`search` / `textfield`, or `search_api_autocomplete` when that module is on), label + label display, placeholder, CSS classes, whether to show the submit button and its label, whether to keep the submitted value in the input after redirect (`input_keep_value`), and a list of URL query parameters to preserve through the redirect (`preserve_url_query_parameters`). When Views is installed it can **auto-guess** the path and parameter from a view tagged `simple_search_form` (it reads the view's routable display URL and its exposed `search_api_fulltext` filter identifier). The form is rendered through a lazy builder (`simple_search_form.lazy_builder:getForm`) so the block is cacheable, adding `url.query_args:<param>` cache contexts when value-keeping or parameter-preservation is enabled. Optional integration: Search API (match the parameter to a fulltext filter) and Search API Autocomplete.

---

- Place a site-wide search box that sends queries to a Search API results page (`/search?search_api_fulltext=…`).
- Feed a Views page's exposed fulltext filter from a header search block.
- Redirect searches to any internal path with a chosen query-string key.
- Add a simple product search that points at a catalog listing page.
- Build a "search this section" box that submits to a specific landing page.
- Use the `search` HTML5 input type for a native clear (×) button, or a plain textfield.
- Turn on Search API Autocomplete suggestions in the search input.
- Keep the typed query visible in the box after the page reloads (`input_keep_value`).
- Preserve existing URL filters (e.g. facets) across a new search via `preserve_url_query_parameters`.
- Auto-configure the path/parameter by tagging a search View with `simple_search_form`.
- Style the input with custom CSS classes for theme integration.
- Hide the submit button and let users press Enter to search.
- Give the input a custom placeholder and an accessible (or invisible) label.
- Place multiple search blocks pointing at different result pages/parameters.
- Provide a search box in a footer or sidebar region without writing a custom form.
- Point the form at an external-style path beginning with `?` or `#` when needed.
- Localize the search label / placeholder / submit text per block instance.
- Pair with a Search API index + view to build a full search experience with just blocks.
- Add a quick-search to a landing page that jumps straight to filtered results.
- Preserve pagination or sort query args when re-searching from a results page.
- Cache the block safely (lazy builder) while still varying by the search query args.
- Migrate a bespoke GET search form to a configurable, exportable block.
- Offer a minimal search UI on sites that don't need core Search's full module.
