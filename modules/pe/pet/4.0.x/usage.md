Previewable Email Templates (PET) lets site builders create reusable, token-enabled email templates that can be previewed (with substitutions applied) before sending, and sent to one or many recipients interactively, from code, or from Rules.

---

PET defines a `pet` content entity (a template) with fields for title, machine name, subject, HTML mail body, plain-text body, "send plain only" flag, from-override, CC/BCC defaults, and a recipient-callback function name. Templates are managed at `/admin/structure/pets` (add/edit/clone/export via Entity API). Sending interactively goes through `/pet/{pet}` (`PetPreviewForm`), a two-step form: step 1 collects recipients (or uses the recipient callback / `?uid=` / `?nid=` query args) plus editable subject/body for this one send; step 2 shows the token-substituted preview; submitting sends. Token substitution uses the Token module with `user` (from a recipient's uid or the `?uid=` arg) and `node` (from `?nid=`) contexts, extensible via `hook_pet_substitutions_alter()`. Programmatic sending uses `pet_send_mail($pet_id, $recipients, $options)` (many recipients) or `pet_send_one_mail($pet, $params)` (one); `hook_mail()` (`pet_mail`) builds the message and adds CC/BCC headers. If MimeMail is enabled, extra plain-text/HTML options appear. A settings form (`pet.settings`, `/admin/config/system/pet/settings`) controls logging verbosity (log everything / errors only / show on screen). The bundled `pet.rules.inc` is a legacy Drupal-7-style Rules integration (`hook_rules_action_info` + `url()`) that is not compatible with modern Rules on Drupal 10/11.

---

- Create a reusable email template with tokens for subject and body.
- Preview an email — with tokens resolved — before actually sending it.
- Edit subject/body for a single send without changing the stored template.
- Send one template to many recipients at once.
- Send to recipients that may or may not be Drupal users.
- Provide a default recipient via `/pet/MY_PET?uid=17` for user-token substitution.
- Substitute node tokens by adding `?nid=244` to the send URL.
- Generate the recipient list dynamically with a recipient-callback function.
- Set CC and BCC defaults per template.
- Override the From address per template (falling back to the site default).
- Send an HTML email with a plain-text alternative via MimeMail.
- Send plain-text-only email when required.
- Fire a template from custom code with `pet_send_mail()` / `pet_send_one_mail()`.
- Add custom token objects for a send via `hook_pet_substitutions_alter()`.
- Send order confirmations, class sign-ups, event reminders, or membership notices from code.
- Give editors one place to edit all transactional emails instead of digging through Rules.
- Export/import templates as configuration-like defaults via `hook_default_pet()`.
- Clone an existing template to start a new one.
- Control logging verbosity (log all, errors only, or on-screen debug).
- Localize templates (the entity is translatable).
