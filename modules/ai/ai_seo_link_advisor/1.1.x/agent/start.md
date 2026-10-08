<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI SEO Link Advisor (ai_seo_link_advisor) — agent index

A single form that fetches an **internal** site URL, computes SEO metrics from its HTML, and asks the
configured **drupal/ai** chat provider for a fix per flagged metric. Results render as two collapsible
analytics tables.

- Package **SEO**. Core `^10.1 || ^11`. Dependency **`ai:ai`** (composer `drupal/ai ^1.0`).
- **One route** `ai_seo_link_advisor.analyzer_form` → `/ai-seo-link-advisor-form`, `_permission:
  'access seo analyzer'`. **One permission** `access seo analyzer` (not restrict-access).
- No config entity / config schema; the AI provider+model is the AI module's **site-default chat**
  option, and the host allowlist is `trusted_host_patterns` from `settings.php`. No Drush.

## What it provides

- **Form** `Form/AiSeoLinkAdvisorForm` (`ai_seo_link_advisor_form`). `validateForm()` enforces: valid
  URL, `http`/`https` only, host must `preg_match` a `trusted_host_patterns` entry, path must resolve to
  a routed page (`Url::fromUserInput`→`isRouted()`), `->access()` must pass, and the route must not be
  `_admin_route` / `/admin*`. `submitForm()` → `AiSeoLinkAdvisor::analyze($url)` → renders markup into an
  AJAX-replaced wrapper. Submit is disabled when `trusted_host_patterns` is unset.
- **Service** `AiSeoLinkAdvisor` (`ai_seo_link_advisor`): runs `Analyzer::analyzeUrl()`, builds the
  content/general analytics render arrays, and for each negative-impact metric calls
  `generateAiRecommendations()` → `$ai_provider->chat(new ChatInput([...]), $model)` through the
  **drupal/ai** abstraction (site-default chat provider; system prompt is a built-in SEO-expert string).
- **Analyzer pipeline** under `src/Analyzer`: `Analyzer` + `Page` + `Parser` (`DOMDocument`) + a
  `Metric/` tree via `MetricFactory` (Page.* and File.* metrics: meta, headers, content ratio, alts,
  URL length, SSL, redirect, content size, load time, robots.txt, sitemap.xml, plus keyword-* metrics).
  HTTP fetch via `Analyzer/HttpClient/Client` (Guzzle, `allow_redirects => FALSE`, default TLS verify).
- **Theme** `ai_seo_link_advisor_theme()` (in `.module`): `page_ai_seo_link_advisor`,
  `table_content_analytics`, `table_general_analytics`, `table_keyword_analytics`,
  `page_ai_seo_link_advisor_error`; templates in `templates/`. **Hook** `Hook/AiSeoLinkAdvisorHooks`
  (`hook_help`). CSS library `ai_seo_link_advisor/styling`. Stopwords in `stopwords/{en,nl,pl}.yml`.

## Docs

- Route/permission/validation, the metric pipeline, the AI recommendation flow, templates → [config/analyzer.md](config/analyzer.md)

## Mechanism (one line)

`access seo analyzer` user posts a URL → validated to a trusted-host, access-checked, non-admin internal
page → Guzzle GET → `Parser`/`Metric` produce results → negative metrics → drupal/ai `chat()` → rendered
in `table_content_analytics` / `table_general_analytics`. No config entity; no direct provider HTTP.
