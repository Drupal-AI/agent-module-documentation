<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blocks: feedback form & sentiment chart

Two block plugins ship in `src/Plugin/Block/`. Both implement `ContainerFactoryPluginInterface`.

## Feedback form block
`Drupal\feedback_ai\Plugin\Block\FeedbackAIBlock` — id `feedback_ai_block`,
admin label "Feedback AI Form", category "Custom". `build()` renders `feedback_ai_form` via the
form builder inside a container (class `feedback-ai-block`) using the `feedback_ai_block` theme hook.
Place it in any region through Structure > Block layout to expose the feedback form off the
`/feedback-ai` page. Template: `templates/feedback-ai-block.html.twig` (prints `elements.content`).

## Sentiment chart block
`Drupal\feedback_ai\Plugin\Block\SentimentChartBlock` — id `feedback_ai_chart_block`,
admin label "Feedback AI Chart". Injects `database`. `getCacheMaxAge()` returns 0.

`build()`:
- `getFeedbackData()` selects the 10 most recent rows from `feedback_ai`
  (`sentiment_text`, `sentiment_result`, `created`, ordered by `created` DESC) with the query builder.
- `prepareDataPoints()` counts rows whose `sentiment_result` equals `Positive`, `Neutral`, or
  `Negative` and converts the counts to percentages, returning three `{label, y}` points.
- When there is data it returns `#theme => 'sentiment_chart'` and attaches the
  `feedback_ai/feedback_ai_canvas` (external CanvasJS) and `feedback_ai/feedback_ai_charts`
  libraries, passing the points as `drupalSettings.FeedbackAi.dataPoints`. When empty it returns a
  "No Sentiment Result Available" message.

Template `templates/sentiment-chart.html.twig` renders `<div id="chartContainer">`;
`js/feedback_ai.js` (behavior `sentimentChart`) reads `drupalSettings.FeedbackAi.dataPoints` and draws
a CanvasJS pie chart titled "Sentiment Rating".

## Programmatic render + auto-injection
`Controller\FeedbackAIBlockController::renderCustomBlock()` builds the chart block inside a
`feedback-ai-chart-container` container. `hook_preprocess_views_view()` also auto-injects the
`feedback_ai_chart_block` into the header of the `feedback_ai_submissions` View (displays `page_1`
and `block_1`), so the chart appears above the submissions table.

Libraries (`feedback_ai.libraries.yml`): `feedback_ai_css` (theme CSS), `feedback_ai_canvas`
(external `canvasjs.min.js`), `feedback_ai_charts` (the module JS; depends on core/drupal, jquery, once).
