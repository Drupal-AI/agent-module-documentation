Advanced Email Validation rejects unwanted email addresses on user accounts (and, optionally, Webform email fields) using configurable rules: MX-record lookup, plus block-lists of disposable, free, and explicitly banned domains, backed by the open-source `stymiee/email-validator` library.

---

The module adds validation constraints to the User entity's `mail` base field via
`hook_entity_base_field_info_alter()`: `AEVNewEmail` when `validate_account_on.created` is on
(new accounts) and `AEVChangedEmail` when `validate_account_on.updated` is on (email changes).
Each constraint calls the `advanced_email_validation.validator` service
(`AdvancedEmailValidator::validateEmail()`), which configures a `stymiee/email-validator`
`EmailValidator` from `advanced_email_validation.settings` and returns a result with an error
code and a configured, translatable message. Four rules are toggled independently — `mx_lookup`
(the domain must have MX records), `disposable`, `free`, and `banned` — and each has an editable
domain list plus a `local_list_only` switch to use only your list instead of the library's
bundled lists. All error messages are stored in config and translatable through the core
Configuration Translation module. Settings live at
`/admin/config/people/advanced-email-validation` (permission `administer advanced email
validation`). When the contributed Webform module is present, the module also supplies a Webform
handler (`advanced_email_webform_validator_handler`) that applies the same rule set — with
optional per-handler overrides — to chosen email or email_confirm elements on any webform. The
service is reusable directly in code for custom validation flows.

---

- Block new user registrations that use disposable/throwaway email addresses.
- Reject signups from free email providers (Gmail, Yahoo, etc.) on a B2B site.
- Require a valid MX record so accounts can actually receive mail.
- Maintain a custom banned-domain list to block competitors or abusive domains.
- Validate email changes on existing accounts, not just new registrations.
- Show a friendly, translatable error message per rule (basic/MX/disposable/free/banned).
- Localize rejection messages via Configuration Translation for multilingual sites.
- Apply the same disposable/free checks to a "contact us" Webform email field.
- Override the global rule set on a specific webform (e.g. stricter for a giveaway form).
- Use only your own curated domain list instead of the library's bundled lists.
- Combine MX + disposable + banned checks to cut spam-bot account creation.
- Call `AdvancedEmailValidator::validateEmail()` from custom code to vet an address.
- Pre-flight an email in a migration or import before creating accounts.
- Enforce corporate-email-only registration by banning free providers.
- Keep a newsletter list clean by rejecting invalid addresses at capture time.
- Allow free providers but still block known disposable domains.
- Add a validation handler to an event-registration webform's email field.
- Translate the "banned domain" message differently per language.
- Toggle a single rule (e.g. MX only) without enabling domain block-lists.
- Reduce bounce rates by rejecting undeliverable domains up front.
- Grant a limited role permission (`administer advanced email validation`) to manage rules.
