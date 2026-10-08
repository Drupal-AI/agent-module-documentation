A Drupal Webform handler that maps webform submissions to AB InBev Customer Data Platform (Treasure Data) fields and posts them to the CDP postback API.

---

AbInBev CDP adds one Webform submission handler, the "CDP Settings Handler" (`cdp_settings_handler`), that you attach to any Webform. In the handler settings you map the webform's field machine names to CDP attributes (first name, last name, email, phone, birthday, language), map consent/purpose checkboxes (TC-PP, marketing, newsletter), and enter campaign metadata (campaign name, form id, brand, interests, country). On each submission the handler builds a Treasure Data event payload (`abi_firstname`, `abi_email`, `purpose_name`, etc.), resolves the country to a Treasure Data zone, and POSTs it to `https://in.treasuredata.com/postback/v3/event/...` using the configured CDP write key. It supports a dev/prod toggle with separate keys, dynamic country-from-language, arbitrary extra field mappings, and an optional 18+ age gate based on a birthday field. Because the handler has unlimited cardinality, several webforms (or several handlers on one form) can each push to the CDP with their own configuration.

---

- Capture newsletter or marketing sign-ups from a Drupal Webform straight into the AB InBev CDP.
- Push webform lead data (name, email, phone) to Treasure Data for a beer/beverage brand campaign.
- Map an existing webform's field machine names to CDP attributes without changing the form.
- Record marketing-consent (opt-in) state per submission as `MARKETING-ACTIVATION` / `MARKETING-ACTIVATION-NOT-GIVEN`.
- Record personalization/newsletter consent as `PERSONALIZATION` / `PERSONALIZATION-NOT-GIVEN`.
- Record terms/privacy acceptance (TC-PP) when a consent checkbox is ticked.
- Run separate dev and production CDP write keys and switch between them per environment.
- Tag every submission with campaign name, form id, and brand for downstream CDP reporting.
- Set a fixed campaign country, or derive the country automatically from the page language.
- Send additional custom attributes to the CDP via `cdp_field|webform_field` mapping rows.
- Enforce an 18+ age gate at submission time using a mapped birthday field.
- Attach the same CDP push to multiple webforms, each with its own field mapping and campaign.
- Localize the CDP `abi_preferred_language` value from a language field or the current interface language.
- Automatically route a submission to the correct Treasure Data regional zone (eur, naz, saz, apac, africa, midam) from the selected country.
- Include the Treasure Data client id cookie (`_td`) so submissions unify with front-end tracking.
- Collect interests as a campaign-level attribute (`abi_interests`) on each lead.
- Stand up a lightweight CDP ingestion path without writing a custom module or REST client.
- Reuse one form across markets by switching only the country/language and CDP key settings.
- Feed event data to Treasure Data using its `postback-api-1.2` import method with optional unification.
- Let site builders manage the whole integration from the Webform UI (Emails/Handlers tab) with no code.
