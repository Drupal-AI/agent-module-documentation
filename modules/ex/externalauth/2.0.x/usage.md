External Authentication is a developer helper module that maps Drupal accounts to identities from external services (LDAP, OAuth, SAML, SSO, etc.) and handles the login/register/link plumbing for those integrations.

---

External Authentication (externalauth) is a low-level building block, not an end-user feature — it is a dependency of many SSO/identity contrib modules rather than something you configure directly. It provides an "authmap" that records, per external provider, which external identifier (authname) belongs to which Drupal user. Its two core services do the heavy lifting: `Authmap` stores/reads/deletes the identifier mappings, and `ExternalAuth` implements the common flows — `load()`, `login()`, `register()`, `loginRegister()`, `linkExistingAccount()`, and `userLoginFinalize()` — so an authentication module only has to supply the verified external identity. It dispatches events (`externalauth.login`, `externalauth.register`, `externalauth.authmap_alter`) so other modules can react when a user logs in or is registered, or alter the data stored in the authmap before it is saved. It ships migrate source/destination plugins for importing legacy authmap data and a Views field plus a delete form (at `/admin/people/authmap/...`) for administering stored mappings. There is no configuration UI of its own. Permissions gate viewing and deleting authmap data.

---

- Provide the authmap backend for a custom SSO/OAuth/SAML module.
- Register a new Drupal user automatically after external authentication.
- Log in an existing user matched by their external identifier.
- Do login-or-register in one call with `loginRegister()`.
- Link an already-authenticated Drupal account to an external identity.
- Look up the Drupal uid for a given external authname + provider.
- Store arbitrary provider data alongside the identity mapping.
- Finalize a Drupal login session for an externally-authenticated account.
- Delete a user's authmap entry for one provider or all providers.
- Remove all mappings for a decommissioned provider.
- React to external logins via the `externalauth.login` event.
- React to new external registrations via the `externalauth.register` event.
- Alter authmap data before storage via the `externalauth.authmap_alter` event.
- Migrate legacy authmap rows using the provided migrate source plugin.
- Import identity mappings into the authmap via the migrate destination plugin.
- Administer stored mappings from the People → Authmap listing (Views).
- Let admins delete an individual external-auth entry via the delete form.
- Gate visibility of external-auth data with the `view authmap` permission.
- Gate deletion of external-auth data with the `delete authmap` permission.
- Build an LDAP-backed login on top of the ExternalAuth service.
- Support "sign in with X" providers without reimplementing user matching.
- Keep external usernames decoupled from Drupal usernames.
- Prevent duplicate accounts by matching on the external identifier.
- Centralize identity-mapping logic shared across several auth modules.
- Log externalauth activity through its dedicated logger channel.
