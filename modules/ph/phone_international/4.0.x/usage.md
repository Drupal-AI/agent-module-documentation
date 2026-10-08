International Phone provides a `phone_international` field type with a country-aware widget (built on the intl-tel-input JS library, v25.3+) that lets editors pick a country flag/dial code and enter a number, validated and normalized to E.164 with libphonenumber, and rendered as a clickable `tel:` link.

---

The module defines a field type `phone_international` (single `varchar(256)` value) whose default widget `phone_international_widget` renders the intl-tel-input control: a country selector plus number input. Per-widget settings control the country list and display — `initial_country` (default `PT`), `geolocation` (auto-detect via `ipinfo.io`, overriding the default), `preferred_countries` (pinned to the top, default `['PT']`), `countries` (`all` / `exclude` / `include`), `exclude_countries` (the list to include or exclude), plus new 4.0 options `dial_code` (show the separate country dial code beside the flag), `national_number` (national vs full-number display, default TRUE), and `auto_placeholder` (`off` / `aggressive` / `polite`, default `aggressive`). On save, the field's `preSave()` runs the value through the `phone_international.validate` service (`PhoneNumberValidatingService`), which uses libphonenumber's `PhoneNumberUtil` to parse and reformat the number to **E.164** (e.g. `+351...`); the same service validates form input. Two formatters ship: `phone_international_formatter` (valid numbers → `tel:` link, invalid → plain escaped text) and `phone_international_basic_string` (Plain text, extends core). A single global setting lives in `phone_international.settings`: `cdn` (boolean) — load the intl-tel-input assets from the jsDelivr CDN vs a local `libraries/` copy; the settings form is at `/admin/config/phone_international` (permission `administer site configuration`). For a local copy, the Drush command `phone_international:plugin` (aliases `piplugin`, `pi-plugin`) downloads intl-tel-input into `libraries/`. A `hook_runtime_requirements` check warns on the status report if the local library is missing or older than v25.3. The module also ships a reusable `phone_international` render/form element and a Feeds target for imports, and requires the PHP library `giggsey/libphonenumber-for-php` (pulled in by Composer).

---

- Add an international phone field to a contact or profile content type.
- Let editors pick a country flag and dial code when entering a phone number.
- Store phone numbers normalized to E.164 for consistency across countries.
- Validate that an entered number is a real, possible number for its country.
- Render phone numbers as clickable `tel:` links on the site.
- Show phone numbers as plain text with the `phone_international_basic_string` formatter.
- Auto-detect the visitor's country via geolocation to preselect the flag.
- Display a separate country dial code beside the flag with the `dial_code` setting.
- Show an example-number placeholder that updates with the country (`auto_placeholder`).
- Toggle national-number vs full-number display in the input.
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
- Standardize stored phone formats before syncing to a CRM.
- Give a multilingual site locale-appropriate country ordering.
- Enforce whole, valid numbers at form submission time.
- Support user-profile "mobile"/"landline" phone fields with country context.
