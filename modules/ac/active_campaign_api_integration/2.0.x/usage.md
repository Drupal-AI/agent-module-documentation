<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Active Campaign API Integration connects a Drupal site to ActiveCampaign, syncing form/registration submissions to contacts and giving admins a dashboard to manage lists, contacts, deals, pipelines and stages.

Use it to push newly-registered users or mapped form data into ActiveCampaign and to administer common CRM objects from within Drupal.

- Stores one or more API key + account URL pairs.
- Maps arbitrary form fields (and user registration fields) to ActiveCampaign fields.
- Adds submit handlers to mapped forms (contact sync / contact add).
- `hook_user_insert` pushes new users to ActiveCampaign per the active mapping.
- Dashboard controllers for lists, contacts, imports, deals, pipelines, stages.

---

Install and configure:

- Enable `drush en active_campaign_api_integration` (requires `ext-intl`).
- Get an API URL + token from ActiveCampaign; save them via the settings form.
- Visit `/admin/config/active-campaign` (dashboard) to reach all tools.
- Map a target form at `/admin/config/active-campaign/active-campaign-forms` then map its fields.
- For user sync, configure the registration mapping page and enable at least one mapping.

---

- Configure keys under `admin/config/active-campaign/active-campaign-settings`.
- The `ApiCaller` class wraps ActiveCampaign v3 endpoints (contacts, lists, deals, dealGroups, dealStages, groups, campaigns).
- All outbound calls use cURL with the `Api-Token` header and default TLS verification (verification is NOT disabled).
- Contact IDs are numerically filtered before use in API URLs.
- `contactSync`/`contactAdd` handlers fire on mapped form submission.
- `user_insert` builds a contact payload from mapped user fields and custom fields.
- Manage lists: create, view, delete, assign contacts, group permissions.
- Manage deals across contacts (duplicate per contact or single deal + secondary contacts).
- Create pipelines (dealGroups) and stages (dealStages).
- Import/list contacts and unsubscribe contacts from lists.
- All admin routes require the (misnamed) `administrator` permission → effectively only user 1 unless a permission literally named "administrator" exists; harden by editing routing if broader admin access is needed.
- Field mappings and keys are stored in module DB tables.
- Templates render dashboard listings.
- Keep the ActiveCampaign token secret; store it outside VCS.
- Verify sync in ActiveCampaign after configuring a mapping.
