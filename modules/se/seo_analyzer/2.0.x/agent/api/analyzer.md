<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — the analysis engine (Analyzer / Page / Metric / Parser)

Everything under `src/` (except the Controller and Form) is a plain, DI-free PHP library you can call
directly. Nothing is registered as a Drupal service or plugin — you instantiate with `new`.

## Entry class: `Drupal\seo_analyzer\Analyzer` (`src/Analyzer.php`)

```php
use Drupal\seo_analyzer\Analyzer;

$analyzer = new Analyzer();                 // optional: new Analyzer(?Page $page, ?ClientInterface $client)
$results  = $analyzer->analyzeUrl('https://example.com/page', 'my keyword', 'en'); // fetch + analyze
$results  = $analyzer->analyzeHtml($htmlString, 'en');   // analyze an in-memory HTML string
$results  = $analyzer->analyzeFile('/path/to/page.html', 'en'); // analyze a saved HTML file
```

Each returns an array keyed by metric name; every value is
`['analysis' => string, 'name' => string, 'description' => string, 'value' => mixed, 'negative_impact' => int]`
(`Analyzer::formatResults()`, `Analyzer.php:252`). `negative_impact` is `0`–`10` (0 = good).

- `generateAnalyzerPage($url_string, $url_without_scheme, $langcode)` (`Analyzer.php:84`) is what the
  controller calls: it reads `$_GET['keyword']` (fallback `'keyword'`), runs `analyzeUrl()`, and on
  success returns the `#theme => 'page_seo_analyzer'` render array; on `HttpException`/`ReflectionException`
  it logs via `Error::logException(\Drupal::logger('seo_analyzer'), …)` and returns
  `#theme => 'page_seo_analyzer_error'`.
- `analyze()` (`Analyzer.php:181`) merges `Page::getMetrics()` with `getFilesMetrics()` (which
  separately fetches `<scheme>://<host>/robots.txt` and `/sitemap.xml`) and calls `->analyze()` on each.

## `Drupal\seo_analyzer\Page` (`src/Page.php`)

Represents the page under test and holds all computed "factors".
- Constructor `new Page(?string $url, $langcode = 'en', ?ClientInterface $client, ?ParserInterface $parser)`.
  A non-empty `$url` triggers `setUpUrl()` (runs `parse_url()`, defaults a missing scheme to `http://`)
  and `getContent()` (HTTP `GET` via the client, records load time and redirect chain from the
  `X-Guzzle-Redirect-History` header).
- `public $keyword`, `public $stopWords`, `public $content`, `public $factors` are all public and
  settable before `getMetrics()`.
- Factor keys are dot-notated constants in `Drupal\seo_analyzer\Factor` (`src/Factor.php`), e.g.
  `url.parsed.host`, `url.parsed.path`, `meta.title`, `meta.description`, `content.size`,
  `content.ratio`, `density.page`, `density.headers`, `keyword.title`, `keyword.description`,
  `keyword.url`, `keyword.path`, `keyword.headers`, `keyword.density`, `SSL`, `redirect`, `loadTime`,
  `alts`, `url.length`. Read/write with `getFactor('a.b')` / `setFactor('a.b', $v)`.
- The metric config list (which factors become metrics, and in what order) is the hard-coded
  `$this->config['factors']` array built in the constructor (`Page.php:89`).

## Metrics — `Drupal\seo_analyzer\Metric\MetricFactory` (`src/Metric/MetricFactory.php`)

`MetricFactory::get(string $key, $inputData)` maps a dotted key to a class name and `new`s it:
`'page.meta'` → `Metric\Page\MetaMetric`, `'file.robots'` → `Metric\File\RobotsMetric`, etc. Missing
class → `ReflectionException`. **This is not the Drupal plugin system** — no annotations/attributes, no
manager, no discovery, no alter hook. To add a metric you drop a class extending
`Metric\AbstractMetric` (implementing `analyze(): string`, setting `$this->impact`/`$this->value`) and
reference it from `Page::$config['factors']`; there is no config hook to register it without editing
source. Metric classes present: `Page\{Meta,Headers,HeadersKeywordDensity,KeywordDensity,Keyword,
KeywordTitle,KeywordDescription,KeywordUrl,KeywordPath,Alts,Redirect,SSL,LoadTime}Metric`,
`Page\Content\{Ratio,Size}Metric`, `Page\Url\LengthMetric`, `Page\Keyword\HeadersMetric`,
`File\{Robots,Sitemap}Metric`. Keyword-density base logic and stopword loading is in
`Metric\Page\AbstractKeywordDensityMetric`.

## Parser — `Drupal\seo_analyzer\Parser\Parser` (`src/Parser/Parser.php`)

Extends `AbstractParser`, which wraps a `DOMDocument` (`loadHTML`, errors suppressed). Provides
`getMeta()` (meta tags keyed by `name`), `getHeaders($keyword)` (h1–h5 text, with the passed keyword
wrapped in `<strong>`), `getTitle()` (the `<title>` text), `getImages()` (src/alt/title/dimensions per
`<img>`), and `getText()` (visible text with `<script>`/`<style>` stripped). `ExampleCustomParser`
(`src/Parser/ExampleCustomParser.php`) shows how to subclass and swap the parser via the `Page`/`Analyzer`
constructor's `ParserInterface` argument.

## HTTP client — `Drupal\seo_analyzer\HttpClient\Client` (`src/HttpClient/Client.php`)

Thin Guzzle wrapper implementing `ClientInterface::get(string $url, array $options): ResponseInterface`;
follows redirects (`track_redirects`), sets `User-Agent: grgk-seo-analyzer/1.0`, and wraps failures in
`HttpClient\Exception\HttpException`. Pass your own `ClientInterface` into `Analyzer`/`Page` to mock or
harden requests. In-Drupal usage only ever fetches the site's own canonical URL (and that host's
`robots.txt`/`sitemap.xml`); the arbitrary-URL `analyzeUrl()` path is not wired to any route.
