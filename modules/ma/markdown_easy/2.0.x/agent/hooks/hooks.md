# Markdown Easy hooks

Two alter hooks (defined in `markdown_easy.api.php`) let you customise the CommonMark converter
without subclassing the filter. Both are invoked in `MarkdownEasy::process()` for every conversion.

## `hook_markdown_easy_config_modify(array &$config)`

Modify the CommonMark environment **configuration** array before the `Environment` is built. Use it
to change footnote/table options, or toggle raw-HTML handling.

```php
function mymodule_markdown_easy_config_modify(array &$config): void {
  // Example: change the footnote back-reference symbol.
  $config['footnote']['backref_symbol'] = '^';
  // NOTE: forcing $config['html_input'] = 'allow' re-enables raw HTML — only do
  // this on trusted formats that still run filter_html afterwards.
}
```

Default `$config` includes `html_input` (`strip`/`allow` per settings),
`allow_unsafe_links => FALSE`, and `footnote` / `table` option arrays.

## `hook_markdown_easy_environment_modify(\League\CommonMark\Environment\Environment &$environment)`

Modify the **environment** after the flavor extensions are added — the place to register additional
CommonMark extensions or custom parsers/renderers.

```php
use League\CommonMark\Extension\ExternalLink\ExternalLinkExtension;

function mymodule_markdown_easy_environment_modify(\League\CommonMark\Environment\Environment &$environment): void {
  $environment->addExtension(new ExternalLinkExtension());
}
```

There is no plugin type to implement; `markdown_easy` itself is a core `@Filter` plugin. For a
different flavor set, add extensions via this hook rather than defining a new filter.
