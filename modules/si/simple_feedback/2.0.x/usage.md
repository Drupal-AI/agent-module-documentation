<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Feedback adds a per-node Yes/No 'was this helpful?' voting block backed by an AJAX endpoint.

---

Simple Feedback provides a block (`SimpleFeedbackBlock`) shown on node pages with Yes/No links. Clicking calls `/ajax/simple_feedback/{node}/{feedback}` (`SimpleFeedbackController`), which records +1/-1 into the custom `simple_feedback` table with the node id, user id, timestamp and client IP; a second route returns the vote tallies as JSON. Votes are deduplicated per node+IP (repeat identical votes are dropped, changed votes are upserted). Both routes are gated only by `access content`, so anonymous visitors can vote. Queries use the Drupal DB API (parameterized).

---

- Ask 'was this page helpful?' on nodes.
- Let visitors vote Yes or No.
- Record votes via an AJAX endpoint.
- Store votes in a custom database table.
- Deduplicate votes per node and IP.
- Allow changing a previous vote (upsert).
- Return Yes/No tallies as JSON.
- Show the feedback block per node page.
- Capture the voter's user id and IP.
- Let anonymous users submit feedback.
- Measure content usefulness over time.
- Work on Drupal 8, 9 and 10.
- Use core AJAX link behavior.
- Avoid a heavy voting framework.
- Provide simple content-quality signals.
- Cache the block per URL path.
