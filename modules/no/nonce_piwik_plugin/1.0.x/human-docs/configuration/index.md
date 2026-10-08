# Configuration

The module tracks nothing until you configure it. All settings live on one form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Security → Nonce Piwik Plugin**, or navigate directly
   to `/admin/config/security/nonce-piwik-plugin`.

## Piwik PRO connection

- **Enable tracking** — the master on/off switch. Leave it off (while keeping the
  rest of your settings) on staging environments; turn it on in production. No
  tracker is rendered while this is off.
- **Container URL** — the Piwik PRO container URL from your Piwik PRO account.
  Required for tracking to work.
- **Site ID** — the Piwik PRO site (container) ID. Required.
- **Data‑layer name** — the name of the data‑layer variable, in case your Piwik
  PRO setup expects a specific name. Leave the default unless your configuration
  requires a different one.

## Cookie options

- **Secure / SameSite=Strict cookies** — options to force the tracker's cookies to
  be marked secure and `SameSite=Strict`. Enabling these is the consent‑ and
  privacy‑friendly choice for most sites.

## Where tracking appears

These filters decide, per request, whether the tracker renders. You can combine
them:

- **Path rules** — include or exclude tracking by request path. A default exclude
  list already keeps tracking off admin pages, batch operations and node add/edit
  paths. You can add your own excluded paths, and wildcards are supported.
- **User role** — limit tracking to (or away from) specific roles, for example to
  avoid tracking logged‑in editors.
- **Content type** — limit tracking to specific content types.

## Save and configure your CSP

Click **Save** to store the settings. Remember that this module supplies the
per‑request nonce, **not** the CSP policy itself — you must configure your site's
Content Security Policy separately so it permits the Piwik PRO host in the
directives your tracking setup needs. Without that, a strict CSP may still block
the tracker even though the nonce is present.

## Verify

Load a front‑end page that should be tracked and view its source: the Piwik PRO
inline script should carry a `nonce="…"` attribute, and that value should change on
each page load. Then confirm tracking does *not* appear on an excluded path (such
as an admin page).
