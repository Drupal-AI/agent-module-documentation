<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
miniOrange Okta User Sync provisions and de-provisions Drupal user accounts to and from Okta and maps user attributes between the two systems.

---

The module adds an admin area under `/admin/config/people/okta_user_sync` (all routes gated by `administer site configuration`) with tabs for an overview, Drupal→Okta and Okta→Drupal configuration, attribute mapping, advanced settings, audits/logs, upgrade plans and a support/trial request form. It stores the Okta base URL, the target UPN and an Okta API token (the "bearer token") in the `okta_user_sync.settings` config object. API calls to Okta go through the injected Guzzle `http_client`: `MoOktaHelper::getUserFromOkta()` fetches a user with an `Authorization: SSWS <token>` header, and `callService()` posts to miniOrange licensing/notification endpoints on `login.xecurify.com`. Real-time provisioning is driven by Drupal user CRUD hooks (via the required `user_provisioning` module), with manual, cron-based and password-sync options described in the module help.

Security notes: the Okta API token is held in plain configuration (`okta_user_sync_bearer_token`) rather than a Key entity, and is rendered back into the admin form field, so config export and admin access both expose it — restrict `administer site configuration` and consider excluding this config from exports. Guzzle uses default TLS verification (no `verify => false`), so Okta and miniOrange calls are made over verified HTTPS. All sync/config actions require the admin permission; there is no anonymous or public trigger endpoint. Typical setup is entering the Okta base URL, UPN and API token, testing the connection, mapping attributes, then enabling the desired provisioning direction.

---

- Provision new Drupal users into Okta automatically
- De-provision (block/remove) Okta users when Drupal accounts change
- Sync users from Okta into Drupal
- Map Drupal user fields to Okta attributes
- Configure the Okta base URL, UPN and API token
- Test the Okta connection by fetching a sample user
- Enable real-time provisioning on user create/update/delete
- Run cron/scheduler-based provisioning
- Sync user passwords where supported
- Review audits and logs of sync operations
- Restrict all sync configuration to administrators
- Request a 7-day trial of the premium features
- View upgrade plans for advanced provisioning
- Contact miniOrange support from the admin UI
- Flatten and inspect Okta user attributes for mapping
- Store the Okta base URL and UPN in module settings
- Send the Okta API token as an SSWS bearer header
- Fetch remote attribute lists to populate mapping options
- Bridge Drupal accounts with an external Okta identity store
- Audit which attributes are being synchronised
