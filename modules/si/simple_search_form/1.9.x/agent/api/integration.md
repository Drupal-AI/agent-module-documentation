# Integrations & internals

## Search API Autocomplete

When the `search_api_autocomplete` module is enabled, the block form offers a third input type
`search_api_autocomplete` and a "Search API views view to be used" fieldset stored under the
`search_api_autocomplete` settings mapping:

- `search_id` — the Search API Autocomplete search/View ID (required for this input type).
- `display` — the View display ID.
- `filter` — the fulltext search filter machine name.
- `arguments` — comma-separated View arguments (optional).

At form build (`SimpleSearchForm::setupSearchApiAutocomplete`) the input element gets
`#search_id` and `#additional_data` (`filter`, `display`, and `arguments` if set), which the
Search API Autocomplete module's element alter picks up to attach autocomplete.

## View-tag auto-guess (`simple_search_form`)

`SimpleSearchFormBlock` tries to pre-fill the required settings from a View **tagged
`simple_search_form`** (only if Views is enabled):

- `guessActionPath()` — loads the view by that tag, initializes it, points at its first routable
  (page) display, and returns that display's URL. Falls back to a path named `/search` (localized
  "Search") if such an alias exists.
- `guessGetParameter()` — returns the exposed `search_api_fulltext` filter's `expose.identifier`
  from that view.

So tagging your search View `simple_search_form` makes a freshly placed block default to the right
path and query parameter.

## Rendering & caching (lazy builder)

`build()` returns a `#lazy_builder` pointing at the service
`simple_search_form.lazy_builder:getForm` (class `SimpleSearchFormLazyBuilder`, a
`TrustedCallbackInterface`), passing the block config as JSON. The lazy builder rebuilds the form
and adds cache contexts:

- `url.query_args:<get_parameter>` when `input_keep_value` is TRUE (so the box can re-show the value).
- `url.query_args:<name>` for each `preserve_url_query_parameters` entry.

This keeps the block cacheable while varying correctly by the relevant query args. `preserve_url_
query_parameters` also injects those existing query values as hidden fields into the form so they
survive the GET submit.

There is **no plugin type to implement** and no public service API beyond this lazy builder; extend
behaviour by configuring the block or by providing/tagging a search View.
