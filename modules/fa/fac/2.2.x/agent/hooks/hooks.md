# Hooks invited by fac

The module ships no `fac.api.php`; these are documented in `README.txt` and used in code.

## `hook_fac_empty_result_alter(&$empty_result, array $context)`
Alter the HTML shown when a configured input is focused with no query. Invoked in
`fac_page_attachments()` (`fac.module`) per enabled config, before it is emitted into
`drupalSettings.fac[<id>].emptyResult`.
- `$empty_result` — the current empty-result HTML string (by reference).
- `$context['fac_config']` — a clone of the `\Drupal\fac\Entity\FacConfig` being processed.

Typical use: load an editor-maintained menu and render it as "quick links" for the empty state.

## `hook_fac_search_plugin_info_alter(array &$definitions)`
Standard plugin-manager alter for the `fac_search` plugin type (alter id `fac_search_plugin_info`,
set in `SearchPluginManager`). Add, remove, or swap the class of a discovered search plugin
definition. See [../plugins/search.md](../plugins/search.md).

## JavaScript events (not PHP hooks)
`js/jquery.fastautocomplete.js` triggers `fac:requestStart` and `fac:requestEnd` on each watched
input around an AJAX suggestion request — bind to them to show/hide a throbber.
