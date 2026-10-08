# Plugin types

The module defines two plugin types (PHP attributes; legacy annotations also present).

## Suggester — produces the dropdown suggestions
- Attribute: `#[SearchApiAutocompleteSuggester(id, label, description, default_weight, deriver, no_ui)]`
- Manager service: `plugin.manager.search_api_autocomplete.suggester`
- Base class: `Drupal\search_api_autocomplete\Suggester\SuggesterPluginBase`
- Interface `SuggesterInterface` key methods:
  - `getAutocompleteSuggestions(QueryInterface $query, $incomplete_key, $user_input)` — return
    an array of `SuggestionInterface` (build via `search_api_autocomplete.plugin_helper` /
    `Suggestion\SuggestionFactory`).
  - `alterAutocompleteElement(array &$element)` — tweak the render/attach for the field.
- Directory: `src/Plugin/search_api_autocomplete/suggester/`. Built-ins: `Server`, `LiveResults`,
  `CustomScript`.

Minimal skeleton:
```php
#[SearchApiAutocompleteSuggester(
  id: 'my_suggester',
  label: new TranslatableMarkup('My suggester'),
)]
class MySuggester extends SuggesterPluginBase {
  public function getAutocompleteSuggestions(QueryInterface $query, $incomplete_key, $user_input) {
    $factory = new SuggestionFactory($user_input);
    return [$factory->createFromSuggestedKeys('example')];
  }
}
```

## Search — describes where an autocomplete-capable search lives
- Attribute: `#[SearchApiAutocompleteSearch(id, label, ..., deriver)]`
- Manager service: `plugin.manager.search_api_autocomplete.search`
- Base class: `Drupal\search_api_autocomplete\Search\SearchPluginBase`
- Directory: `src/Plugin/search_api_autocomplete/search/`. Built-ins use derivers: `Views`
  (`ViewsDeriver`) and `Page` (`PageDeriver` for Search API Pages). Implement one to expose a
  new kind of search form to autocomplete.

`search_api_autocomplete.plugin_helper` (`Utility\PluginHelper`) wraps both managers for
creating configured plugin instances.
