International Phone provides a `phone_international` field type with a country-aware widget (built on the intl-tel-input JS library) that lets editors pick a country flag/dial code and enter a number, validated and normalized to E.164 with libphonenumber, and rendered as a clickable `tel:` link.

---

The module defines a field type `phone_international` (single `varchar(256)` value) whose default widget `phone_international_widget` renders the intl-tel-input control: a country selector plus number input. Per-widget settings control the country list — `initial_country` (default `PT`), `geolocation` (auto-detect the user's country, overriding the default), `preferred_countries` (pinned to the top, default `['PT']`), `countries` (`all` / `exclude` / `include`), and `exclude_countries` (the list to include or exclude). On save, the field's `preSave()` runs the value through the `phone_international.validate` service (`ValidatingService`), which uses libphonenumber's `PhoneNumberUtil` to parse and reformat the number to **E.164** (e.g. `+351...`); the same service validates input in the form element. The default formatter `phone_international_formatter` renders valid numbers as a `tel:` link and invalid ones as plain text. A single global setting lives in `phone_international.settings`: `cdn` (boolean) — whether to load the intl-tel-input assets from a CDN; the settings form is at `/admin/config/phone_international` (permission `administer site configuration`). For a local (non-CDN) copy of the JS library, the Drush command `phone_international:plugin` (aliases `piplugin`, `pi-plugin`) downloads intl-tel-input into the `libraries/` directory. The module also ships a reusable `phone_international` render/form element and a Feeds target for imports. It requires the PHP library `giggsey/libphonenumber-for-php` (pulled in by Composer).

---

- Add an international phone field to a contact or profile content type.
- Let editors pick a country flag and dial code when entering a phone number.
- Store phone numbers normalized to E.164 for consistency across countries.
- Validate that an entered number is a real, possible number for its country.
- Render phone numbers as clickable `tel:` links on the site.
- Auto-detect the visitor's country via geolocation to preselect the flag.
- Pin a set of preferred countries to the top of the selector.
- Restrict the selectable countries to an allow-list with the `include` mode.
- Hide certain countries from the selector with the `exclude` mode.
- Set a default country (e.g. GB, US, PT) for new phone inputs.
- Collect mobile numbers for SMS or verification workflows.
- Provide a consistent phone widget across multiple content types.
- Import phone numbers via Feeds using the module's Feeds target.
- Serve the intl-tel-input assets from a CDN or from a local libraries copy.
- Install the JS library locally with the `phone_international:plugin` Drush command.
- Reuse the `phone_international` form element in a custom form.
- Validate phone input programmatically via the `phone_international.validate` service.
- Format an arbitrary string to E.164 with the service's `formatNumber()`.
- Show invalid numbers as plain text instead of a broken link.
- Capture international customer phone numbers in a webform-like flow.
- Standardize stored phone formats before syncing to a CRM.
- Give a multilingual site locale-appropriate country ordering.
- Enforce whole, valid numbers at form submission time.
- Support user-profile "mobile"/"landline" phone fields with country context.
