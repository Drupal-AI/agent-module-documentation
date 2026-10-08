<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, permissions, the results dashboard and the settings form

## Routes & permissions (`ai_webform_sentiment.routing.yml`)

| Route | Path | Access | Purpose |
|-------|------|--------|---------|
| `ai_webform_sentiment.dashboard` | `/admin/structure/webform/manage/{webform}/results/sentiment` | `_permission: access webform results` | The per-webform Sentiment charts tab |
| `ai_webform_sentiment.settings_form` | `/admin/config/system/ai-webform-sentiment` | `_permission: administer ai webform sentiment` | Module settings placeholder |

- The dashboard route takes an `entity:webform` param (`{webform}`) and is added as a **local task**
  under the webform Results tab (`links.task.yml`, `parent_id: entity.webform.results`, title
  *"Sentiment"*). It is **read-only** (a GET that only runs SELECTs).
- The settings link also appears under **Configuration → System** (`links.menu.yml`).
- Permission `administer ai webform sentiment` is defined in `.permissions.yml` with
  `restrict access: true`. `access webform results` is Webform's own permission.

## The dashboard controller

`src/Controller/SentimentDashboardController.php` → `dashboard(Webform $webform)`
(services `@database`, `@entity_type.manager`). It computes a **one-month** window
(`now` … `now - 1 month`) and runs several aggregate SELECTs against `ai_webform_sentiment`, all
scoped `condition('webform_id', $webform->id())` via the query builder (parameterised):

- distinct `sentiment` values in range;
- `AVG(sentiment)` → `average_sentiment`, rounded and rendered as `number_format(…,2) . ' / 5'`
  (the `/ 5` label is fixed regardless of your prompt's scale);
- daily `AVG(sentiment)` grouped by `DATE(datetime)`;
- per-value `COUNT(sentiment)` grouped by `sentiment`;
- then, per day in the window, a per-sentiment `COUNT(*)` (a nested loop of queries — the author
  flags in the project page that this is not load-tested for large result sets).

Output: a render array with `#theme => 'ai_webform_sentiment_dashboard'` (registered in
`hook_theme`, template `templates/ai-webform-sentiment-dashboard.html.twig`), attaching library
`ai_webform_sentiment/dashboard` and pushing the chart series into
`drupalSettings.ai_webform_sentiment` (`days`, `daily_averages`, `sentiment_totals`, and
`data_N`/`label_N` per sentiment value, plus `sentiment_count`). Stored sentiments are integers, so
labels are numeric.

## The dashboard JS & library

- Library `dashboard` (`ai_webform_sentiment.libraries.yml`): `css/dashboard.css`,
  `js/sentiment-dashboard.js`, deps `core/jquery`, `core/drupal`, `core/drupalSettings`,
  **`chartjs_api/chartjs`** (Chart.js comes from the `chartjs_api` module — this module bundles no
  chart library itself).
- `Drupal.behaviors.aiWebformSentimentDashboard` reads `drupalSettings.ai_webform_sentiment` and
  draws three `new Chart(...)` canvases keyed by `webform_id`: a daily-average **line** trend
  (y-axis fixed 0–5), a per-value distribution **line** chart, and a totals **bar** chart with a
  fixed colour map for values `0`–`5`.

## The settings form

`src/Form/SettingsForm.php` extends `ConfigFormBase`, form id `ai_webform_sentiment_settings`,
editable config **`ai_webform_sentiment.settings`**. As shipped it renders only an empty *"General
Settings"* details element and saves the (empty) config on submit — a placeholder for future
options. **No `config/schema` or `config/install` is shipped**, so the config object has no defined
keys yet. All meaningful configuration (prompt, model) lives on the **handler**, not here — see
[../plugins/sentiment-handler.md](../plugins/sentiment-handler.md).

## Quick start

1. `drush en ai_webform_sentiment` (pulls in `ai`, `webform`, `chartjs_api`). Configure an AI
   provider/model in the AI module first.
2. On a webform: **Handlers → Add handler → Sentiment Analysis**; pick a model (or leave default)
   and adjust the prompt (keep `[submission]`).
3. Submit the form, then run **cron** (or `drush aisq`).
4. Open the webform's **Results → Sentiment** tab to see the charts.
