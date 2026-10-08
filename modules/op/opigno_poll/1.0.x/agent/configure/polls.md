<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# opigno_poll — creating and running polls

## Create a poll
- Add at `/opigno_poll/add` (needs `create opigno_polls`). Manage all at `/admin/content/opigno_poll` (needs `administer opigno_polls`).
- Fields: the **question** (label), one or more **poll choices** (`poll_choice` items = choice text + starting vote count), **status** (open/closed), **duration**, and flags: `anonymous_vote_allow`, `result_vote_allow` (see results before voting), `cancel_vote_allow`. Optional shipped fields: `field_learning_path`, `field_allow_roles`.

## Voting & display
- Users vote at `/opigno_poll/{opigno_poll}` through `PollViewForm` (AJAX). After voting (or when the poll is closed, or the user already voted, or an anonymous user on a poll not allowing anonymous view) the form shows results as a meter.
- Votes are written by `opigno_poll_vote.storage` (`saveVote`) recording choice, uid, poll id, client IP, timestamp. `cancelVote` removes the current user's vote when `cancel_vote_allow` + `cancel own vote`.
- Blocks: place **Most recent poll** (`PollRecentBlock`) or the **chart** (`ChartBlock`). Views fields `PollStatus` / `PollTotalVotes` are available for custom listings.

## Access
- View: allowed if `anonymous_vote_allow` is set, or the user has `access opigno_polls`, or holds one of `field_allow_roles`.
- Edit: owner with `edit own opigno_polls`, or `administer opigno_polls`. The `uid` field is edit-restricted to `administer opigno_polls`.
- `view opigno_poll results` lets a user always see results without voting.

## Caution
The vote-delete route `/opigno_poll/{opigno_poll}/delete/vote/{user}` only checks `access opigno_polls` (its per-user check is an open `@todo`). Do not grant `access opigno_polls` to untrusted users if vote integrity matters, until a proper access check is added.