<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Comment Moderation AI screens every submitted Drupal comment with OpenAI's Moderation API plus local keyword/regex policies, and flags or unpublishes content that violates them.

---

Comment Moderation AI adds automated moderation to Drupal's core comment system. When a comment is saved (`hook_comment_presave`, and again on insert/publish), the module sends its subject and body to OpenAI's **Moderation classification endpoint** (`omni-moderation-latest` by default) and compares the returned per-category confidence scores against a configurable threshold. On top of that it runs six optional local "custom policy" checks — keyword blocklist, length limits, per-user rate limiting, competitor-brand/domain detection, marketing/URL/contact detection, and PII detection (emails, phones, SSNs, credit cards, addresses) — implemented with substring and regular-expression matching. Flagged comments are written to a dedicated `openai_flagged_comments` table with a risk-based status (high/medium/low/pending), can be auto-unpublished, and are reviewed by moderators through admin screens and enhanced columns/filters on the core comment-approval view. The comment form also validates inline, blocking a flagged submission with an error before it is stored. The OpenAI API key is stored as a Key entity (the `key` module is a hard dependency), so the secret never lives in this module's own configuration.

---

- Automatically check each new or edited comment against OpenAI's moderation categories.
- Choose which of the 11 OpenAI categories (hate, harassment, self-harm, sexual, violence, etc.) to enforce.
- Set a 0.0–1.0 sensitivity threshold for what counts as a violation.
- Layer local keyword-blocklist filtering on top of the AI check.
- Enforce minimum/maximum comment length.
- Rate-limit comments per hour and restrict brand-new accounts (authenticated users only).
- Flag mentions of competitor brands or domains.
- Detect marketing content — promotional keywords, URLs, emails, phone numbers, discount patterns.
- Detect and flag PII: emails, phone numbers, SSNs, credit-card numbers, addresses, custom regex.
- Auto-unpublish high-risk (and optionally medium-risk) flagged comments.
- Block flagged submissions inline on the comment form with a user-facing error.
- Record every flag with scores, categories and a moderator audit trail in a custom table.
- Assign a risk-based status: auto_flagged_high (≥0.9), auto_flagged_medium (≥0.7), pending_review (≥0.5), flagged_low_risk.
- Review, approve, reject, publish or unpublish flagged comments from an admin detail page.
- Add moderation status, priority and flagged columns/filters to `/admin/content/comment/approval`.
- See overview statistics and top violation categories on a reports page.
- Let trusted roles bypass moderation via the `bypass comment moderation` permission.
- Clean up old approved/rejected flag records automatically via cron.
- Store the OpenAI API key securely as a Key entity (env/file/config provider).
- Keep human moderators in control — the AI does a first pass, people make the final call.
