# Admin Feedback — voting endpoints, storage & events

All logic lives in `AdminFeedbackController` and `AdminFeedbackAjaxForm`. Data is in two custom
tables, not entities.

## Storage (`hook_schema`)

- `admin_feedback`: `id, nid, langcode, created, feedback_type (0=no,1=yes), feedback_message, inspected`.
- `admin_feedback_score`: `id, nid, langcode, count, yes_count, no_count, total_score` (0–100,
  `round(yes/count*100)`).

## Vote flow — `POST /feedback_vote` (`give feedback`)

`AdminFeedbackController::adminFeedbackVoteReceiver()` reads `vote`, `node_id`, `feedback_token`:

1. `vote` must be exactly `yes` or `no` (else 400).
2. `node_id` must be numeric and load an existing node (else 400).
3. `feedback_token` must equal `signNodeVoteToken(nid)` — an HMAC
   (`Crypt::hmacBase64('admin_feedback_vote:'.$nid, Settings::getHashSalt())`) rendered into the
   block as `data-feedback-token`; missing/forged → 403. This forces a vote to originate from a
   fetched page.
4. Flood check `admin_feedback.vote` against `feedback_flood.limit`/`window` (default 20/3600s per
   IP) → 429 when exceeded.
5. Dispatches `VoteEvent`, inserts the feedback row (message NULL), updates/inserts the score row,
   registers the flood event, returns a JSON body containing a **signed feedback-id token**
   (`<id>:<hmac>`) the client uses to attach a comment.

## Comment flow — `/ajax/feedback_vote` (`give feedback`)

`AdminFeedbackAjaxForm` (rendered inside the block). On submit `updateFeedback($feedback_id,$msg)`:
- Requires a non-empty message.
- `verifyFeedbackId()` validates the `<id>:<hmac>` token (domain-separated from the vote token);
  forged/missing → reject.
- Only sets the message if the row exists **and** currently has no message (one comment per row).

## Admin state changes

- `POST /feedback_inspected_check` / `/feedback_inspected_uncheck` (`view admin feedback detail view`)
  → `markInspected()` / `markUnInspected()` toggle the `inspected` flag by `feedback_id`.
- Delete forms: `/admin/content/feedback/{id}/delete` (`delete feedback`),
  `/admin/content/feedback/delete-all/{id}` (`delete all node feedback`).

## CSV export (`export feedback data`)

`/export_feedback` builds a Batch (`feedback_batch_size` rows per chunk) writing
`temporary://feedback_export.csv` (UTF-8 BOM, columns Nr,URL,Created,Feedback,Message,Inspected),
then redirects to `/admin/feedback/download` which streams and `unlink`s the file. Messages have
quotes stripped (`str_ireplace(['"',"'"],'',…)`) but are otherwise the raw stored comment.

## React to votes — `VoteEvent`

```php
use Drupal\admin_feedback\Event\VoteEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyVoteSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [VoteEvent::VOTE_EVENT => 'onVote']; // 'event_subscriber.vote'
  }
  public function onVote(VoteEvent $event): void {
    $nid = $event->getNid();      // int node id
    $vote = $event->getVote();    // 'yes' | 'no'
    // ... custom analytics / side effects ...
  }
}
```

Dispatched in `adminFeedbackVoteReceiver()` before the row is written. Also: `hook_node_delete` /
`hook_node_translation_delete` remove a node's feedback and score rows automatically.
