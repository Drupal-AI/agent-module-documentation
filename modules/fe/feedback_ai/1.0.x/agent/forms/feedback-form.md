<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feedback form, controller & storage

## Form
Class: `Drupal\feedback_ai\Form\FeedbackAIForm` (extends `FormBase`). Form id: `feedback_ai_form`.

Fields (`buildForm()`): `name` (textfield, required), `email` (email, required), `feedback`
(textarea, required, class `comment-analysis`), and a submit button "Send Message". The form is
wrapped in `<div class="sentiment-feedback-content">`. `hook_form_alter()` attaches the
`feedback_ai/feedback_ai_css` library to every form.

Injected services (`create()`): `feedback_ai.openai_client`, `messenger`, `email.validator`,
`database`, `current_user`, `logger.factory`.

### validateForm()
Validates the email address with `email.validator` (`isValid()`); sets an error on `email` if invalid.

### submitForm()
1. Trims the feedback text; reads `name`, `email`, and the current user id (`currentUser->id()`).
2. Builds an OpenAI chat message array — a system message ("Do not return any other output other
   than Positive, Negative or Neutral") plus the user's feedback text.
3. Calls `openAiClient->analyzeSentiment($messages)` (see [api/openai-client.md](../api/openai-client.md)).
4. On HTTP 200 with `choices[0].message.content` present, inserts a row into the `feedback_ai` table
   (`uid`, `sentiment_text`, `sentiment_result` = the model's label, `created` = `time()`, `name`,
   `email`) using the parameterized `Connection::insert()` builder, then shows "Thank you for your
   feedback!".
5. On a missing/invalid response it logs to channel `feedback_ai_invalid_response` and shows an error.
6. On a non-200 status it surfaces the API error message (429 → a quota message).
7. DB failures are caught and logged to channel `feedback_ai_store_feedback`.

## Page controller
`Drupal\feedback_ai\Controller\FeedbackAIController::content()` builds `feedback_ai_form` via the form
builder and sets `#cache['max-age'] = 0`. Route `feedback_ai.content` → path `/feedback-ai`, title
"Feedback AI Form", requirement `_permission: 'access content'`. Also exposed as a local task/menu
link under Content (`feedback_ai.links.task.yml`, `feedback_ai.links.menu.yml`).

## Storage schema (`feedback_ai.install`)
Table `feedback_ai` created by `feedback_ai_schema()`, dropped on uninstall:

| Column | Type | Notes |
|--------|------|-------|
| `id` | serial | primary key |
| `uid` | int | indexed; submitting user id |
| `name` | varchar(255) | |
| `email` | varchar(255) | |
| `sentiment_text` | text | the submitted feedback |
| `sentiment_result` | varchar(255) | model label (Positive/Negative/Neutral) |
| `created` | int | Unix timestamp, default 0 |

The form can also be embedded as a block — see [blocks/blocks.md](../blocks/blocks.md).
