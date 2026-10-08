AI Form Guard extends AI Webform Guard's LLM spam detection to arbitrary custom (non-Webform) Drupal forms, selected by form ID.

---

This submodule of AI Webform Guard reuses the parent module's `SpamDetectionService` (AI provider, prompt, probability threshold, flood control, IP whitelist, human-iteration) and applies it to any core or contrib form you name. It adds a "Custom Form IDs" textarea to the parent's settings form (one form ID per line); a `hook_form_alter()` then attaches a spam-detection validation handler to each listed form. A separate "AI Custom Form Fields" admin page lets you list fields to exclude from the AI prompt and set a per-form custom prompt. All other tuning (model, thresholds, flood, whitelist, logging) is inherited from AI Webform Guard — this module owns only the custom-form ID list and per-form field settings.

---

- Spam-check a core contact form (`contact_message_form`) with the same AI engine used for Webforms.
- Protect the user registration form (`user_register_form`) from bot signups.
- Guard comment forms (`comment_form`) against AI-detected spam.
- Add AI moderation to any custom module's form by listing its form ID.
- Exclude non-content fields (e.g. `form_build_id`, `op`, honeypot fields) from the AI prompt per form.
- Set a tailored spam-detection prompt for a specific custom form.
- Reuse the parent module's provider, probability threshold, and flood control without extra config.
- Apply the human-iteration confirmation checkbox flow to custom forms flagged as spam.
- Log blocked custom-form spam attempts alongside Webform ones (channel `ai_webform_guard`).
- Roll out AI spam protection incrementally, one form ID at a time.
- Combine custom-form and Webform protection under a single AI configuration.
- Bypass the AI check for trusted IPs on custom forms via the inherited whitelist.
- Throttle repeat abusers of a custom form with the inherited flood control (no AI call once blocked).
- Find target form IDs with Devel (`drush devel:form`), DevTools, or the form's `#form_id`.
- Keep sensitive custom-form fields out of LLM egress by excluding them per form.
