# Configuration

Modovisa has a short, single settings form. Nothing is tracked until you complete
it, so this page is required reading rather than optional tuning.

## Open the settings form

1. Log in as a user with the **Administer Modovisa** (`administer modovisa`)
   permission (an administrator by default).
2. Go to **Configuration → System → Modovisa**, or navigate directly to
   `/admin/config/system/modovisa`.

## Fields

- **Enable Modovisa tracking** — a checkbox that turns the snippet on. Leave it
  unchecked and no script is injected, even if a token is present. Tick it once you
  are ready to start tracking.
- **Tracking token** — paste the token from your Modovisa project here. This is the
  value that ties the injected script to your account, so tracked data shows up in
  the right Modovisa project. Save the form after entering it.

## After saving

Clear caches at **Configuration → Development → Performance**
(`/admin/config/development/performance`) or with `drush cr`, then reload a public
page. The tracker script should now appear in the page `<head>` on all non‑admin
pages.

## Domain matching

The domain configured in your Modovisa project must match your Drupal site's domain
**including the subdomain** — for example `drupal.example.com` is treated as
different from `example.com`. If tracking data is not appearing, a domain mismatch
is the first thing to check.

## Privacy and consent

Modovisa loads a **third‑party tracking script** from an external CDN and records
visitor activity. Make sure this is reflected in your site's privacy policy and,
where required by law (for example GDPR/ePrivacy in the EU), that it fits within
your consent‑management approach before enabling it on a production site.

## The tracking token is not a Drupal secret

The tracking token is written into the public page source by design — it is a
publishable site identifier, not a private API credential. There is no server‑side
API call and nothing to store in a Key entity or environment variable; you simply
paste the token into this form.
