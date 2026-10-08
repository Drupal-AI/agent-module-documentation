# Configure Search 404

All behavior lives in the `search404.settings` config object. Edit at
`/admin/config/search/search404` (route `search404.settings`, form `Search404Settings`, gated by
the core `administer search` permission) or with `drush cset search404.settings <key> <value>`.
Config schema: `config/schema/search404.schema.yml` (a `config_object`, so it export/deploys with
`drush config:export`).

## How it hooks into 404s

`hook_install()` sets `system.site` `page.404` to `/search404`. That route
(`Search404Controller::search404Page`) parses keywords from the requested path
(`search404GetKeys()`) and renders search results on the not-found page. Saving the settings form
resets `page.404` back to `/search404` (the hidden `site_404` value).

## Which search to use

By default it uses the site's **default core Search page** (`search.search_page_repository` →
`getDefaultSearchPage()`), so the core Search module must be enabled and the user needs
`search content`. To use **Search API** or anything else, enable a custom path instead:

| Key | Default | Meaning |
|---|---|---|
| `search404_do_custom_search` | `false` | Redirect to a custom search path instead of core Search |
| `search404_custom_search_path` | `search/@keys` | Path to redirect to; `@keys` is replaced by the parsed keywords (e.g. a View route). Must end with `@keys` |
| `search404_do_search_by_page` | `false` | Use the "Search by page" module (must be enabled) |
| `search404_do_google_cse` | `false` | Use Google CSE (google_cse module must be enabled) |

## Keyword parsing from the path

| Key | Default | Meaning |
|---|---|---|
| `search404_ignore` | `and or the` | Stop words removed from the query (space-separated) |
| `search404_ignore_extensions` | `htm html php` | Extensions stripped from the last keyword (no leading dot) |
| `search404_use_or` | `false` | Join keywords with `OR` instead of whitespace |
| `search404_use_customclue` | `''` | Custom string to join keywords (ignored if `use_or`) |
| `search404_ignore_language` | `false` | Drop a leading enabled-language code from the keywords |
| `search404_use_search_engine` | `false` | Instead take keywords from a search-engine referer (Google, Bing, Yahoo, Altavista, Lycos, AOL) |
| `search404_regex` | `''` | PCRE (no slashes) whose matches are excluded from the query |
| `search404_ignore_paths` | `ajax/*`, `admin/*`, `batch/*`, `libraries/*`, `modules/*`, `profiles/*`, `sites/*`, `themes/*` (one per line, `*` wildcard) | Paths that show the default 404 with no search |

## Jump to first result

| Key | Default | Meaning |
|---|---|---|
| `search404_jump` | `false` | Redirect straight to the result when there is exactly **one** |
| `search404_first` | `false` | Redirect to the **first** result even when there are several |
| `search404_first_on_paths` | `''` | Limit `search404_first` to these paths (one per line, `*` wildcard) |
| `search404_redirect_301` | `false` | Use a 301 redirect for the jump/redirect instead of 302 |

Jump/`first` work with Core, Apache Solr, Lucene and Xapian searches.

## Abort / skip searches (file requests & load)

| Key | Default | Meaning |
|---|---|---|
| `search404_deny_all_file_extensions` | `true` | Abort the search for any path ending in a file extension (shows a "denied file query" error) |
| `search404_deny_specific_file_extensions` | `gif jpg jpeg bmp png` | Only abort for these extensions (used when the "all" option is off) |
| `search404_skip_auto_search` | `false` | Show the populated search form but don't auto-run the search (reduces load on large sites) |
| `search404_search_file_entities` | `false` | If the path maps to a published managed file, redirect straight to the file |

Note: extensions in `search404_ignore_extensions` are never aborted — they are just stripped.

## Custom 404 text & fallback

| Key | Default | Meaning |
|---|---|---|
| `search404_page_title` | `Page not found` | Title of the 404 search-results page |
| `search404_page_text` | `''` | HTML shown above the results |
| `search404_custom_error_message` | `''` | Replaces the default Drupal message; `@keys` inserts the query |
| `search404_disable_error_message` | `false` | Suppress the error message on the results page |
| `search404_page_redirect` | `''` | URL (leading `/`) to redirect to when the search returns no results |

Example: `drush cset search404.settings search404_jump true`.
