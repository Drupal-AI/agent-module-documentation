<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenAI client service

Class: `Drupal\feedback_ai\FeedbackOpenAIClient`. Service id: `feedback_ai.openai_client`
(`feedback_ai.services.yml`).

## Construction
The constructor reads four values from `feedback_openai.settings` via the config factory:
`feedbackai_secret_key` → `$apiKey`, `feedbackai_endpoint` → `$endpoint`,
`feedbackai_api_model` → `$apiModel`, `feedbackai_api_max_token` → `$apiMaxToken`. It instantiates a
plain `new \GuzzleHttp\Client()` (default TLS certificate verification applies).

> Note: `services.yml` declares two arguments (`@config.factory`, `@logger.factory`), but the
> constructor signature accepts only the config factory; the extra argument is ignored.

## `analyzeSentiment($messages): array`
POSTs to `$endpoint` with:
- Headers: `Content-Type: application/json`, `Authorization: Bearer <apiKey>`.
- JSON body: `model` = configured model, `messages` = the passed chat array, `temperature` = 2,
  `max_tokens` = `(int) $apiMaxToken`, `top_p` = 1, `frequency_penalty` = 0, `presence_penalty` = 0.

Returns `['data' => <decoded JSON|null>, 'status_code' => <int>]`. On a Guzzle `RequestException` it
logs via `DeprecationHelper::backwardsCompatibleCall()` (`Error::logException` on 10.1.0+, else
`watchdog_exception`) to channel `feedback_ai_sentiment_response` and returns `data => null` with the
exception code as the status.

Callers pass a `messages` array shaped like OpenAI chat turns; `FeedbackAIForm::submitForm()` sends a
system instruction constraining the reply to `Positive`/`Negative`/`Neutral` plus the user's text,
then reads `data.choices[0].message.content`.
