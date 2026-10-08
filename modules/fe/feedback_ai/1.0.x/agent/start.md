<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feedback AI (feedback_ai) — agent index

Sentiment analysis for user feedback. A public form collects a message; on submit the text is sent
to the OpenAI Chat Completions API, the returned label (Positive / Negative / Neutral) is stored in
the `feedback_ai` table with the submission, and admins review results through a shipped View plus a
pie-chart block.

## Facts
- **Machine name:** `feedback_ai` · **Version dir:** 1.0.x (installed 1.0.4, stable)
- **Core:** `^9 || ^10 || ^11` · **License:** GPL-2.0-or-later
- **Dependency (module):** `views_data_export` (required — the CSV export display).
- **Configure route:** `feedback_ai.feedback_api_settings` (`/admin/config/feedbackopenai/settings`).
- **Permission:** `administer feedback ai` (restrict access) — gates config, the pricing modal, and the submissions View.
- **Storage:** custom DB table `feedback_ai` (no entity); schema in `feedback_ai.install`.
- **No Drush commands. No config schema shipped. No custom plugin types.**

## What it provides
- **Routes** (`feedback_ai.routing.yml`): `feedback_ai.content` (`/feedback-ai`, the form page),
  `feedback_ai.feedback_api_settings` (settings form), `feedback_ai.feedback_admin_config_openai`
  (admin menu block), `feedback_ai.modal` (`/feedback-price-structure`, pricing modal).
- **Config form:** `Form\FeedbackAiSettingForm` → `feedback_openai.settings` (secret key, endpoint, model, max tokens).
- **Public form:** `Form\FeedbackAIForm` (id `feedback_ai_form`), rendered by `Controller\FeedbackAIController::content`.
- **Blocks** (`src/Plugin/Block/`): `feedback_ai_block` (FeedbackAIBlock, the form) and
  `feedback_ai_chart_block` (SentimentChartBlock, the CanvasJS pie chart).
- **Service:** `feedback_ai.openai_client` → `FeedbackOpenAIClient` (Guzzle client, `analyzeSentiment()`).
- **Views:** `hook_views_data()` registers the `feedback_ai` base table; shipped View
  `views.view.feedback_ai_submissions` (page `/feedback-ai-submissions`, block, CSV data-export);
  two date filter plugins in `src/Plugin/views/filter/`.
- **Templates:** `feedback-ai-block.html.twig`, `sentiment-chart.html.twig`, `feedback-ai-price-modal.html.twig`.

## Solution docs
- [Settings form & OpenAI credentials](config/settings-and-key.md)
- [Feedback form, controller & storage](forms/feedback-form.md)
- [OpenAI client service](api/openai-client.md)
- [Blocks: feedback form & sentiment chart](blocks/blocks.md)
- [Submissions View, filters & CSV export](views/submissions.md)
