<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Feedback — voting endpoints, storage & events

All logic lives in `AdminFeedbackController` (`src/Controller/AdminFeedbackController.php`) and
`AdminFeedbackAjaxForm` (`src/Form/AdminFeedbackAjaxForm.php`). Data is in two custom tables, not
entities (see `admin_feedback_schema()` in `admin_feedback.install`).

## Storage

- `admin_feedback`: `id, nid, langcode, created, feedback_type` (0 = no, 1 = yes),
  `feedback_message`, `inspected`.
- `admin_feedback_score`: `id, nid, langcode, count, yes_count, no_count, total_score`
  (0-100, `round(yes_count / count * 100)`).

## Vote flow — `POST /feedback_vote` (`give feedback`)

`AdminFeedbackController::adminFeedbackVoteReceiver()` reads `vote`, `node_id`, `feedback_token`
from the POST body:

1. `vote` must be exactly `yes` or `no` (strict `in_array`), else 400.
2. `node_id` must be `ctype_digit` and load an existing node, else 400.
3. `feedback_token` must equal `signNodeVoteToken($nid)` — an HMAC
   `Crypt::hmacBase64('admin_feedback_vote:' . $nid, Settings::getHashSalt())` rendered into the
   block as `data-feedback-token`; missing/mismatched → 403 (compared with `hash_equals`).
4. Flood check on `admin_feedback.vote` against `feedback_flood.limit` / `window` (default
   20 / 3600s) → 429 when exceeded.
5. Dispatches `VoteEvent`, calls `insertFeedback()` (row with `feedback_message` = NULL) and
   `insertScore()` / `updateScore()`, registers the flood event, and returns a JSON array whose
   element is a **signed feedback-id token** `"<id>:<hmac>"` (`signFeedbackId()`), used to attach a
   comment.

## Comment flow — `/ajax/feedback_vote` (`give feedback`)

`AdminFeedbackAjaxForm` is rendered inside the block. Its `#ajax` callback `validateFeedbackMsg()`
reads `feedback_id` (the signed token) and `feedback_message`, then calls
`AdminFeedbackController::updateFeedback($feedback_id, $feedback_message)`:

- A non-empty message is required.
- `verifyFeedbackId()` validates the `"<id>:<hmac>"` token with `hash_equals` (domain-separated
  from the vote token); missing/mismatched → returns FALSE.
- The message is written only if the row exists **and** has no message yet (one comment per row).
- On success an Ajax `ReplaceCommand` shows `final_response`; otherwise an `HtmlCommand` warning.

The block builds each stored setting into `drupalSettings` with `Html::escape()` for the yes/no
responses and `check_markup()` for `custom_text_response_on_no` (see
`AdminFeedbackBlock::build()`).

## Admin state changes

- `POST /feedback_inspected_check` / `/feedback_inspected_uncheck`
  (`view admin feedback detail view`) → `markInspected()` / `markUnInspected()` toggle the
  `inspected` flag for the posted `feedback_id`. Fired by `js/feedback_dashboard.js` when the
  per-row checkbox is toggled.
- Delete confirm forms: `/admin/content/feedback/{id}/delete`
  (`AdminFeedbackDeleteForm`, `delete feedback`) recomputes the node score after removing one row;
  `/admin/content/feedback/delete-all/{id}` (`AdminFeedbackDeleteAllNodeForm`,
  `delete all node feedback`) removes all rows and the score for a node. Both `id` route params are
  constrained by `id: ^\d+$`.

## CSV export (`export feedback data`)

`/export_feedback` (`exportDbFeedback()`) builds a Batch of `feedback_batch_size` rows per chunk
(`processChunk()`), writing `temporary://feedback_export.csv` with a UTF-8 BOM and header
`Nr,URL,Created,Feedback,Message,Inspected`. Each row's node URL is resolved with
`Url::fromRoute('entity.node.canonical', …)`; each cell is passed through `escapeCsvCell()`, which
prefixes an apostrophe to any value beginning with a spreadsheet formula/control character
(`= + - @` tab CR) before `fputcsv()`. The batch finishes by redirecting to
`/admin/feedback/download` (`downloadCsv()`), which streams the file as
`feedback_data.csv` (`text/csv`) and then `unlink`s it.

## React to votes — `VoteEvent`

```php
use Drupal\admin_feedback\Event\VoteEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyVoteSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [VoteEvent::VOTE_EVENT => 'onVote']; // 'event_subscriber.vote'
  }
  public function onVote(VoteEvent $event): void {
    $nid = $event->getNid();   // int node id
    $vote = $event->getVote(); // 'yes' | 'no'
    // ... custom analytics / side effects ...
  }
}
```

Dispatched in `adminFeedbackVoteReceiver()` before the row is written. `hook_node_delete` /
`hook_node_translation_delete` (in `admin_feedback.module`) remove a node's feedback and score rows
automatically. `hook_views_pre_view` / `hook_preprocess_views_view_table` /
`hook_views_query_alter` add the `feedback_cache_tags` cache tag and per-language score totals to
the dashboards.
