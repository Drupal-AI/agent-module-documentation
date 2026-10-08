# Plugin type: TermGlossaryHandler

A handler decides how a matched term is presented: the markup produced for each match, any term
data it needs, and the libraries/settings to attach. The active handler is chosen by the
`integration_type` config key.

- Manager service: `plugin.manager.term_glossary.term_glossary_handler`
  (`Drupal\term_glossary\TermGlossaryHandlerPluginManager`, extends `DefaultPluginManager`).
- Discovery: annotated plugins in `Plugin/TermGlossaryHandler`.
- Interface: `Drupal\term_glossary\TermGlossaryHandlerInterface` (extends `PluginFormInterface`).
- Base class: `Drupal\term_glossary\TermGlossaryHandlerBase` (adds `ConfigFormBaseTrait`; `create()` injects `config.factory`).
- Annotation: `Drupal\term_glossary\Annotation\TermGlossaryHandler` — properties `id`, `title`.
- Discovery-alter hook: `term_glossary_handler_info`. Definition cache: `term_glossary_handler`.

## Built-in and submodule handlers

| id | Class / module | Match markup |
|---|---|---|
| `default` | `TermGlossaryJQueryUIDialogHandler` (extends custom_js) | `custom_js`'s `span` + attaches `term_glossary/glossary` library and `drupalSettings.termGlossary` dialog options. Reads `term_glossary.glossaryconfig.jqueryui`. |
| `custom_js` | `TermGlossaryCustomJSHandler` | `<span role="button" tabindex="0" class="glos-term" data-gterm="<tid>">Html::escape(match)</span>`. You supply JS/CSS. |
| `link` | `TermGlossaryLinkHandler` | `Link::createFromRoute(match, 'entity.taxonomy_term.canonical', ['taxonomy_term' => tid], class 'glos-term')`. |
| `abbr` | `term_glossary_abbr` submodule | Renders matches as `<abbr>` (example plugin). |
| `tippy` | `term_glossary_tippy` submodule | Tippy.js tooltips; needs `popper.js` + `tippy.js` in `/libraries`. |

## Interface methods

```php
public function getTitle(): string;
public function buildTermData(array &$term_data, TermInterface $term, string $langcode): void;
public function buildMatchTag(array &$match_tag, string $match_value, array $term_data): void;
public function attachLibrariesAndSettings(&$variables);
// plus buildConfigurationForm/validate/submit from PluginFormInterface.
```

- `buildTermData()` — add keys to the per-term data array cached for matching (called from `TermGlossaryManager::updateTermList()`); base impl is a no-op.
- `buildMatchTag()` — populate the render array for one match; the manager renders it in isolation and splices it into the field HTML.
- `attachLibrariesAndSettings()` — add `#attached` libraries/`drupalSettings` when matches occurred.
- `buildConfigurationForm()` — extra settings shown on `/admin/config/glossary` under the handler select (AJAX-refreshed); persist them in your own `submitConfigurationForm()` (the main form calls it after saving `term_glossary.glossaryconfig`).

## Add a handler

1. Create a module with `Plugin/TermGlossaryHandler/MyHandler.php` extending `TermGlossaryHandlerBase`.
2. Annotate `@TermGlossaryHandler(id = "my_id", title = @Translation("My handler"))`.
3. Implement `buildMatchTag()` (return safe markup — the manager escapes nothing extra; use `Html::escape()` on the match value as the built-ins do) and, if needed, `buildConfigurationForm()`/`submitConfigurationForm()`.
4. Clear caches; select "My handler" as the integration type at `/admin/config/glossary`.
