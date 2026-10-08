# Configuration

All settings live at **Configuration → OpenAI Comment Moderation**
(`/admin/config/comment-moderation-ai`). Open it as a user with the
**Administer site configuration** permission. The form is organized into the
sections below.

## OpenAI API setup

Select the **Key** entity that holds your OpenAI API key (created during
[Installation](../installation/index.md) — don't paste the raw key here) and choose
your moderation **model**; `omni-moderation-latest` is recommended for accuracy and
multimodal support. Use the built‑in **connection test** to confirm the API
responds before going further.

## Core moderation settings

This is the main behaviour switch:

- **Enable moderation** — turn AI moderation on or off for new comments.
- **Auto‑flagging** — automatically flag comments the AI judges risky.
- **Auto‑unpublishing** — automatically hold/unpublish comments that cross your
  threshold, keeping them out of public view until a moderator reviews them.
- **Sensitivity threshold** — a value from **0.0 to 1.0** that sets how confident
  the AI must be before a comment is acted on. A lower threshold catches more (but
  risks false positives); a higher one is more permissive.

Comments are then assigned a risk‑based status — such as `auto_flagged_high`,
`auto_flagged_medium`, `flagged_low_risk`, or `pending_review` — so moderators can
prioritize.

## OpenAI categories

Enable or disable the specific OpenAI moderation categories you care about — for
example hate speech, harassment, self‑harm, sexual content, and violence. Turn off
any category that doesn't fit your site's needs.

## Custom policies

Beyond OpenAI's own checks, you can layer the module's built‑in rules:

- **Keyword filtering** — block or flag comments containing specific terms.
- **Length restrictions** — set minimum/maximum comment length.
- **Rate limiting** — cap how quickly a user can submit comments.
- **Competitor detection** and **marketing‑content identification** — flag
  promotional or competitor mentions.
- **PII protection** — detect and flag personal data such as emails, phone
  numbers, SSNs, credit card numbers, and addresses.

## Permissions

Set up who can do what at **People → Permissions**
(`/admin/people/permissions`). The module provides permissions for viewing flagged
comments, moderating content, and **bypassing** moderation checks. Grant the
bypass permission only to trusted roles.

## Cost and safety reminder

Moderation makes an **LLM call for every submitted comment**, so each submission
has a real cost. Keep comment‑posting permissions tight and lean on the rate
limiting / flood controls above, so a burst of submissions — legitimate or
malicious — doesn't run up an unexpected bill.

## Review moderated comments

Once configured, flagged comments appear in the core approval view at
**Content → Comments → Unapproved comments**
(`/admin/content/comment/approval`), enhanced with colour‑coded status badges,
priority indicators, and filtering so moderators can work through them quickly.
