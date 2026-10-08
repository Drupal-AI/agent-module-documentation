<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# KeywordForm and the `?keyword` flow

`Drupal\seo_analyzer\Form\KeywordForm` (`src/Form/KeywordForm.php`) is a tiny `FormBase`, form id
**`seo_analyzer_keyword_form`**, rendered at the top of the results page via
`\Drupal::formBuilder()->getForm('Drupal\seo_analyzer\Form\KeywordForm')` (called in
`Analyzer::generateAnalyzerPage()`).

- `buildForm()` builds a single `keyword` textfield (`#default_value` = `'keyword'`, overridden with
  `$_GET['keyword']` when present) plus a "Check SEO for keyword" submit button.
- `validateForm()` is empty (no server-side validation of the value).
- `submitForm()` redirects to `<current>` with `?keyword=<submitted value>` set — it does **not** run
  the analysis itself. The GET request to the analyzer route then re-runs everything with the new
  keyword.

So the keyword is a **round-trip query parameter**: the form only sets `?keyword=`, and the actual
scoring happens in `Analyzer::generateAnalyzerPage()`, which reads `$_GET['keyword']` (fallback the
literal string `'keyword'` when absent/empty). `AbstractKeywordDensityMetric` also reads
`$_GET['keyword']` directly as a fallback when no keyword is passed to it (`src/Metric/Page/
AbstractKeywordDensityMetric.php:22`). The keyword is used to test/highlight its presence in the
fetched page's title, description, headings, URL and body — it is never used as a URL or a filesystem
path.

To analyze programmatically without the form, call `Analyzer::analyzeUrl($url, $keyword, $langcode)`
directly (see [../api/analyzer.md](../api/analyzer.md)).
