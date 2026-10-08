<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring miniOrange Azure AD / B2C sync

All screens live under `/admin/config/people/azure_ad/*` and require the `administer site configuration` permission. The real directory API calls and OAuth token exchange are delegated to the required **user_provisioning** module.

## 1. Register an Azure app
In the Azure portal create an App registration, grant Microsoft Graph application permissions for user read/write, and create a client secret. Use the callback URL produced by `MoAzureUtilities::createCallbackUrl()` (always forced to `https:`).

## 2. Connect (overview wizard)
`/admin/config/people/azure_ad/overview` (`MoAzureOverview`) walks through connecting. Enter **tenant**, **client id**, and **client secret**. Store the secret in an environment variable / Key entity where possible rather than plain config.

## 3. Choose sync direction
- **Drupal → Azure:** `/configure_azure` (`MoDrupalToAzureSync`) — push Drupal accounts into Azure AD/B2C.
- **Azure → Drupal:** `/azure_to_drupal_configure` (`MoAzureToDrupalSync`) — import Azure users into Drupal.

## 4. Map attributes and roles
`/mapping` (`MoAzureMapping`) maps Drupal user fields to Azure attributes and Azure groups/roles to Drupal roles. Nested Graph responses are flattened by the helper in `src/Helper/moAzureADHelper.php`.

## 5. Provisioning mode
- **Automatic:** `/configureautomaticprovisioning` (`MoAutomaticProvisioning`) — sync on user events.
- **Manual / on-demand:** `/configuremanualprovisioning` and `/manualuserSync` (`MoManualUserSync`) — sync selected users.

## 6. Operate
Review the connection at `/reviewconfig`, inspect `/azure_audit_logs`, and tune `/AdvanceSettings`. Endpoints/scopes are fixed in `src/moAzureConstants.php`.

## Licensing note
Trial (`requestTrialAzure`), upgrade-plans, and support/customer-request forms communicate with miniOrange; higher user volumes and real-time sync require a paid plan.
