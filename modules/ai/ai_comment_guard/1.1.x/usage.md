<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Comment Guard moderates new Drupal comments with the Anthropic Claude API, then flags, redacts, or blocks anything the model judges abusive or harmful.

---

AI Comment Guard hooks into the core comment save cycle: on presave it sends each new comment's body to the Anthropic Claude Messages API with a system prompt built from the configured sensitivity level and any custom rules, and the model returns a JSON verdict (`is_harmful`, `severity`, `reason`, `cleaned_text`). When a comment is judged harmful the module applies one of three configurable actions on comment insert — Flag (unpublish for admin review, body untouched), Replace (keep it published but swap harmful phrases for `[removed]`), or Block (replace the whole body with a policy message and unpublish). It can optionally email authenticated authors and log each violation to watchdog. Everything is driven from one settings form (`/admin/config/content/comment-sanitizer`); the only dependencies are core `comment` and `system`, plus an Anthropic API key. Comment text is sent to Anthropic for evaluation, which has cost and data-egress implications you should confirm are acceptable for your content.

---

- Moderate new comments with Claude before they are published.
- Catch context-dependent abuse that keyword blocklists miss.
- Flag suspected comments as unpublished for admin review.
- Redact harmful phrases while keeping the rest of a comment visible (Replace mode).
- Blank a whole comment body with a policy message (Block mode).
- Choose Low / Medium / High AI sensitivity per site tolerance.
- Append plain-language custom rules to the moderation prompt (e.g. "flag competitor promotion").
- Auto-unpublish flagged or blocked comments.
- Email authenticated authors when their comment is actioned.
- Log violations (severity + AI reason) to Drupal watchdog.
- Let trusted roles skip moderation with a bypass permission.
- Show a Status Report warning when the Anthropic API key is unset.
- Replace core's "comment posted" message with an accurate held-for-review notice.
- Run on high-traffic comment sections without a manual moderation queue.
- Reduce toxic content on blogs, forums, and news sites with open commenting.
- Set a custom replacement message for blocked comments.
- Configure the whole feature from a single admin form.
- Operate on Drupal 10 and 11 with only the core comment module.
- Pair with core content_moderation workflows for reviewing held comments.
- Adjust the Claude model in code for lower-cost moderation.
