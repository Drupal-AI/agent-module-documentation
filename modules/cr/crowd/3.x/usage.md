Integrates Drupal login, registration, profile editing and password reset with an Atlassian Crowd server so Crowd is the source of truth for user credentials.

---

The Atlassian Crowd module makes a Crowd server the authoritative identity store for a Drupal site. It talks to Crowd's REST User Management API (`/rest/usermanagement/1`) with HTTP Basic auth using an application username and a password held in a Key entity. It hooks core's user login, registration, profile-edit, password-reset and (optionally) TFA-setup forms: when the local Drupal password check fails, credentials are validated against Crowd instead, and a matching Drupal account is auto-provisioned through the externalauth module and mapped to the `crowd` provider. Registrations and profile edits are written back to Crowd (create user, update user, update password, mark active). It adds `given_name`, `surname` and `display_name` base fields to users, can use the email address as the username, can restrict which email domains may change their address/password, and can grant a configurable "verified" role once a user confirms their email via the one-time login link. All configuration lives in the `crowd.settings` config object plus the `crowd_password` Key; there are no bundled submodules.

---

- Use an existing Atlassian Crowd server as the single sign-on identity provider for a Drupal site.
- Let users log in to Drupal with their Crowd username (or email) and password, validated over the Crowd REST API.
- Auto-provision a Drupal account the first time a Crowd-authenticated user logs in, with no manual account creation.
- Register brand-new users directly into Crowd from Drupal's standard user-registration form.
- Present the registration/login form with "Email address" as the identifier by enabling *Use email for username*.
- Keep Drupal user profile fields (first name, surname, display name) in sync with the corresponding Crowd fields on login.
- Push profile changes made in Drupal (name, email, display name) back to the Crowd directory.
- Change a user's Crowd password from the Drupal profile form, requiring the current password to be re-validated against Crowd.
- Route Drupal's "forgot password" form to look up unknown accounts in Crowd and provision them before sending a reset link.
- Grant a chosen Drupal role automatically to users who have verified their email address via the one-time login link.
- Prevent users from specific email domains from changing their email address or account by configuring *Restricted domains*.
- Hide the first-name/surname/display-name fields from edit for restricted-domain users via field access.
- Let administrators create either a Crowd-backed account or a purely local Drupal account from the register form using the *Local account* checkbox.
- Allow designated Drupal accounts to bypass Crowd and log in locally (via the *Login to local Drupal account* permission on non-Crowd users).
- Integrate two-factor authentication (TFA) setup by validating the user's current password against Crowd during TFA enrolment.
- Expire the Crowd session on Drupal logout so single sign-off is honored.
- Store the Crowd API password securely in a Key entity (env-provider by default) instead of Drupal config.
- Point Drupal at any reachable Crowd server by setting the *Crowd server URI* in module settings.
- Build custom Crowd integrations (batch pull, provisioning) on top of the `crowd.connector` service and its `CrowdConnectorInterface` API.
- Centralize authentication for an organization that already manages staff accounts in Crowd/Jira/Confluence.
