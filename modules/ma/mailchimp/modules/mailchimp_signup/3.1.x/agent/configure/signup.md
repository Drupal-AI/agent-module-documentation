# Signup forms

`mailchimp_signup` is a config entity (schema `config/schema/mailchimp_signup.schema.yml`)
managed at `/admin/config/services/mailchimp/signup`.

| Route / path | Action |
|---|---|
| `mailchimp_signup.admin` — `/admin/config/services/mailchimp/signup` | List signup forms. |
| `mailchimp_signup.add` — `.../signup/add` | Create a signup form. |
| `entity.mailchimp_signup.edit_form` — `.../signup/{id}` | Edit a form. |
| `entity.mailchimp_signup.delete_form` — `.../signup/{id}/delete` | Delete a form. |

Per form you configure:
- **Audience(s)** to subscribe to and which **merge fields** to collect.
- **Display mode** — block, page, or both. Page routes are generated dynamically by
  `MailchimpSignupRoutes::routes`; block placement uses the
  `MailchimpSignupSubscribeBlock` block plugin (place it via Block layout).
- Messaging (submission text); double opt-in behavior and the confirmation message come from
  the base module settings (`mailchimp.settings.optin_check_email_msg`).

As config entities, signup forms are exportable and deployable. Since it's a config entity,
this submodule provides config schema (no drush commands).
