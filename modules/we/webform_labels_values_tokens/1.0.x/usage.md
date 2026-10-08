<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Labels and Values Tokens adds tokens for Webform submissions that render each element's label alongside its value, and skip elements whose value is empty.

---

Standard Webform value tokens print raw values without their labels, which makes notification emails and confirmation messages hard to read and leaves blank lines for empty fields. This module implements token hooks that produce a combined "Label: value" output for a submission, automatically omitting elements that have no value, so emails and messages stay clean regardless of which optional fields a user filled in. It is a pure token provider — no routes, permissions, services or configuration.

Setup: enable the module, then use the new tokens in any Webform email handler, confirmation message, or other token-aware text. It relies entirely on the Webform module's token and submission APIs.
---
- Print webform answers as "Label: value" in emails
- Omit empty fields from notification emails
- Produce readable confirmation messages
- Avoid blank lines for unanswered optional questions
- Include both label and value without manual token lists
- Use in Webform email handler bodies
- Use in confirmation-page messages
- Summarise a submission for admins
- Keep emails tidy across varying submissions
- Replace verbose per-element token markup
- Combine with other Webform tokens
- Format submissions for plain-text or HTML email
- Print a full labelled summary of a submission
- Skip conditional fields that were never shown
- Improve readability of admin notification emails
- Reduce manual token maintenance when fields change
- Use in remote-post or other token-aware handlers
- Keep confirmation and email output consistent
