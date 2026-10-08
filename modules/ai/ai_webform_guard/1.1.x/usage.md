AI Webform Guard classifies each Webform submission with a chat LLM (via the AI module) and blocks the ones the model rates as spam.

---

The module attaches a validation handler to every Webform submission form. On submit — after the form's own validation passes — it collects the submitted field values, appends them to an admin-configured prompt, and sends them to the AI provider selected in the AI module (or a per-Webform override). The provider is asked to return JSON `{is_spam, probability, reason}`; a submission is rejected when the probability meets the configured threshold (default 70%). Around the AI call it layers cheaper guards: an IP whitelist that bypasses the check entirely, per-form/per-IP flood control that blocks repeat offenders without spending an AI call, a max-words truncation cap to limit token cost, and an optional "human iteration" confirmation checkbox that lets a flagged user assert their submission is legitimate. Configuration lives in two admin forms (general settings and per-Webform field exclusions) under Configuration → AI. The `ai_form_guard` submodule extends the same engine to arbitrary custom (non-Webform) forms by form ID.

---

- Add AI-based spam filtering to a Webform contact form without a visible CAPTCHA.
- Classify submissions as spam/not-spam using a configurable natural-language prompt.
- Choose a specific AI provider/model for detection, or fall back to the AI module's default chat model.
- Tune sensitivity with a spam-probability threshold (50 aggressive / 70 balanced / 90 permissive).
- Exclude specific Webform fields (e.g. names, phone numbers) from the text sent to the AI.
- Set a per-Webform custom prompt so different forms get tailored spam criteria.
- Show a "confirm this is not spam" checkbox to flagged users so genuine submitters can proceed (human iteration).
- Log every blocked spam attempt to the Drupal log (watchdog) with the AI's probability and reason.
- Show a custom error message to users whose submission is rejected.
- Whitelist trusted IP addresses (with `*` wildcards) so internal or known-good sources skip the AI check.
- Throttle abusive sources with flood control: after N spam hits in a time window, block further submissions without calling the AI.
- Cap AI token/cost usage per submission by truncating long submissions to a maximum word count.
- Emit a `SpamDetectedEvent` so other modules can react (notify, ban, tag) when spam is caught.
- Automatically enable a Webform email-confirmation handler only for flagged submissions (spam confirmation flow, requires Webform Email Confirmation Link).
- Protect custom Drupal forms (contact, comment, user register, etc.) by enabling the `ai_form_guard` submodule and listing their form IDs.
- Exclude fields and set custom prompts per custom form via the AI Custom Form Fields page.
- Reduce reliance on third-party CAPTCHA services by using your existing LLM provider for moderation.
- Combine with server-side anti-spam (Honeypot, flood control) as one layer of a defense-in-depth setup.
- Localize/theme the detection prompt using Twig tokens for multilingual sites.
