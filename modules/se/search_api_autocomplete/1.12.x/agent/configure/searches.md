# Configure autocomplete searches

Per Search API index, the **Autocomplete** tab (`IndexOverviewForm`, route
`search_api_autocomplete.admin_overview`) lists autocomplete-capable searches (Views search
filters, Search API Pages — discovered by *search* plugins/derivers). Enable one, choose its
suggesters, then edit its settings. Permission: `administer search_api_autocomplete`.

Each enabled search is a config entity `search_api_autocomplete.search.{id}` (exportable):

```yaml
id: my_view
label: 'My search view'
index_id: default_index
status: true
suggester_settings:            # keyed by suggester plugin id
  server: {}
  live_results: { ... }
suggester_weights: { server: 0, live_results: 10 }
suggester_limits:  { server: 10 }
search_settings:               # the 'search' plugin config (which Views display etc.)
  views:6: { displays: { default: default } }
options:
  limit: 10                    # max suggestions shown
  min_length: 1                # min chars before firing
  show_count: false            # show predicted result count
  delay: 0                     # ms debounce before request
```

Bundled suggesters (pick per search):
- `server` — backend-supplied completions (needs a backend that supports autocomplete, e.g. Solr).
- `live_results` — renders matching result items (title + link) inline; works with any backend.
- `custom_script` — call an external script/URL for suggestions; requires
  `search_api_autocomplete.settings:enable_custom_scripts = true`.

Global setting `search_api_autocomplete.settings.enable_custom_scripts` (boolean) toggles
whether custom-script suggesters are allowed. Deploy all of this with `drush config:import`.
