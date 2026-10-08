Makes the user's e-mail address double as their account username: the `name` field is no longer required and is kept in sync with `mail`, while `mail` becomes required and more strictly validated.

---

On the user form the module disables and hides the *Username* field (its description becomes
"Username is synchronized with e-mail address"), marks *E-mail* as required, and adds a
first-priority validate handler that copies the submitted `mail` value into `name`. Via
`hook_entity_base_field_info_alter` it also makes the core `user.name` field non-required and
strips its constraints, makes `user.mail` required, and attaches a custom `UserMail`
validation constraint. A `hook_user_presave` handler re-copies `mail` into `name` on every
save (covering programmatic/user-import updates outside the form), and `hook_install` back-fills
existing users' usernames from their e-mail. Login itself is unchanged — core still
authenticates against the `name` field, which now holds the e-mail, so users effectively "log
in with their e-mail". The `UserMail` constraint always runs RFC validation (via
`egulias/email-validator`) and, when the PHP `intl` extension is present, also DNS-check and
spoof-check validation; both extra checks can be turned off in `settings.php`
(`$settings['email_username']['validate_dns'|'validate_spoof'] = FALSE`). There is no admin
settings form (`configure` is null) and no permissions.

---

- Let users register and log in using their e-mail address as the username.
- Hide the separate Username field from the account create/edit form.
- Make the e-mail address the required identifier for every account.
- Keep `name` automatically equal to `mail` on every user save, including imports.
- Back-fill usernames from e-mail for all existing users when enabling the module.
- Apply RFC-compliant e-mail validation to account e-mail addresses.
- Add DNS (MX) checking so addresses on non-mail domains are rejected (requires `intl`).
- Add spoof/confusable-character checking on e-mail addresses (requires `intl`).
- Reject e-mail addresses containing spaces or multiple `@` symbols with clear messages.
- Reject addresses with consecutive dots or local/reserved domains.
- Disable DNS validation via `settings.php` on environments without outbound DNS.
- Disable spoof validation via `settings.php` where it is not wanted.
- Avoid maintaining two identifiers (username + e-mail) for support/UX simplicity.
- Provide a "sign in with e-mail" experience without a custom login module.
- Ensure programmatic account creation also ends up with e-mail-as-username.
- Standardise account identity on e-mail for SSO-adjacent or CRM-synced sites.
- Prevent users from choosing a vanity username that diverges from their e-mail.
- Reduce duplicate-account confusion by keying identity on the e-mail address.
