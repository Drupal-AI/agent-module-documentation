Salesforce Address provides a "Salesforce-ready Address" field widget (`salesforce_ready_address`) for Address fields that renders the street address as a single textarea, matching how Salesforce stores a multi-line street, so mapping to a Salesforce address field is clean.

---

The module adds one field widget, `salesforce_ready_address` ("Salesforce-ready Address", `AddressDefaultWidgetStreetAsTextArea`), for `address` fields (from the contrib Address module). It behaves like the default address widget but presents the street as a **textarea** rather than separate address-line inputs, because Salesforce address fields hold a single multi-line street value; capturing it as one textarea makes push/pull mapping to Salesforce's `Street`/`MailingStreet` style fields straightforward. You select it on the entity's Manage form display for any address field. It has no configuration, permissions, plugins, or Drush of its own — it is purely an alternate widget. Depends on the `address` module.

---

- Capture a Salesforce-compatible multi-line street in a single textarea.
- Map a Drupal address field cleanly to a Salesforce address (Street) field.
- Use on a contact/organization address field synced to Salesforce.
- Replace separate address-line inputs with one street textarea.
- Keep Drupal address entry aligned with Salesforce's data model.
- Select the widget on any address field via Manage form display.
- Avoid manual concatenation of address lines before pushing to Salesforce.
- Support pull of a Salesforce street value into one Drupal field.
- Apply to a user profile address field for CRM sync.
- Apply to a content type's address field.
- Standardize address entry across entities synced to Salesforce.
- Pair with salesforce_mapping to map the street field.
- Reduce mapping friction for MailingStreet/BillingStreet.
- Provide a drop-in alternative to the default address widget.
- Keep the rest of the address (city, state, zip, country) as usual.
- Use for commerce or CRM addresses destined for Salesforce.
- Improve editor UX for multi-line streets.
- Enable clean round-tripping of street data with Salesforce.
- Configure per form mode (default vs custom).
- Require no extra configuration beyond selecting the widget.
