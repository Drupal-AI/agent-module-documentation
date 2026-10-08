# Search-form block

`src/Plugin/Block/SearchBlock.php` — plugin id `elasticsearch_search_api`, admin label "Search form".
A `BlockBase` (ContainerFactoryPlugin, injects `form_builder`) that renders the `SearchForm` as a site
header search box.

`build()` calls `formBuilder->getForm(SearchForm::class, TRUE, 'site-search', 'esa-header-search-form')`
(i.e. inline autocomplete enabled, keyword id `site-search`, form id `esa-header-search-form`), then tweaks
the submit id to `do-search`, clears the keyword `#prefix`/placeholder, and adds the wrapper class
`esa-search-form`.

Place it via Block layout like any block. On submit it redirects to the `elasticsearch_search_api.search`
route (`?keyword=…`) unless a custom redirect Url is supplied — so it assumes that route (or an override)
exists. See [../api/framework.md](../api/framework.md) for `SearchForm` details and the inline-autocomplete
library.
