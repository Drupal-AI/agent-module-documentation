# Wordfilter process plugins (`wordfilter_process`)

A configuration's **filtering process** is a `wordfilter_process` plugin. This is the pluggable
seam for how words are matched/replaced (e.g. swap in an external moderation API).

- Plugin type id: `wordfilter_process`
- Manager service: `plugin.manager.wordfilter_process` (extends `default_plugin_manager`,
  `wordfilter.services.yml`)
- Attribute: `#[WordFilterProcess(id, label, description)]` (`src/Attribute/WordFilterProcess.php`;
  legacy `@WordfilterProcess` annotation also present in `src/Annotation/`)
- Discovery dir: `src/Plugin/WordfilterProcess/`
- Base class: `WordfilterProcessBase` implements `WordfilterProcessInterface`

## Interface

```php
public function filterWords(string $text, WordfilterConfigurationInterface $wordfilter_config,
  string $langcode = LanguageInterface::LANGCODE_NOT_SPECIFIED): string;
public function settingsForm(array $form, FormStateInterface $form_state,
  WordfilterConfigurationInterface $wordfilter_config): array;
```

`$wordfilter_config->getItems()` yields `WordfilterItem`s: `getFilterWords()` (array),
`getSubstitute()` (string), `getDelta()`.

`WordfilterProcessBase::prepareWordsForRegex()` runs each word through `Xss::filterAdmin()` +
`preg_quote`, and wraps unchanged words in `\b…\b` word boundaries.

## Shipped processes

- **`default`** (`DefaultWordfilterProcess`) — for each item builds
  `'/' . implode('|', $words) . '/iu'` and `preg_replace`s with `Xss::filterAdmin($item->getSubstitute())`.
- **`token`** (`TokenWordfilterProcess`) — same, but the (Xss-filtered) substitute is additionally
  passed through `token->replace()` before replacement, so tokens in the substitution resolve.

## Add your own

```php
#[WordFilterProcess(
  id: 'my_process',
  label: new TranslatableMarkup('My process'),
  description: new TranslatableMarkup('…'),
)]
class MyProcess extends WordfilterProcessBase {
  public function filterWords(string $text, WordfilterConfigurationInterface $config,
    string $langcode = LanguageInterface::LANGCODE_NOT_SPECIFIED): string {
    foreach ($config->getItems() as $item) {
      // match $item->getFilterWords() in $text, replace with a SANITISED substitute.
    }
    return $text;
  }
}
```

Keep `Xss::filterAdmin()` (or stricter) on any substitution you emit — the output is rendered as
markup by the filter/entity-build paths. Implement `ContainerFactoryPluginInterface` to inject
services (see `TokenWordfilterProcess`). Your plugin id then appears as an *Implementation* choice
on the Wordfilter configuration form.
