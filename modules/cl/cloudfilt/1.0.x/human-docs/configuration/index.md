# Configuration

CloudFilt needs your account keys before it can check any traffic, so this step is
required — not optional tuning.

## Open the settings form

1. Log in as a user who can administer site configuration.
2. Go to **Configuration → Web services → CloudFilt**, or navigate directly to
   `/admin/config/services/cloudfilt`.

## Enter your CloudFilt keys

The form asks for the two credentials from your CloudFilt account:

- **Public key** — your CloudFilt public identifier.
- **Private key** — the matching secret. Treat this as a password: it authorises
  your site's calls to the CloudFilt service.

> **Keep the private key out of version control.** The recommended pattern on this
> project is to store the secret in an environment variable via DDEV
> (`ddev dotenv set .ddev/.env --cloudfilt-private-key=<value>`, then
> `ddev restart`) and reference it from `settings.php` with `getenv()` rather than
> pasting it into exported configuration. Never commit the raw key.

Once both keys are saved, CloudFilt begins checking each request's IP against the
service and blocking traffic flagged as bots, scrapers, Tor, spam, fraud or DDoS.

## Skip specific user roles (optional)

The form also lets you select **user roles that CloudFilt should not check**. This
is handy for, say, exempting logged‑in administrators so their activity does not
clutter your CloudFilt dashboard. Tick any roles you want to bypass the check;
leave them unticked to filter everyone.

## Save

Click **Save configuration**. Filtering takes effect immediately.

## Good to know

- Because CloudFilt is queried on **every request**, it adds a small amount of
  latency and makes your site depend on the CloudFilt service being reachable.
  Confirm the fail‑open / fail‑closed behaviour you want if CloudFilt is ever
  unavailable, so an outage does not accidentally block all visitors.
- The module sends each visitor's **IP address** to CloudFilt. An IP is personal
  data — mention this external data transfer in your site's privacy policy.
