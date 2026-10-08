# Live Search - Person — manual setup guide

**Live Search - Person** (`livesearch_person`) connects a Webform to an external
"Live Search" person‑directory API (from Data Factory) so that a form can look up
people and **autofill** their contact and address details from a typed search
string. As a visitor types into a designated search field, the module queries the
directory and fills in name, address, city, postal code, and date of birth on the
form — cutting manual data entry on intake and contact forms.

It works by keeping your API key **server‑side**: front‑end JavaScript posts the
search string to an internal Drupal route, which calls the directory API with your
key in an `X-API-Key` header, normalizes the returned records, and maps the values
onto your webform fields. The key never appears in client‑side code.

Two things deserve careful thought before you deploy this:

- **It returns personal data (PII).** The directory returns names, addresses, and
  dates of birth. Handle that data — and where you expose the lookup — responsibly.
- **The internal search route is gated only by the "access content" permission**,
  which on a default Drupal site is granted to anonymous users. That means anyone
  who can load the form can drive person lookups through your server‑side API key.
  If the directory is at all sensitive, **tighten the `access content` permission or
  place the feature behind an authenticated form** before going live.

It depends on the **Webform** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter the API endpoint and key, then
   map the search and result fields per webform.

## Where it lives in the admin menu

Live Search - Person has two admin surfaces:

- **Service credentials** — the Live Search configuration form at
  `/admin/config/services/livesearch-person` (permission **administer livesearch**),
  with a **Test Connection** tab at `/admin/config/services/livesearch-person/test`.
- **Per‑webform mapping** — on each webform's settings at
  `/admin/structure/webform/manage/{webform}/settings/livesearch` (requires the
  ability to update that webform), where you pick the search field and map result
  properties onto webform elements.

## How to use it

1. Enter the directory endpoint URL and API key on the service configuration form.
2. On the webform you want to enhance, open its Live Search settings, choose the
   search field, and map the returned properties (full name, first/last name,
   address, city, postal code, date of birth) onto your webform elements.
3. As users type in the search field, matching person details autofill the mapped
   fields.
