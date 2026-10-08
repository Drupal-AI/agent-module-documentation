<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTML Transformer is a developer API for mutating HTML through a series of plugins, each of which operates on a `DOMDocument`/`HTMLDocument` to make one specific change.
---
The core service (`Drupal\html_transformer\HtmlTransformerInterface`) takes an HTML document and runs it through transformer plugins — either all plugins marked "automatic" or an explicit ordered list you pass — with an optional PSR logger. Plugins are declared with the `#[HtmlTransformer('id')]` attribute and extend `HtmlTransformerPluginBase`, implementing `transform(\DOMDocument $document): void`. Example transformations (in the `html_transformer_examples` submodule) include replacing `<b>` with `<strong>` and `<i>` with `<em>`; other real uses cited are isolating `<main>...</main>` after scraping and swapping `<img>` for `<drupal-media>`. A migrate process plugin is also provided for use in migrations.

The optional `html_transformer_ui` submodule adds a testing form at `/html-transformer/transform` gated by the `use html_transformer_ui` permission (`restrict access: TRUE`); it parses your input HTML, runs the selected/automatic plugins, and shows the serialized output and log in disabled textareas (rendered as escaped Form API `#default_value`, not raw HTML). The transformer itself does no sanitization — it is a mechanical DOM tool — so callers remain responsible for sanitizing/filtering output that will be shown to users. Requires `string_logger` for the UI's `StringLogger`.

Typical setup: write one or more transformer plugins, then call `\Drupal::service(HtmlTransformerInterface::class)->transform($html)` (optionally with a `plugins:` list), or enable the UI to experiment.
---
- Replace deprecated tags (`<b>`→`<strong>`, `<i>`→`<em>`) programmatically.
- Isolate `<main>` content after scraping an external URL.
- Convert `<img src>` to `<drupal-media uuid>` during import.
- Run a controlled, ordered pipeline of HTML transformations.
- Apply all "automatic" transformer plugins to an HTML string.
- Write a custom transformer with the `#[HtmlTransformer]` attribute.
- Use the migrate process plugin to transform HTML during migration.
- Normalize markup coming from a legacy CMS.
- Strip or rewrite specific elements via a DOM plugin.
- Log transformation steps with a PSR logger.
- Test plugins interactively via the UI submodule.
- Restrict the UI to trusted users via its permission.
- Pass a document URI so plugins can resolve relative paths.
- Chain transformations deterministically by plugin order.
- Rewrite links or attributes across an HTML body.
- Clean scraped content before storing it as a node.
- Build a reusable HTML-cleaning service for feeds.
- Reference the examples submodule to learn the plugin pattern.
- Combine with media_on_demand for image-to-media conversion.
- Integrate HTML normalization into a content-import workflow.
