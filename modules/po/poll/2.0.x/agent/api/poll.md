<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Programmatic API

## Create a poll with choices

```php
use Drupal\poll\Entity\Poll;
use Drupal\poll\Entity\PollChoice;

$poll = Poll::create([
  'question' => 'What is your favorite season?',
  // Pass unsaved PollChoice entities; Poll::preSave() saves them and fills target_id.
  'choice' => [
    PollChoice::create(['choice' => 'Spring']),
    PollChoice::create(['choice' => 'Summer']),
    PollChoice::create(['choice' => 'Autumn']),
  ],
  'status' => 1,   // published
  'active' => 1,   // open for voting
  'runtime' => 0,  // never auto-close
]);
$poll->save();
```

`choice` is unlimited-cardinality; you can also pass saved choice ids as
`['target_id' => $chid]`. Removing a choice from the field on a later save deletes that
`poll_choice` entity and its votes.

## Useful `PollInterface` methods (on a loaded `poll`)

| Method | Returns / does |
|---|---|
| `label()` / `getQuestion` via `question` | the question text |
| `isOpen()` / `isClosed()` | voting open state (from `active`) |
| `open()` / `close()` | set `active` to 1 / 0 (still needs `save()`) |
| `getOptions()` | `[choice_id => label]` (translation-aware) |
| `getVotes()` | total votes across choices (via vote storage) |
| `getVotesOrderType()` / `setVotesOrderType($t)` | result ordering |
| `getAnonymousVoteAllow()` / `getVoteRestriction()` | anon voting rules (`ip`/`session`/`unlimited`) |
| `getCancelVoteAllow()`, `getResultVoteAllow()`, `getAutoSubmit()`, `getRuntime()` | per-poll flags |
| `hasUserVoted()` | whether current user already voted |
| `isVotingAllowed($poll)` / `isCancelAllowed($poll)` | full access logic incl. permissions |

Constants on `PollInterface`: `VOTES_ORDER_WEIGHT=0`, `VOTES_ORDER_COUNT_ASC=1`,
`VOTES_ORDER_COUNT_DESC=2`; `ANONYMOUS_VOTE_RESTRICT_IP='ip'`,
`ANONYMOUS_VOTE_RESTRICT_SESSION='session'`, `ANONYMOUS_VOTE_RESTRICT_NONE='unlimited'`.

## Loading & querying

```php
$storage = \Drupal::entityTypeManager()->getStorage('poll');
$all   = $storage->loadMultiple();
$open  = $storage->loadByProperties(['active' => 1, 'status' => 1]);
$poll  = $storage->load($id);
```

## Votes — the `poll_vote.storage` service

Votes are rows in the `poll_vote` table, not entities. Access via the service:

```php
$vs = \Drupal::service('poll_vote.storage');   // Drupal\poll\PollVoteStorage
$vs->getVotes($poll);        // [choice_id => count]
$vs->getTotalVotes($poll);   // int total
$vs->getUserVote($poll);     // current user's vote row, or FALSE
$vs->saveVote(['chid' => $choiceId, 'uid' => $uid, 'pid' => $poll->id()]);
$vs->cancelVote($poll, $account);   // remove the account's vote
$vs->deleteVotes($poll);            // remove all votes for a poll
```

Deleting a poll (`$poll->delete()`) cascades to its choices and all its votes automatically.
