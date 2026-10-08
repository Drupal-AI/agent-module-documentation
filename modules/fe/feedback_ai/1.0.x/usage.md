<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feedback AI collects user feedback through a form and uses the OpenAI Chat Completions API to classify each submission as Positive, Negative, or Neutral.

---

The module provides a feedback form (name, email, message) available at `/feedback-ai` and as a placeable block. When a user submits it, the message text is sent to OpenAI, the returned sentiment label is stored alongside the submission in the `feedback_ai` database table, and the visitor sees a thank-you message. Administrators configure the OpenAI secret key, endpoint, model, and max-token limit on the settings form, then review results through the shipped "Feedback AI Submissions" View, which offers exposed sentiment/date filters, a CSV export link (via Views Data Export), and a CanvasJS pie chart summarizing the recent sentiment mix. The admin surfaces (settings, submissions View, pricing modal) are gated by the `administer feedback ai` permission.

---

- Add a website feedback form that automatically tags each message with a sentiment rating.
- Gauge overall customer or user satisfaction by classifying free-text feedback into Positive / Negative / Neutral buckets.
- Collect post-interaction feedback (support, checkout, event) and visualize the sentiment split at a glance.
- Place the feedback form in any block region (footer, sidebar, contact page) via Block layout.
- Publish the feedback form as a standalone page at `/feedback-ai` for direct linking.
- Show a live sentiment pie chart of the latest submissions on a dashboard using the "Feedback AI Chart" block.
- Review all submissions in a sortable admin table at `/feedback-ai-submissions` (Content > Feedback AI Submissions).
- Filter submissions by sentiment rating (Positive, Negative, Neutral) using the exposed filter.
- Filter submissions by submission date using the improved date filter.
- Export filtered feedback submissions to CSV for reporting or spreadsheet analysis.
- Relate each submission to the submitting Drupal user account through the built-in user relationship in Views.
- Choose which OpenAI model to use (gpt-3.5-turbo, gpt-4, gpt-4-turbo, gpt-4o) from the settings form.
- Cap OpenAI response length and cost by setting a maximum token limit.
- Point the integration at the OpenAI Chat Completions endpoint through configuration.
- Reuse the Guzzle-based `feedback_ai.openai_client` service to run ad-hoc sentiment analysis from custom code.
- Track sentiment trends over time by combining the submissions View with date filtering and export.
- Provide site editors a read-only sentiment dashboard while restricting configuration to trusted admins via the `administer feedback ai` permission.
- Surface the OpenAI pricing/usage reference modal to admins from the submissions View footer.
- Build custom reports on the `feedback_ai` base table, which is registered with Views (ID, user, name, email, feedback text, sentiment result, created).
- Collect anonymous or authenticated feedback and attribute it to a user ID when logged in.
- Drop the feedback block onto landing pages to capture reactions to campaigns or announcements.
