Integrate Drupal with Bitrix24 CRM, exporting Drupal entities (leads, deals, contacts, products) over the Bitrix24 REST API.

---

The `b24` project is a base module plus five submodules that push data from Drupal into a Bitrix24 CRM portal. The base module handles OAuth2 authentication against a Bitrix24 "local application", stores credentials in config and tokens in state, and exposes a `RestManager` service that wraps the `crm.*` REST methods (add/update/delete/get/list for leads, deals, contacts and products) plus lead/deal product rows and CRM-mode detection. A `ReferenceManager` service keeps a `b24_reference` table linking each exported Drupal entity to its Bitrix24 counterpart (by hash, to skip unchanged updates). All configuration lives under `/admin/config/b24/*`, gated by the `administer b24 configuration` permission. Field mapping is token-aware (via the `token` dependency), and outbound field values can be altered with `hook_b24_push_alter()`. The submodules layer specific sources onto this: Commerce orders/products, core contact-form submissions, Drupal user sync (two-way), UTM attribution marks, and Webform submissions.

---

- Connect a Drupal site to a Bitrix24 CRM portal using the Bitrix24 local-application OAuth2 flow.
- Configure the Bitrix24 domain, application `client_id` and `client_secret` at `/admin/config/b24/credentials`.
- Request and store an OAuth access/refresh token via the `/b24/oauth` callback and refresh it automatically on cron.
- Push new Drupal-originated records into Bitrix24 as CRM leads, deals or contacts.
- Automatically assign newly created Bitrix24 entities to a chosen Bitrix24 assignee user (or a manually entered user ID).
- Detect and honor the portal's CRM mode (Classic → leads, Simple → deals) automatically.
- Programmatically create a lead from custom code with `RestManager::addLead()`.
- Programmatically create or update deals and contacts (`addDeal`, `updateDeal`, `addContact`, `updateContact`, `deleteContact`).
- Keep a mapping between Drupal entities and Bitrix24 records so updates target the existing record instead of duplicating it.
- Skip redundant Bitrix24 updates when a Drupal entity's mapped field values are unchanged (hash comparison).
- Alter outbound field values before they are sent to Bitrix24 with `hook_b24_push_alter()`.
- React to Bitrix24 create/update/delete operations via `B24Event` (`b24.entity.insert/update/delete`).
- Export Commerce orders to Bitrix24 leads or deals, with billing-profile and customer token substitution (b24_commerce).
- Export Commerce product variations and taxonomy sections to the Bitrix24 catalog, and attach ordered products as product rows (b24_commerce).
- Batch-export the whole product catalog to Bitrix24 from an admin form (b24_commerce).
- Export core contact-form submissions to Bitrix24 leads with per-form field mapping (b24_contact).
- Synchronize Drupal users to Bitrix24 contacts live on user create/update/delete, filtered by role (b24_user).
- Batch-export existing Drupal users to Bitrix24 contacts, and batch-import Bitrix24 contacts back into Drupal users (b24_user).
- Attach captured UTM marks (utm_source/medium/campaign/content/term) to exported leads (b24_utm).
- Export Webform submissions to Bitrix24 leads via a Webform handler with a field-mapping UI (b24_webform).
- Use Drupal tokens and custom static values when mapping Drupal fields to Bitrix24 lead/deal/contact fields.
