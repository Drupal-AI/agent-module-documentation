<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
miniOrange Azure AD / B2C Synchronization provisions and de-provisions user accounts between Drupal and Microsoft Azure AD / Azure AD B2C using the Microsoft Graph API.

---

The module is an admin-configured connector under `/admin/config/people/azure_ad/*`: an overview/setup wizard (`MoAzureOverview`), Drupal→Azure and Azure→Drupal sync configuration forms, attribute/role mapping (`MoAzureMapping`), automatic and manual/on-demand provisioning forms, advanced settings, audit logs, and a review-config step. Graph/OAuth endpoints are declared as constants in `src/moAzureConstants.php` (`login.microsoftonline.com/{tenant}/oauth2/v2.0/token` and `authorize`, `graph.microsoft.com` user endpoints, scope `https://graph.microsoft.com/.default`); the actual directory calls and the client credentials/token handling are performed through its required `user_provisioning` dependency. The callback URL helper forces the base URL to `https:`. Every route in `azure_ad.routing.yml` requires `administer site configuration`.

As a miniOrange product the UI includes trial/upgrade/support screens (request-trial modal, customer support form) that communicate with miniOrange, and much functionality (real-time sync, larger user volumes) is gated behind a paid plan. Operationally you register an Azure AD app, supply tenant/client id/secret, map attributes and roles, then run manual or automatic provisioning. Because it handles Azure client credentials, store secrets via a Key/env rather than plain config and review what the support/trial forms transmit before submitting.
---
Provision new Drupal users into Azure AD.
- De-provision (disable/remove) users from Azure AD.
- Import users from Azure AD / B2C into Drupal.
- Configure the Azure tenant, client id, and client secret.
- Map Drupal user fields to Azure AD attributes.
- Map Azure AD groups/roles to Drupal roles.
- Set up automatic provisioning on user events.
- Run manual / on-demand provisioning for selected users.
- Trigger a manual user sync from the admin UI.
- Review the current Azure connection configuration.
- Inspect Azure sync audit logs.
- Adjust advanced sync settings.
- Use the setup overview wizard to connect step by step.
- Generate the HTTPS callback URL for the Azure app registration.
- Restrict all sync configuration to site administrators.
- Connect to Azure AD B2C tenants as well as Azure AD.
- Request a miniOrange trial from the admin banner.
- Open a miniOrange support request from the UI.
- Keep Drupal accounts in sync with a corporate directory.
- Use Microsoft Graph for user lookups and provisioning.
- Configure attribute flattening for nested Graph responses.
