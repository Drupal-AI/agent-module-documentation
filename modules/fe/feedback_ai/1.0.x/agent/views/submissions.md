<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submissions View, filters & CSV export

## Views base table
`hook_views_data()` (`feedback_ai.module`) registers the `feedback_ai` table as a Views base
(base field `id`, group "Feedback AI") with fields: `id` (numeric), `uid` (with a standard
relationship to `users_field_data`), `name`, `email`, `sentiment_text` ("Feedback"),
`sentiment_result` ("Sentiment Rating"), and `created` (date, exposed date filter). All text fields
use standard/string handlers; `created` uses the date field/sort/filter.

## Shipped View
`config/install/views.view.feedback_ai_submissions.yml` — id `feedback_ai_submissions`, base table
`feedback_ai`. Access is **`type: perm` with `perm: 'administer feedback ai'`** on the default
display. Displays:
- **page_1** — path `/feedback-ai-submissions`, menu item under Content ("Feedback AI Submissions").
- **block_1** — a block display of the same listing.
- **data_export_1** — a Views Data Export CSV display at path `feedback-ai/submission/export`
  (filename `feedback_ai_submissions.csv`); the default display header shows an "Export to CSV" link
  to it. This is why the module depends on `views_data_export` (config also references
  `csv_serialization`, `rest`, `serialization`).

Table columns: ID, Name, Email, Feedback (`sentiment_text`), Sentiment Rating, Submitted on,
Submitted By (the related user name). Pager: 10/page. Footer contains a "View Pricing & Usage
Structure" modal link (`use-ajax`) to `/feedback-price-structure`.

## Exposed filters
- **sentiment_result** — exposed string filter. `hook_form_views_exposed_form_alter()` replaces it on
  the `feedback_ai_submissions` exposed form with a select (ALL / Positive / Negative / Neutral).
- **created** — exposed date filter.

## Date filter plugins
`src/Plugin/views/filter/FeedbackAiDateBase.php` (abstract, extends `NumericFilter`) and
`FeedbackAiDateTimestamp.php` (final) provide an improved date/timestamp filter modeled on the core
datetime filter, adding datepicker value widgets and converting input to a Unix timestamp
(`processValue()` → `DrupalDateTime::format('U')`). `hook_views_plugins_filter_alter()` swaps the core
`date` filter class for `FeedbackAiDateTimestamp`. Query building (`opBetween()`/`opSimple()`) uses
`addWhereExpression()` with the processed timestamp values.

## Pricing modal
`Controller\PriceModelController::modal()` returns `#theme => 'feedback_ai_price_modal'`
(`templates/feedback-ai-price-modal.html.twig`, a static pricing reference table). Route
`feedback_ai.modal` (`/feedback-price-structure`) requires `_permission: 'administer feedback ai'`.
