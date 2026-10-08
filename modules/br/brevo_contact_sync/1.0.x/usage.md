<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Brevo Contact Sync pushes each saved Drupal user to a Brevo (Sendinblue) contact list, mapping chosen user fields to Brevo contact attributes.

---

Brevo Contact Sync is a thin bridge on top of the `sendinblue_api` module. An administrator opens a mapping form (a tab under the Sendinblue API config, at `/admin/config/services/sendinblue-api/contact-mapping`), picks one of the Brevo contact lists pulled live from the account, and builds a table of rows that each pair a Drupal user field with a Brevo contact attribute. A per-row "Value" selector picks how a complex field is read — for example a list field's stored key versus its human label, or a specific sub-property of an address, link, file or entity-reference field. On every user entity save a `hook_entity_presave` implementation reads the saved mappings, extracts the values, and calls the official Brevo PHP SDK: if the user's email already exists as a Brevo contact it is updated, otherwise it is created, and either way the contact is added to the selected list. Credentials come from the `sendinblue_api` module's stored API key; this module stores no key of its own.

---

- Automatically add every newly registered Drupal user to a Brevo mailing list.
- Keep an existing Brevo contact updated whenever the matching Drupal user is edited.
- Map the user's display name (`name`) to a Brevo contact attribute.
- Map the user's email to the Brevo contact (email is always the contact key).
- Push a custom `field_first_name` / `field_last_name` user field into Brevo attributes.
- Sync a user's account status (`status`) or roles into a Brevo attribute.
- Map an address field's city, postal code, country or given/family name to separate Brevo attributes.
- Send the label of a list (`list_string`) field, or alternatively its stored key, using the Value selector.
- Map a boolean user field to a true/false Brevo attribute (e.g. a marketing opt-in flag).
- Map an entity-reference field either by referenced entity label or by target ID.
- Push a link field's URL or its link text into Brevo.
- Map a file/image field's URI or filename to a Brevo attribute.
- Choose which Brevo contact list receives the synced users from a live dropdown of your account's lists.
- Build multiple field-to-attribute rows and add/remove them dynamically via AJAX.
- Segment your user base into a Brevo list for targeted email campaigns.
- Ensure marketing contact data stays consistent with the site's authoritative user records.
- Bootstrap a Brevo audience from an existing Drupal user base by re-saving users.
- Reuse the Brevo API key already configured in the Sendinblue API module (no separate credential setup).
- Restrict mapping configuration to administrators holding the Sendinblue API admin permission.
- Support both Drupal 10 and Drupal 11 sites.
