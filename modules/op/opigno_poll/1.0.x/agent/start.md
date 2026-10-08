<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Opigno Poll (opigno_poll) — agent index

**Multiple-choice poll content entity with vote capture, results, meter and charts (Opigno LMS).**

- **Version:** 1.0.x (1.0.1)
- **Core:** ^9 || ^10 || ^11
- **Depends on:** twig_tweak, **opigno_lms** (heavy LMS distribution dependency)
- **Config route:** `opigno_poll.settings` → `/admin/config/content/opigno_poll` (placeholder form, no settings yet).
- **Entity:** `opigno_poll` (+ `poll_choice` field type). List at `/admin/content/opigno_poll`; add at `/opigno_poll/add`; view/vote at `/opigno_poll/{opigno_poll}`.
- **Permissions:** `create opigno_polls`, `edit own opigno_polls`, `administer opigno_polls` (restricted), `access opigno_polls`, `access opigno_poll overview`, `cancel own vote`, `view opigno_poll results`. Enforced by `PollAccessControlHandler` (view allowed when `anonymous_vote_allow` or has `access opigno_polls` or matching `field_allow_roles`).
- **Services:** `opigno_poll_vote.storage` (DB vote storage), `opigno_poll.post_render_cache`. **Blocks:** `PollRecentBlock`, `ChartBlock`. **Views:** `PollStatus`, `PollTotalVotes` fields.

**Security observation (report, not recorded):** route `opigno_poll.opigno_poll_vote_delete` (`/opigno_poll/{opigno_poll}/delete/vote/{user}`) is gated only by `access opigno_polls` and has an `@todo` noting the missing check that the actor may delete *that* user's vote — an IDOR-style gap letting one such user delete another's vote. Entity CRUD is otherwise properly permission-gated.

See [configure/polls.md](configure/polls.md).