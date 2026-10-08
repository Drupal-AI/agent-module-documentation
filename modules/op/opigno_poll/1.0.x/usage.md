<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Captures votes on multiple-choice questions as a first-class `opigno_poll` content entity, with results display and charts.

---

A port of the Poll subsystem removed from Drupal 8 core, adapted for Opigno LMS. Each poll is an entity holding the question, a set of `poll_choice` field items (label + initial vote count), open/closed status and duration, plus flags for anonymous voting, viewing results before voting, and vote cancellation. Voting happens through `PollViewForm` (AJAX-replaceable), votes are persisted by the `opigno_poll_vote.storage` service into a database table (choice, uid, poll id, hostname/IP, timestamp), and results render as a meter and via a `ChartBlock`. A `PollRecentBlock` surfaces the newest poll; Views integration adds status and total-vote fields; migrate source/destination plugins import D6/D7 poll data. Polls can also be scoped to learning paths and allowed roles (optional fields shipped in config).

Setup: enable the module (pulls `opigno_lms` + `twig_tweak`), manage polls at `/admin/content/opigno_poll`, add polls at `/opigno_poll/add`, and place the recent-poll or chart blocks. Access uses a granular permission set (`create / edit own / administer opigno_polls`, `access opigno_polls`, `cancel own vote`, `view opigno_poll results`) enforced by `PollAccessControlHandler`; anonymous voting is allowed only when the poll's `anonymous_vote_allow` flag is set. **Note:** the vote-deletion route `/opigno_poll/{opigno_poll}/delete/vote/{user}` is gated only by the broad `access opigno_polls` permission and carries an in-code `@todo` that its per-user access check is missing — any holder of that permission can delete another user's vote via the `{user}` parameter.

---

- Create a multiple-choice poll as an `opigno_poll` content entity.
- Add answer choices (with optional starting vote counts) via the `poll_choice` field.
- Set a poll open or closed and give it a voting duration.
- Let users vote on a poll at `/opigno_poll/{opigno_poll}` with an AJAX form.
- Allow anonymous visitors to vote by enabling `anonymous_vote_allow`.
- Show results (as a meter) after a user votes or when the poll closes.
- Let users view results before voting via `result_vote_allow`.
- Grant `view opigno_poll results` so a user can always see results without voting.
- Let a user cancel their own vote when `cancel_vote_allow` + `cancel own vote`.
- Manage all polls at `/admin/content/opigno_poll`.
- Add a new poll at `/opigno_poll/add` (needs `create opigno_polls`).
- Place the "Most recent poll" block (`PollRecentBlock`).
- Place the poll chart block (`ChartBlock`) to visualize results.
- Add poll status / total-votes columns to a View (`PollStatus`, `PollTotalVotes`).
- Scope a poll to a learning path or to allowed roles via the shipped optional fields.
- Restrict poll viewing by role using `field_allow_roles`.
- Import legacy D6/D7 poll data using the bundled migrate source/destination plugins.
- Let poll owners edit their polls with `edit own opigno_polls`.
- Record voter IP and timestamp with each vote in the vote storage table.