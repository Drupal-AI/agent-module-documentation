# Matcher plugins

A matcher searches a data source and returns autocomplete suggestions. Plugin type defined by
`MatcherManager` (service `plugin.manager.linkit.matcher`), namespace `Plugin/Linkit/Matcher`,
alter hook `linkit_matcher`.

- **Interface:** `Drupal\linkit\MatcherInterface` (extends `ConfigurableInterface`,
  `DependentPluginInterface`).
- **Base classes:** `MatcherBase`, or `ConfigurableMatcherBase` for a settings form.
- **Attribute:** `#[Matcher(id, label, target_entity?, deriver?)]` (legacy annotation
  `@Matcher` also supported).

## Implement
```php
namespace Drupal\my_module\Plugin\Linkit\Matcher;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\linkit\Attribute\Matcher;
use Drupal\linkit\MatcherBase;
use Drupal\linkit\Suggestion\SuggestionCollection;
use Drupal\linkit\Suggestion\SimpleSuggestion;

#[Matcher(id: 'my_thing', label: new TranslatableMarkup('My thing'))]
class MyThingMatcher extends MatcherBase {
  public function execute($string): SuggestionCollection {
    $c = new SuggestionCollection();
    $s = (new SimpleSuggestion())->setLabel($string)->setPath('/foo');
    $c->addSuggestion($s);
    return $c;
  }
}
```

`execute($string)` returns a `SuggestionCollection` of `SimpleSuggestion` /
`DescriptionSuggestion` / `EntitySuggestion`. Bundled examples: `EntityMatcher`, `NodeMatcher`,
`TermMatcher`, `UserMatcher`, `FileMatcher`, `EmailMatcher`, `ExternalMatcher`,
`FrontPageMatcher`, `ContactFormMatcher`. See also the `linkit_test` module.
