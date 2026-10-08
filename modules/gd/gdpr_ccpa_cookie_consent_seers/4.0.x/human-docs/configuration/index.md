# Configuration

The module's job is to load your Seers cookie‑consent banner into the site, so
configuration comes down to connecting your Seers account. The banner's own
appearance and behaviour — layouts, colours, cookie scanning, consent categories,
reports — are all managed in the Seers dashboard, not in Drupal.

## Connect your Seers account

1. In your **Seers account** (https://seers.com/), create and configure your cookie
   consent banner, then obtain its **embed script** or **site identifier**.
2. Log in to your Drupal site as an administrator and open the module's settings
   form (look for the Seers Cookie Consent settings under **Configuration**).
3. Provide the Seers script / identifier you copied from Seers, and save.

Once saved, the module injects the Seers script into your site's header, and the
banner renders on your pages. Visitors' consent choices are recorded through Seers.

## Privacy, egress, and secrets

- **Third‑party egress.** Every page that shows the banner loads a script from
  Seers' servers, and consent data is processed by Seers. Reflect this in your
  privacy policy and any data‑processing agreements with your users.
- **Keep credentials secret.** Any account key or token you receive from Seers
  should be stored in an environment variable, never committed to configuration or
  version control. With DDEV you can hold such a value with
  `ddev dotenv set .ddev/.env --seers-key=<value>` then `ddev restart`.
- **Consent must actually gate trackers.** As with any consent banner, make sure
  your other tracking scripts don't fire before the visitor has consented — a
  banner alone doesn't make the site compliant.
