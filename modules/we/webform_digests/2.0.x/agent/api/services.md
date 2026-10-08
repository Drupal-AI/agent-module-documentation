# Services, queue worker, mail, tokens and hooks (API)

The pipeline is: **queue builder** enqueues one job per digest → **queue worker** loads/filters
submissions and groups them by source entity → **mail handler** token-replaces the digest and
sends one email per group.

## Queue builder — `webform_digests.queue_builder`

`Drupal\webform_digests\WebformDigestsQueueBuilder` (args: `entity_type.manager`, `queue`,
`config.factory`).

```php
$count = \Drupal::service('webform_digests.queue_builder')->queueSubmissions();
// Or with an explicit window (timestamps):
$count = \Drupal::service('webform_digests.queue_builder')->queueSubmissions($startTs, $endTs);
```

- `queueSubmissions($startDate = NULL, $endDate = NULL)` — loads **all** `webform_digest`
  entities; for each, pushes one item to queue `webform_digest_queue` with payload
  `['digest' => $digest, 'start' => $start, 'end' => $end]`. Returns the number of digests queued
  (0 if none exist).
- `$endDate` defaults to `time()`; `$startDate` defaults to
  `strtotime('- 1 ' . cron.frequency, $endDate)`. Note the same computed `$startDate` is reused for
  every digest within one call (it is set on the first loop iteration and not reset).

## Queue worker — plugin `webform_digest_queue`

`Plugin\QueueWorker\WebformDigestQueue` (`cron = {"time" = 30}`; DI: `config.factory`,
`logger.factory`, `entity_type.manager`, `webform_submission.conditions_validator`,
`webform_digests.mail_handler`). `processItem($data)`:

1. Query `webform_submission` where `changed BETWEEN [start, end]` **and** `webform_id =
   $digest->getWebform()`. The query runs with **`accessCheck(FALSE)`** (system context — digests
   are built for the admin-configured recipient regardless of any viewing user).
2. `loadRelevantSubmissions()` — loads the submissions; if the digest `isConditional()`, keeps only
   those passing `conditionsValidator->validateConditions()` for the first state group.
3. `getSubmissionsBySourceEntity()` — buckets submissions by `$submission->getSourceEntity()->id()`;
   submissions with **no** source entity are excluded.
4. For each source-entity bucket: `setSubmissions($submissions)` on the digest, then
   `mail_handler->sendMessage($digest, $firstSubmission->getSourceEntity())`. One email per bucket.
5. Logs `@sent webform digest email(s) sent.` (or "No webform digest emails sent.").

## Mail handler — `webform_digests.mail_handler`

`Drupal\webform_digests\WebformDigestsMailHandler` implements `WebformDigestsMailHandlerInterface`
(args: `plugin.manager.mail`, `token`, `language_manager`).
`sendMessage(WebformDigestInterface $digest, ?EntityInterface $entity)`:

- Builds `$tokenData = ['webform_digest' => $digest]` and, if `$entity` is set, adds it keyed by its
  entity type id (e.g. `'node' => $node`).
- Token-replaces `recipient` → `to`, `originator` → `from`, `subject`, and `body`.
- Calls `mailManager->mail('webform_digests', 'digest', $to, $langcode, $message, $from)`.

`hook_mail('digest', …)` (`webform_digests_mail()`) sets `$message['subject'] = $params['subject']`
and `$message['body'][] = MailFormatHelper::htmlToText($params['body'])` — i.e. the body is
**flattened to plain text** before sending. Combined with the fact that
`[webform_digest:submissions]` renders only submission **labels** through
`renderer->renderPlain()` (autoescaped `item_list`), the email carries no unescaped submission
field markup.

## Controller & route — `webform_digests.send`

`Controller\DigestController::sendAction` (perm `send webform digest`) just calls
`queueSubmissions()` and returns `new JsonResponse(['queued' => $count])`. It exposes no digest
content and takes no request input.

## Route context provider — `webform_digests.webform_route_context`

`ContextProvider\WebformDigestRouteContext` (tagged `context_provider`). Exposes the
`{webform_digest}` route parameter as an entity context named `webform_digest` (cache context
`route`) on routes that declare that parameter — used so blocks/plugins can target the current
digest.

## Tokens — type `webform_digest`

Defined in `webform_digests.tokens.inc` (`needs-data: 'webform_digest'`):

| Token | Value |
|---|---|
| `[webform_digest:id]` | `$digest->id()` |
| `[webform_digest:label]` | `$digest->label()` |
| `[webform_digest:subject]` | `$digest->getSubject()` |
| `[webform_digest:submissions]` | Rendered `item_list` of each included submission's `label()`. |
| `[webform_digest:submissions_count]` | `count()` of the included submissions. |

The submission set is the transient one set by the queue worker via `setSubmissions()` before token
replacement; outside a send it is empty.

## Drush

`Commands\WebformDigestsCommands::queueDigests()` → command **`webform:queue-digests`** ("queue
digest email(s)"). Legacy Drush-8 hook (`webform_digests.drush.inc`): command `queue-digests` /
callback `drush_webform_digests_queue_digests()`. Both call `queueSubmissions()`.

## Hooks implemented

- `hook_cron` — the scheduling gate (see [../configure/scheduling.md](../configure/scheduling.md)).
- `hook_mail` — key `digest`, plain-texts the body.
- `hook_entity_operation` — adds a **Conditions** operation to each `webform_digest` row.
- `hook_token_info` / `hook_tokens` — the `webform_digest` token type above.
