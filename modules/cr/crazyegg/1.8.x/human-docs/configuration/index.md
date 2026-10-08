# Configuration

## Open the settings form

1. Log in as a user with the **Administer crazy egg** permission
   (`administer crazy egg`).
2. Go to **Configuration → System → Crazy Egg**, or navigate directly to
   `/admin/config/system/crazyegg`.

All settings are stored in the `crazyegg.settings` config object.

## The settings, field by field

- **Enable Crazy Egg** (`crazyegg_enabled`) — the master on/off switch, shown as *Yes*
  / *No* radios. The tracking script is only attached when this is set to *Yes*. Use
  *No* to temporarily disable tracking (for example during a site migration) without
  uninstalling the module.
- **Account number** (`crazyegg_account_id`) — your numeric Crazy Egg account number.
  The module turns this into the external script URL automatically (the account number
  is left-padded to eight digits and split into a `NNNN/NNNN` path, producing a URL
  like `https://script.crazyegg.com/pages/scripts/0123/4567.js`).
- **Script scope** (`crazyegg_js_scope`) — whether the script tag is placed in the
  page **header** (earliest load) or the **footer** (reduces render blocking). The
  script loads asynchronously in either case.
- **Paths** (`crazyegg_paths`) — a newline-separated list of path patterns that
  restricts which pages are tracked. Leave it **empty to track the whole site**, or
  list patterns like `/promo/*` to track only specific pages (for example marketing
  landing pages).
- **Excluded roles** (`crazyegg_roles_excluded`) — roles whose users are **not**
  tracked. Exclude administrators/editors so internal traffic doesn't skew your data,
  or exclude the authenticated role to track only anonymous visitors.

Click **Save configuration**. Changing these settings invalidates cached pages (the
config is registered as a cacheable dependency), so the updated snippet behavior takes
effect without a manual cache clear.

## How the script is applied

On each page request the module attaches the tracking library only when **all** of
these are true: tracking is enabled, an account number is set, the current path
matches your path rules, and the current user is not in an excluded role. Everything
runs in the visitor's browser — no data is sent from the Drupal server itself.

## A note on secrets

The Crazy Egg account number is entered directly in this form and stored in
`crazyegg.settings`, which is exportable configuration — convenient for keeping
staging and production in parity. The account number is an identifier rather than a
secret credential, so it is fine to keep in config. This module has no API key or
token field, so the DDEV dotenv / Key-entity pattern used for secret-bearing modules
is not needed here.
