# Configuration

Meta Pixel needs configuration before it does anything — it has to know which Meta
pixel/dataset to talk to, and (for server-side tracking) how to authenticate to the
Conversions API. Just as importantly, this is a tracker that shares visitor data
with Meta, so the consent and privacy settings below are not optional extras — they
are part of running it lawfully.

## Open the settings form

Log in as a user with the **Administer site configuration** permission (an
administrator by default) and open the Meta Pixel settings form from the module's
configuration page under **Configuration**. This is where you connect your pixel
and choose which events are sent.

## Connect your Pixel / dataset

- **Pixel ID / dataset** — the numeric identifier of your Meta pixel (dataset),
  found in Meta Events Manager. This is what the browser-side `fbq` snippet
  reports to.

## Conversions API (server-side tracking)

The Conversions API sends events from your server directly to Meta, which keeps
working even when browser-side tracking is blocked. It authenticates with an
**access token** generated in Meta Events Manager.

- **CAPI access token** — treat this as a **secret**. Do not paste it into
  configuration that gets exported to code and committed to Git. Prefer storing it
  in an environment variable and referencing it from `settings.php`, or via a Key
  entity if the form supports one.

  With DDEV you can store the value out of version control like this:

  ```bash
  ddev dotenv set .ddev/.env --meta-capi-token=<value>
  ddev restart
  ```

  Then reference `getenv('META_CAPI_TOKEN')` from `settings.php` (never commit
  `.ddev/.env`).

Because browser and server events can both fire for the same action, the module
**deduplicates** them automatically so Meta counts each conversion once.

## Advanced matching and identifiers

Meta Pixel can collect multiple user identifiers — emails, phone numbers, and
address data drawn from the user account and (with Commerce) billing and shipping
sources — to improve attribution ("advanced matching"). These are toggles: enable
them only in line with your privacy commitments, since they increase the amount of
personal data shared with Meta.

## Consent and privacy

This is the part that matters most.

- **Cookie consent** — the module can integrate with the **EU Cookie Compliance**
  mechanism so the Pixel does not fire before a visitor has agreed to tracking.
- **Do Not Track** — the module can respect the browser's Do Not Track signal.
- **Disclosure** — describe the Meta Pixel and Conversions API tracking in your
  site's privacy policy.

Configure consent-gating first, then enable the events you need. Data (including
server-side identifiers via CAPI) is sent to Meta, so obtain consent, disclose the
tracking, and keep the CAPI token secret.

## Save

Save the form. Verify with the Meta Pixel Helper extension or your Meta Events
Manager that events arrive as expected, and confirm the Pixel does **not** fire
before consent is granted.
