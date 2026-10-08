<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Route, form, metric pipeline & AI recommendations

## Install / enable

`composer require drupal/ai_seo_link_advisor` → `drush en ai_seo_link_advisor`. Requires `drupal/ai`
with a chat provider installed and set as the **site default chat** operation. You must also set
`$settings['trusted_host_patterns']` in `settings.php` — the form disables its submit button and shows
an error until this is configured. Grant the **`access seo analyzer`** permission to the roles that may
run analyses. There is no settings page.

## Route & permission

- Route `ai_seo_link_advisor.analyzer_form` (`ai_seo_link_advisor.routing.yml`): path
  `/ai-seo-link-advisor-form`, `_form: Form\AiSeoLinkAdvisorForm`, `requirements._permission: 'access
  seo analyzer'`.
- Permission `access seo analyzer` (`ai_seo_link_advisor.permissions.yml`) — a plain permission (no
  `restrict access: true`).

## Form `AiSeoLinkAdvisorForm`

`src/Form/AiSeoLinkAdvisorForm.php`, `FormBase`, id `ai_seo_link_advisor_form`.

- `buildForm()`: a `#type => url` required field, a submit with an `#ajax` callback (`ajaxCallback`
  returns `$form['output']`), and an `output` markup wrapper (`#markup` from
  `$form_state->get('submitted_markup')`). Submit is `#disabled` when `trusted_host_patterns` is empty.
- `validateForm()` gates the URL: `filter_var(... FILTER_VALIDATE_URL)`; scheme in `['http','https']`;
  host must `preg_match('#'.$pattern.'#', $host)` against a `trusted_host_patterns` entry; the path is
  turned into `Url::fromUserInput($path)` and must be `isRouted()` and `->access()`; and the resolved
  route must not have `_admin_route` nor a `/admin` path prefix. These checks constrain analysis to the
  site's own hosts and to pages the current user may view.
- `submitForm()`: `AiSeoLinkAdvisor::analyze($url)` → `renderer->render()` → stored as
  `submitted_markup`, `setRebuild()`.

## Service `AiSeoLinkAdvisor`

`src/AiSeoLinkAdvisor.php` (`ai_seo_link_advisor`). `analyze($url)`:
- Runs `(new Analyzer())->analyzeUrl($url, '', <langcode>)` (keyword empty → keyword-density/position
  metrics are skipped; only content + general analytics are built).
- `createContentAnalyticsForm()` assembles `#theme => table_content_analytics` from PageMeta,
  PageHeaders, PageContentRatio, PageAlts, PageUrlLength. For each metric with `negative_impact != 0`
  it builds a prompt (`<analysis>-<value>`) and calls `generateAiRecommendations()`.
- `createGeneralAnalyticsForm()` assembles `#theme => table_general_analytics` from PageSSL,
  PageRedirect, PageContentSize, PageLoadTime, FileRobots, FileSitemap.
- `generateAiRecommendations($provider,$settings,$prompt)`: builds `ChatInput` with a system message
  (`getDefaultSystemPrompt()`, a built-in SEO-expert instruction) + the user prompt, calls
  `$ai_provider->chat($messages, $model)->getNormalized()`. Provider/model come from
  `aiProvider->getSimpleDefaultProviderOptions('chat')` split on `__`; the instance is created with a
  500s `http_client_options.timeout`. Errors are caught and logged; analysis still renders.

## Analyzer pipeline (`src/Analyzer`, `src/Page.php`, `src/Factor.php`)

- `Analyzer::analyzeUrl()` builds a `Page($url, $langcode, $client)`; `Page::getContent()` fetches via
  the HTTP client and records load time + redirect. `Page::parse()` uses `Parser` (`DOMDocument`) to
  extract meta (`getMeta()`), headers H1-H5 (`getHeaders()` → node text), title, text
  (`getText()` strips `script`/`style` then `strip_tags`), and image alt stats (`getImages()`).
- `Analyzer::analyze()` iterates metrics from `MetricFactory` and `formatResults()` each into
  `{analysis, name, description, value, negative_impact}`. `FileRobots`/`FileSitemap` values are passed
  through `Html::escape()`; other metric values are not escaped here.
- Metric classes live under `src/Analyzer/Metric/**` (Page/*, File/*, Url/*, Keyword*/*), each extending
  `AbstractMetric`; `Factor.php` enumerates factor keys. `getFilesMetrics()` fetches
  `scheme://host/robots.txt` and `/sitemap.xml` from the same (trusted) host.

## HTTP client

`src/Analyzer/HttpClient/Client.php` — thin Guzzle wrapper. Default options `allow_redirects => FALSE`;
User-Agent `grgk-seo-analyzer/1.0`. Failures raise `HttpException`. (Note: the default `timeout` is
nested under `headers` rather than top-level — a cosmetic bug.)

## Templates & theme

`ai_seo_link_advisor_theme()` (in `.module`) registers `page_ai_seo_link_advisor`,
`table_content_analytics`, `table_general_analytics`, `table_keyword_analytics`,
`page_ai_seo_link_advisor_error`. Templates render the metric values, the AI recommendation strings, and
status icons (`icons/checked.png` / `warning.png` / `action.png`). The details titles use `t('… @url',
['@url' => $url])` (placeholder-escaped). CSS from library `ai_seo_link_advisor/styling`
(`css/ai-seo-link-advisor.css`). Bundled stopwords: `stopwords/en.yml`, `nl.yml`, `pl.yml`.
