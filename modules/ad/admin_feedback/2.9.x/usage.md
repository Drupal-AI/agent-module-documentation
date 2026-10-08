Admin Feedback adds a "Was this helpful? Yes / No" widget (block) to content pages, optionally collects a free-text or predefined-answer comment, and gives site admins a per-node dashboard, scoring, and CSV export of the collected feedback.

---

The module provides an `admin_feedback_block` block that renders a configurable question (default "Was this helpful?") with Yes/No buttons on node pages. Votes post via JavaScript to `/feedback_vote` (`give feedback` permission, granted to anonymous and authenticated by `hook_install`); after a vote the visitor can optionally submit one comment through the AJAX form at `/ajax/feedback_vote` (predefined radio answers or a free textarea, configurable). Feedback rows and per-node aggregate scores are stored in two custom tables (`admin_feedback`, `admin_feedback_score`) rather than entities. All text (question, button labels, responses, prompts, predefined answers) is configurable at `/admin/feedback/settings` (`administer admin feedback`) and stored in `admin_feedback.settings`. Admins review results through Views-based dashboards at `/admin/content/feedback` and `/node/{nid}/feedback` (`view admin feedback dashboard` / `view admin feedback detail view`), can mark entries "inspected", delete single entries or all feedback for a node, and export everything to CSV in batches (`export feedback data`). The vote endpoint is hardened: votes must carry a per-node HMAC token rendered into the block, only literal `yes`/`no` on an existing node id are accepted, submissions are flood-limited per IP (default 20/hour, configurable), each feedback row may receive exactly one comment, and that comment must carry an HMAC-signed feedback-id token. A `VoteEvent` (`event_subscriber.vote`) lets other modules react to each vote. Node/translation deletes cascade to clean up feedback.

---

- Add a "Was this helpful? Yes/No" widget to documentation or article pages.
- Collect a short free-text comment after a visitor votes No (or Yes).
- Offer predefined feedback reasons (radio list) instead of free text to reduce spam and ease analysis.
- Let anonymous visitors give feedback without logging in (permission granted by default).
- Show a per-page helpfulness score and vote counts to editors on a dashboard.
- Review all site feedback in one Views table at `/admin/content/feedback`.
- Drill into a single node's feedback and comments at `/node/{nid}/feedback`.
- Mark individual feedback entries as "inspected" so triage progress is visible.
- Delete a single feedback entry, or purge all feedback for a given node.
- Export the full feedback dataset to CSV (batched) for offline analysis or reporting.
- Customize the question, button labels, and thank-you responses per site voice.
- Show different follow-up prompts after Yes vs No answers, or disable the prompt for either.
- Add an optional cancel/undo timeout after a visitor submits feedback.
- Rate-limit vote submissions per IP with a configurable flood limit and time window.
- Prevent blind/scripted vote stuffing by requiring a per-node HMAC vote token from the rendered page.
- Restrict each feedback row to exactly one comment via a signed feedback-id token.
- React to every vote in custom code by subscribing to the `VoteEvent` (e.g. push to analytics).
- Translate feedback prompts and answers per language (config translation supported).
- Track positive/negative counts and a 0–100 helpfulness score per node and language.
- Tune the export batch size for large feedback tables.
- Automatically clean up a node's feedback and score rows when the node (or a translation) is deleted.
- Gate the dashboards, exports, and deletes behind granular permissions per admin role.
- Add a custom rich-text response shown to users on a No vote (`custom_text_response_on_no`).
