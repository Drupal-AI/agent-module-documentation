# Comment Moderation AI — manual setup guide

**Comment Moderation AI** (`comment_moderation_ai`) automatically moderates
user‑generated comments with the help of an external AI service. As each comment
is submitted, the module evaluates it against your policies and can flag, hold, or
route potentially inappropriate, risky, or non‑compliant content for review before
it becomes publicly visible — so moderators keep editorial control while the AI
does the first pass.

It integrates with **OpenAI's moderation API** (including the newer
`omni-moderation-latest` model) and layers its own custom policies on top:
keyword filtering, length restrictions, rate limiting, competitor detection,
marketing‑content identification, and PII protection (emails, phone numbers, SSNs,
credit cards, addresses). Results feed a risk‑based status system —
`auto_flagged_high`, `auto_flagged_medium`, `flagged_low_risk`, `pending_review` —
and plug into Drupal's existing comment approval workflow at
**Content → Comments → Unapproved comments** (`/admin/content/comment/approval`),
where flagged comments get colour‑coded badges and filtering.

Two things to plan for. First, the OpenAI API key is stored securely through the
**Key** module rather than being hard‑coded — see [Installation](installation/index.md)
and [Configuration](configuration/index.md) for the recommended DDEV + Key setup.
Second, moderation makes an **LLM call for every submitted comment**, which has a
real cost; keep comment‑posting permissions and flood limits tight so a spike in
submissions (or abuse) doesn't run up your bill. It requires Drupal 10 or 11 (built
for 11), PHP 8.3+, and the PHP cURL extension.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies, and store your OpenAI key securely.
2. [Configuration](configuration/index.md) — connect OpenAI, tune moderation
   behaviour, choose categories and custom policies, and set permissions.

## Where it lives in the admin menu

Configure the module at **Configuration → OpenAI Comment Moderation**
(`/admin/config/comment-moderation-ai`). Moderation results surface in the core
comment approval view at `/admin/content/comment/approval`, and the module's
permissions live at **People → Permissions** (`/admin/people/permissions`).
