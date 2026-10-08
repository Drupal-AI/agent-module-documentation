<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Detection engine, hook flow & event

## Hook flow — `Hook\AiWebformGuardFormHooks`

`#[Hook('webform_submission_form_alter')]` runs on every Webform submission form:
- If `human_iteration` is on, adds a hidden checkbox `spam_confirm` (`#access => FALSE`) and calls
  `SpamDetectionService::revealHumanConfirmationCheckbox()` to re-show it after a prior spam hit.
- Appends `$this->validateSubmission` to `$form['#validate']`.

`validateSubmission()` (the validation handler):
1. Returns early unless the form object entity is a `WebformSubmissionInterface`, or if the form
   already `hasAnyErrors()`.
2. Loads per-Webform `excluded_fields` / `custom_prompt` from `ai_webform_guard.fields_settings`.
   Submission data = `$submission->getData()` (falls back to `$form_state->getValues()`).
3. Human-iteration short-circuits (see below) via `isHumanConfirmationGranted()` /
   `hasMatchingHumanConfirmationGrant()`.
4. Calls `SpamDetectionService::detectSpam($data, [...])`; on `flood_blocked` sets a rate-limit
   error. If a `spam_confirmation_flow` is enabled and the Webform has an `email_confirmation`
   handler, toggles that handler's `status` **for this request only** (not saved) instead of
   erroring. Otherwise, on spam, calls `handleSpamDetection()`.

## `Service\SpamDetectionService` (`ai_webform_guard.spam_detection`)

`detectSpam(array $data, array $options): array` — options: `excluded_fields`, `custom_prompt`,
`max_words` (default 500), `form_id`. Order of operations:
1. **Whitelist**: `clientIpIsWhitelisted()` — `PathMatcher::matchPath(clientIp, whitelist)`; match →
   returns `['is_spam' => FALSE, 'whitelisted' => TRUE]`, no AI call.
2. **Flood** (if `flood_control`): key `'ai_webform_guard_' . sha1(form_id)`; `flood->isAllowed(key,
   threshold, window)`. Over limit → `['is_spam' => TRUE, 'flood_blocked' => TRUE]`, no AI call, logs
   a notice with the client IP.
3. **Provider**: `ProviderHelper::getSetProvider()` (throws `RuntimeException` if none).
4. **Prompt**: base = `custom_prompt` or config `prompt`, plus a hard-coded instruction to reply
   with JSON `{"is_spam", "probability" 0-100, "reason"}`.
5. **Payload**: `collectFormData()` flattens `key: value` lines, skipping excluded fields, the
   standard Form API keys (`submit, form_build_id, form_id, op, form_token, actions`), any key
   starting `#`/`form_`, and empty values; `truncateToMaxWords()` caps length.
6. **Call**: `ChatInput` with a `system` (prompt) and `user` (submission wrapped in
   `=== BEGIN/END FORM SUBMISSION DATA ===` markers) message → `$provider->chat($input, $model)`.
   All transport/TLS/keys are the AI module's; no HTTP here.
7. **Parse** `parseAiJson()`: trims Markdown code fences, `json_decode`, requires an array. Verdict:
   prefer numeric `probability` ≥ `spam_probability_threshold`; else fall back to boolean `is_spam`
   (mapped to 90/10); else throw. Any exception → logged error and `['is_spam' => FALSE, 'error' =>
   TRUE]` (fail-open so a provider outage does not block legitimate users).

`handleSpamDetection(...)`: registers the flood event, dispatches `SpamDetectedEvent`, sets the
form error to `error_message` (or default), opens the human-confirmation checkbox, and logs the
attempt when `log_spam_attempts`.

## Human iteration (confirmation) grant

When `human_iteration` is on, a flagged user can tick `spam_confirm` to submit anyway. The grant is
bound to the exact payload: `fingerprintSubmissionData()` = `sha256(json_encode(normalizeGrantData))`
where `normalizeGrantData()` strips Form API/confirm keys, trims, and `ksort`s recursively. The
fingerprint is stored in form state (`form_state->setCached()`) and re-checked with `hash_equals()`
in `hasMatchingHumanConfirmationGrant()`; only a matching payload **plus** a checked box
(`isHumanConfirmationGranted()`) skips the AI. Editing the content invalidates the grant and forces
a fresh AI check.

## `Service\ProviderHelper` (`ai_webform_guard.provider`)

`getSetProvider(): ?array` — if `ai_model` config is set, resolves it via
`AiProviderPluginManager::loadProviderFromSimpleOption()` + `getModelNameFromSimpleOption()`;
otherwise `getDefaultProviderForOperationType('chat_with_complex_json')`. Returns
`['provider_id' => <instance>, 'model_id' => <string>]` or `NULL`.

## `Event\SpamDetectedEvent`

Name `ai_webform_guard.spam_detected` (const `EVENT_NAME`). Dispatched on every confirmed spam block
with getters `getFormId()`, `getFormData()`, `getResponseText()` (raw AI text), `getClientIp()`.
Subscribe to notify, tag, or ban on spam.
