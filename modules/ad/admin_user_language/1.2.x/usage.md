Admin User Language forces a chosen "administration pages language" (`preferred_admin_langcode`) onto every user when they are created or updated, so a multilingual site's back end stays in one consistent language.

---

On a multilingual site each user has an *administration pages language* that defaults to "- no preference -", which can make the admin UI appear in unexpected languages. This module implements `hook_entity_presave()` on the user entity: it reads its config (`admin_user_language.settings`) and, if a default language is configured, sets the user's `preferred_admin_langcode` to it. Two settings control behavior: `default_language_to_assign` (a langcode, or the special values `-1` = no preference, or `preferred_langcode` = mirror the user's own site language) and `prevent_user_override` (a boolean). When `prevent_user_override` is FALSE the language is only forced on **new** users (`$entity->isNew()`); when TRUE it is re-applied on **every** save, and `hook_form_user_form_alter()` also disables the *administration pages language* field on the user form so users cannot change it. A small settings form at `/admin/config/admin_user_language/settings` (permission `administer admin interface language`) exposes both options. The module does not itself negotiate/switch the admin language at request time — pair it with `admin_language_negotiation` for the full experience — and it requires at least two active languages to be meaningful. No plugins, hooks API, or Drush commands.

---

- Force every editor's admin UI into English on an otherwise multilingual site.
- Guarantee new users start with a defined administration language instead of "- no preference -".
- Prevent users from changing their own administration pages language (lock it).
- Keep a consistent back-office language for a support team across many content languages.
- Mirror each user's site/content language into their admin language (`preferred_langcode` option).
- Re-apply the forced admin language on every user save, not just at registration.
- Standardize the admin experience after importing/migrating many user accounts.
- Reduce editor confusion when the admin interface renders in a foreign language.
- Enforce organizational policy that all administrative work happens in one language.
- Disable the "administration pages language" widget on the user edit form for non-exempt users.
- Set a default admin language for a specific onboarding flow that creates users.
- Combine with admin_language_negotiation to actually render the admin UI in the forced language.
- Ensure automated/programmatically created users get a sane admin language.
- Give a franchise/multi-country site a single administrative language while keeping localized content.
- Avoid support tickets caused by users accidentally setting an unfamiliar admin language.
- Apply a default admin language only to newly registered users (override allowed) as a soft default.
- Reset a user's admin language back to policy whenever their profile is edited.
- Provide a one-setting way to control back-end language without custom code.
- Keep translators' admin UI in a shared language even while they work across content languages.
- Configure the forced language per environment via exported config.
- Use with a role-restricted user form so only privileged users ever see the language field.
- Enforce English admin for a globally distributed agency team.
- Prevent drift of admin language settings across a large editor base.
- Set the admin language policy centrally and audit it via `admin_user_language.settings`.
