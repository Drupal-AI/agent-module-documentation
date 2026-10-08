<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bigin CRM Integration registers every new Drupal user account (matching selected roles) as a contact and deal in Zoho Bigin CRM through the Bigin REST API, authenticated with Zoho OAuth2.

---

The module hooks Drupal user creation (`hook_user_insert`) and, when the new account holds one of the admin-selected roles, calls the Bigin REST API to create a Contact (Last name + email) and an associated Deal on a configured pipeline/layout/stage/owner. An admin registers a Zoho API-console client, enters the Client ID/Secret and data-center domain (`.com/.eu/.cn/.in`), runs the OAuth2 authorization-code flow from the settings page to obtain and store access/refresh tokens, then configures the pipeline, sub-pipeline, stage, closing date, owner, deal name and description that every new deal uses. All API traffic goes over Zoho's HTTPS endpoints; tokens are stored locally and auto-refreshed on 401. It provides one permission (`administer crm integration`), two config forms, an OAuth callback/revoke controller and four services; it defines no entities, fields or Drush commands.

---

- Automatically create a Zoho Bigin contact for each new Drupal registrant.
- Create a Bigin deal on a chosen pipeline for each new contact.
- Limit sync to specific Drupal roles (only selected roles are pushed).
- Connect Drupal to a Zoho Bigin account using the OAuth2 authorization-code flow.
- Select the Zoho data-center domain (.com, .eu, .cn, .in) so all URLs target the right region.
- Store and auto-refresh the Bigin access token (refresh on 401 responses).
- Revoke the stored Bigin token from the admin UI when disconnecting.
- Assign a default deal owner (Bigin user) to new contacts and deals.
- Choose the Bigin layout/pipeline that new deals land on.
- Set a sub-pipeline and open stage for new deals.
- Configure a relative closing date (e.g. `+5 days`) applied to each new deal.
- Give every generated deal a fixed name and optional description.
- Feed lead PII (display name + email) from Drupal registration into a small-business CRM.
- Pull the list of Bigin users to populate the owner select on the settings form.
- Pull the list of Bigin deal layouts to populate the pipeline select.
- Provide a Configuration > Services admin page for CRM settings.
- Restrict CRM configuration to users with the `administer crm integration` permission.
- Serve marketing/sales teams that use Zoho Bigin instead of full Zoho CRM.
- Onboard newly registered members into a sales pipeline automatically.
- Track site sign-ups as CRM prospects without manual data entry.
- Support multi-data-center Zoho deployments via the domain selector.
