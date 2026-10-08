Constant Contact Module integrates the Constant Contact email-marketing API v3 with Drupal: it authorizes an account via OAuth2, lets you enable specific contact lists, and adds those lists' signups to the site through per-list blocks, a webform handler, an entity field type ("subscribe on save"), and an optional REST endpoint. Contacts submitted from any of these paths are created/updated on Constant Contact via the shared `ik_constant_contact` service.

---

You configure an app's API key and secret either in `settings.php` (`$settings['ik_constant_contact']`) or in the admin form at `/admin/config/services/ik-constant-contact` (route `ik_constant_contact.config`, permission `administer constant contact configuration`), then click Authorize to run the OAuth2 authorization-code flow; the callback at `/admin/config/services/ik-constant-contact/callback` exchanges the code for access/refresh tokens, which are stored in the `ik_constant_contact_tokens` database table (legacy installs used config). Tokens are refreshed before each API call and on cron (`hook_cron` also prunes expired tokens and re-caches lists). On the Lists tab you enable lists (stored in `ik_constant_contact.enabled_lists`); each enabled list yields a block derivative (`ConstantContactBlock`), and there is also a multi-list block. The central `ConstantContact` service wraps Guzzle calls to the API (`createContact`, `updateContact`, `putContact`, `submitContactForm`, `getContactLists`, `getCustomFields`, `getCampaigns`, `unsubscribeContact`, etc.), applying field mapping from `buildResponseBody()` and firing alter hooks so other modules can add custom fields. A `constant_contact_lists` field type (with `constant_contact_lists_default`/`_checkbox` widgets and a formatter) can be added to any entity; with "subscribe on save" enabled it maps entity fields to Constant Contact fields and subscribes/unsubscribes contacts on entity insert/update/delete. A Webform handler ("Constant Contact") sends webform submissions to a chosen list with YAML mergevars and token support. An optional REST resource (`POST /constant_contact/{list_id}`) accepts signups for enabled lists. API credentials/tokens are admin-supplied and stored per the operator's choice (settings.php or config/DB); no secrets are shipped in the module.

---

- Add a newsletter signup block to a page for a single Constant Contact list.
- Offer a multi-list signup block letting visitors pick which lists to join.
- Send Webform submissions to a Constant Contact list via the bundled webform handler.
- Map webform fields to Constant Contact fields using YAML mergevars with token replacement.
- Subscribe a user/contact automatically when a content entity is saved ("subscribe on save").
- Unsubscribe a contact automatically when the entity is deleted (unsubscribe on delete).
- Add a `constant_contact_lists` field to a content type so editors pick target lists per entity.
- Collect extra contact fields (first/last name, company, phone, address, birthday, anniversary) on a signup form.
- Include Constant Contact custom fields on a signup block form using their custom field IDs.
- Expose a REST endpoint so a decoupled front end can POST signups to an enabled list.
- Authorize a Constant Contact account through OAuth2 from the Drupal admin UI.
- Store API credentials securely in settings.php instead of the database.
- Refresh OAuth access tokens automatically on cron so the integration stays connected.
- Enable or disable individual contact lists for use in blocks/endpoints from the Lists tab.
- View available Constant Contact custom field IDs at the Custom Fields admin tab.
- Alter the contact payload before it is sent using `hook_ik_constant_contact_contact_data_alter`.
- Add company or other custom values on create/update via the create/update alter hooks.
- Show a custom success message and rich body text per signup block.
- Resubscribe previously-deleted/unsubscribed contacts (the service detects deleted contacts and PUTs them back).
- Prune expired API tokens automatically to keep the tokens table tidy.
- Drive campaign lookups (get campaigns, campaign activities, permalinks) programmatically via the service.
- Require an email field when a subscribe-on-save list field is populated (built-in form validation).
- Provide list options to Webform select elements automatically for the Constant Contact list options set.
