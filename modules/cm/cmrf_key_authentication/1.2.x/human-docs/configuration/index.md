# Configuration

This module does nothing until you tell it how to reach CiviCRM and which fields
to read. All of that lives on one settings form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Web services → CMRF Key Authentication**, or navigate
   directly to `/admin/config/services/cmrf_key_authentication`.

## Lookup — who the key belongs to

These settings describe the CiviCRM API call the module makes to resolve a key
into a contact:

- **CiviCRM connection** — the CiviMRF connection (defined in CMRF Core) to use.
- **CiviCRM API version** — 3 or 4.
- **API entity** and **API action** — the CiviCRM entity and action queried to
  look up a key (plus a "get fields" action used to discover available fields).
- **Field names** — tell the module which CiviCRM fields hold the **key**, the
  **email**, the **user id**, the client **IP**, and the **roles**. These map
  CiviCRM's field names to the concepts the module needs.
- **Additional parameters** — extra API parameters as JSON (Drupal tokens are
  replaced before the call), for narrowing or filtering the lookup.

Authentication succeeds **only when the CiviCRM call returns exactly one record**
for the supplied key plus email/user id. The comparison happens inside CiviCRM,
not as a local string match, and an empty or missing key simply produces no
match.

## Field mapping and tokens

- **Mapping** — a JSON map of CiviCRM fields to Drupal user fields. The matched
  CiviCRM values populate the virtual account and are also exposed as user
  tokens (for example `[user:cmrf_key_authentication_field_*]`), so you can
  surface CRM data elsewhere on the site.
- **Roles field** — the CiviCRM field whose value assigns Drupal roles to the
  logged-in user.

## How the key is supplied

- **URL query parameters** — set the parameter names used for the key, email,
  and user id. Convenient, but remember keys in URLs can leak via logs, history,
  and `Referer` headers — prefer the options below where you can.
- **JWT** — set the parameter name that carries the token. The JWT is verified
  (HS256) with your configured **secret key**; its claims supply the key and
  optionally the email/user id.
- **Login forms** — `/user/civicrm_login_request` emails a login code to the
  user (via a CiviCRM API action you configure), and `/user/civicrm_login` is
  where they enter it.

## Session and timeout

- **Log out after** — minutes of inactivity before the mapped CiviCRM session
  data is cleared and the user is logged out. Key-authenticated requests bypass
  the page cache, and logging out clears the cached CiviCRM data.

## Save

Click **Save configuration**. Test the full flow — request a code (or present a
key/JWT) and confirm the user is logged in with the expected fields and roles —
before relying on it in production.
