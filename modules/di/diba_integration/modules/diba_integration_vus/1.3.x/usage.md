DiBa VUS authenticates Drupal users against the Diputació de Barcelona VUS (Validació d'Usuaris) corporate service — validating credentials through the VUS web service, optionally auto-provisioning accounts, and cross-checking users against the corporate Oracle mailbox directory in admin reports.

---

The submodule (`diba_integration_vus`) provides a settings form at `/admin/config/people/vus` (`administer vus`) and three admin report pages under it (`access vus`): busties (mailbox match), counts (statistics), and errors (mismatches). `VusManager` is the core service: `getWsData()` posts corporate credentials (`OPS$<user>` + password plus a web-service user/token from config) to the configured VUS endpoint with `GuzzleHttp` and parses the XML response; `validateUser()` interprets the response codes, loads or creates the Drupal user, and `updateUser()` syncs name and, when enabled, "ens" (organizations) and "perfils" (profiles) into the `vus_ens`/`vus_perfils` taxonomy vocabularies referenced from user accounts. `DibaIntegrationVusHooks` (`hook_form_*_alter`) reshapes the login form per validation mode (0 Drupal-native, 1 combined VUS+Drupal, 2 exclusive VUS-or-Drupal by domain, 3 VUS-only), hides password fields for corporate users on the profile form, makes email required on registration, and adds password-recovery messaging. `VusPostSubscriber` (kernel REQUEST) lets an anonymous request with scalar `user`/`pass` POST parameters single-sign-on via VUS; on success `VusManager::login()` finalizes login and hands a `RedirectResponse` to `RedirectMiddleware`. `PasswordRememberSubscriber` disables `/user/password` when the mode is VUS-only. `DibaOracleService` opens a separate `oci8` connection (credentials: Oracle user in config, password in the State API) to resolve username↔mailbox mappings for the report pages.

---

- Authenticate site users with their DiBa corporate (VUS) username and password.
- Choose a validation mode: native Drupal, combined VUS+Drupal, exclusive VUS-or-Drupal by domain, or VUS-only.
- Auto-provision Drupal accounts for valid VUS users who do not yet have one, with a configurable default role.
- Single-sign-on into the site by POSTing corporate `user`/`pass` parameters from the DiBa "accés restringit" portal.
- Synchronize the corporate display name into a chosen user field on each login.
- Sync VUS "ens" (organizations) into a `vus_ens` taxonomy vocabulary referenced from user accounts.
- Sync VUS "perfils" (application profiles) into a `vus_perfils` vocabulary, optionally continuously on every login.
- Scope synchronization to one application code so a user's account is not filled with every corporate app's ens/perfils.
- Make email mandatory when creating new VUS users and reject duplicate emails.
- Hide password / password-policy fields on a corporate user's edit form and show a corporate-reset message.
- Block corporate users from Drupal password reset and point them to the VUS restablishment portal (or disable `/user/password` entirely in VUS-only mode).
- Show configurable, HTML-capable login-error and password-recovery messages per user type.
- Log failed login attempts with the Drupal/VUS validation outcome and VUS response/reason codes.
- Search all Drupal accounts and match them against the corporate Oracle mailbox directory (busties report) with username/mail match filters and paging.
- View statistics: total users, users on DiBa domains, users with a corporate mailbox broken down by domain, external users, and access recency (30/365 days, never).
- List accounts whose Drupal username or email does not match the corporate directory (errors report).
