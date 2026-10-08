<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Poll lets a site capture votes on multiple-choice questions. Each poll is a content entity holding a question and a set of choice entities, and visitors vote through a form that then shows tallied results.

---

Poll (formerly a Drupal core module, now contrib) defines two content entity types: `poll`, a published/active question with per-poll voting settings, and `poll_choice`, an individual answer option referenced by the poll's unlimited-cardinality `choice` field. Polls are created at `/poll/add` and administered at the list `/admin/content/poll`; a settings stub lives at `/admin/config/content/poll`. When rendered, a poll shows a voting form (radio buttons of its choices) to users with the `access polls` permission and, after voting, a results bar chart built from vote counts. Votes are stored in the `poll_vote` database table (not as entities) through the `poll_vote.storage` service, which records the choice, the voter's uid or hostname, and a timestamp; anonymous voting can be allowed and restricted by IP, by session, or left unlimited. Each poll can auto-close after a chosen duration (`runtime`), let users cancel their own vote, show results before voting, and order results by weight or vote count. The module supplies a "Most recent poll" block (`poll_recent_block`) that renders the newest open poll anywhere in a theme region, plus two Views (`poll_list`, `poll_admin`) and poll tokens. Ten granular permissions gate viewing, creating, editing, voting, and cancelling votes.

---

- Run a simple site-wide opinion poll ("What's your favorite feature?") shown in a sidebar block.
- Collect visitor votes on a multiple-choice question embedded on its own page at `/poll/{id}`.
- Add a "Most recent poll" block to a theme region so the newest open poll always appears.
- Let anonymous visitors vote, restricted to one vote per IP address to limit ballot stuffing.
- Allow one vote per browser session instead of per IP for softer anonymous restriction.
- Permit unlimited anonymous votes for a casual, non-scientific pulse check.
- Automatically close a poll after a set duration (a day, a week, a month, up to a year).
- Keep a poll open indefinitely by setting its duration to "Unlimited".
- Let authenticated users cancel and recast their own vote via the "Cancel own vote" permission.
- Show live results to users before they vote, or hide results until after they cast a ballot.
- Always reveal results to trusted roles with the "Always view poll results" permission.
- Order result bars by choice weight, by ascending vote count, or by descending vote count.
- Publish or unpublish a poll to control whether it is publicly visible.
- Mark a poll active or inactive to open or close voting without deleting it.
- Auto-submit the vote as soon as a choice is selected, skipping the submit button.
- Delegate poll creation to editors with "Create polls" while restricting editing to owners.
- Let users edit only their own polls ("Edit own polls") or any poll ("Edit any polls").
- Build a moderator overview of all polls at `/admin/content/poll` for administrators.
- Delete an individual user's vote from a poll's results via the delete-vote form.
- Translate poll questions and choices into multiple languages (entities are translatable).
- Surface poll data in custom Views using the shipped `poll_list` and `poll_admin` views.
- Print a poll's question or vote total in text via the module's poll tokens.
- Migrate Drupal 7 poll nodes, choices, and votes using the bundled migrate plugins.
- Generate sample polls in bulk for testing with the `poll_devel` Devel Generate submitter.
- Gate the whole poll UI behind roles using the granular per-action permission set.
- Run several independent polls at once, each with its own choices, duration, and rules.
