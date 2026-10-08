# Configuration

GDPR One Trust Implementation is configured from a single settings form where you
supply the identifier that ties your site to your OneTrust account.

## Open the settings form

1. Log in as a user with the **`One Trust Access`** permission (spelled with a
   space and capitals — note this if you assign it in a role's config by hand).
2. Go to **Configuration → System → GDPR OneTrust**
   (`/admin/config/system/gdpr-onetrust`).

## The settings

- **OneTrust UUID / script identifier** — the identifier you obtain from your
  OneTrust account (the data‑domain script ID / UUID). The module uses it to render
  the correct banner for your account. Paste it in and save.

Once saved, the OneTrust banner from your account appears on the site: visitors are
told cookies are being set and can give consent or open a details page for more
information about the cookies in use.

## Getting consent right

- **Enable the blocking submodule.** Recording consent isn't enough on its own —
  `onetrust_cookie_blocking` is what stops trackers from firing before opt‑in.
  Without it, a script may already have run by the time the banner is answered.
- **Verify which scripts are blocked.** Scripts attached through Drupal's asset
  system (by your theme or other modules) are not governed by the blocker unless
  they're deliberately wired in. Check each tracker you care about.
- **Watch your caching.** A consent decision is per‑visitor, but a fully cached page
  with a script tag in it serves that script to everyone. Make sure your caching
  strategy doesn't undermine the per‑visitor consent behaviour.

Because the banner and blocking logic ultimately load from OneTrust, the usual
third‑party considerations apply: visitor page loads reach OneTrust's servers, and
your OneTrust account holds the cookie register and consent records.
