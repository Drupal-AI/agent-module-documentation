# The `html_to_markdown_converter` plugin type

Markdownify converts rendered HTML to Markdown through a plugin, so you can swap the engine
(e.g. add a CommonMark-based converter) without touching the module.

- **Plugin manager service:** `plugin.manager.html_to_markdown_converter`
  (`HtmlToMarkdownConverterManager`, a `FallbackPluginManagerInterface` — fallback id
  `league`).
- **Discovery:** attribute `Drupal\markdownify\Attribute\HtmlToMarkdownConverter`, directory
  `src/Plugin/HtmlToMarkdownConverter/`. Alter hook `hook_html_to_markdown_converter_info_alter`.
- **Interface:** `MarkdownifyHtmlConverterInterface` (adds `convert(string $html,
  ?BubbleableMetadata): string`). Base class `HtmlToMarkdownConverterBase` implements
  `ConfigurableInterface` + `PluginFormInterface`.
- **Which one runs:** `markdownify.settings:default_converter` (default `league`). Its saved
  config lives under `markdownify.settings:converters.<id>`.

Shipped plugin: **`league`** (`LeagueHtmlToMarkdown`) wrapping
`League\HTMLToMarkdown\HtmlConverter`. Its `defaultConfiguration()` / settings form expose the
League options: `header_style` (atx|setext), `suppress_errors`, `strip_tags`,
`strip_placeholder_links`, `bold_style`, `italic_style`, `remove_nodes`, `hard_break`,
`list_item_style` (`-`/`+`/`*`), `preserve_comments`, `use_autolinks`, `table_pipe_escape`,
`table_caption_side`.

## Implementing a converter

```php
namespace Drupal\my_module\Plugin\HtmlToMarkdownConverter;

use Drupal\Core\Render\BubbleableMetadata;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\markdownify\Attribute\HtmlToMarkdownConverter;
use Drupal\markdownify\HtmlToMarkdownConverterBase;
use Drupal\markdownify\MarkdownifyHtmlConverterInterface;

#[HtmlToMarkdownConverter(
  id: 'commonmark',
  label: new TranslatableMarkup('CommonMark converter'),
)]
class CommonMarkConverter extends HtmlToMarkdownConverterBase implements MarkdownifyHtmlConverterInterface {

  public function defaultConfiguration() {
    return ['strip_tags' => TRUE];
  }

  public function convert(string $html, ?BubbleableMetadata $metadata = NULL): string {
    // ... return Markdown ...
  }

  // Optionally override buildConfigurationForm()/submitConfigurationForm() for admin options.
}
```

**Plugin-id gotcha (documented in the attribute):** the manager treats the id as a group.
The id must equal the group or be prefixed with it — i.e. use a plain id like `commonmark`
(not `mymodule:commonmark`) or the plugin may not be discovered. After adding, set
`markdownify.settings:default_converter` to your id (and provide `converters.<id>` config).
