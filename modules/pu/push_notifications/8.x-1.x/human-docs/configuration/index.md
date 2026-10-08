# Configuration

> **Compatibility caveat.** As noted in [Installation](../installation/index.md),
> this alpha release fatals on Drupal 11.4 and cannot be enabled there. Everything
> below assumes you have confirmed the module runs on your Drupal/Symfony version.

Configuration centers on two things: giving the module the **provider credentials**
it needs to talk to Apple/Google, and using its **mass-push interface** to send
notifications. Both live under **Configuration** once the module is enabled.

## Open the settings

Log in as an administrator and open the **Push Notifications** settings under
**Configuration**. This is where provider credentials and the mass-push tools live.

## Provider credentials

Enter the credentials for whichever service(s) you deliver through:

- **APNS (Apple Push Notification Service)** — upload/point to your **staging
  and/or production certificate**. Apple has moved to HTTP/2 with token-based
  authentication, so confirm the credential type this module expects still works
  against Apple's current endpoints before relying on it in production.
- **GCM (Google Cloud Messaging)** — enter your **GCM API key**. Note Google
  retired the legacy GCM/FCM APIs in 2024; verify current acceptance.
- **C2DM** — requires a **C2DM-enabled Google account** (legacy).

## Token registration options

- **Limit token registration to enabled languages** — restrict which site
  languages devices may register under.
- Tokens are registered and deleted through a **REST interface** (this needs the
  **Services** module). Device tokens are the iOS "device token" and the Android
  "registration id".

## Sending notifications

- **Mass push** — the module provides an interface to send a single push
  notification to **all users with a registered token**. You can **limit delivery
  to a specific language** so a message only reaches devices registered under it.
- **API functions** let custom code send a push to an individual device.

## Integrations

- **Rules** — adds actions to send a message to an individual user or to all users,
  plus events that react to tokens being inserted or deleted and to notifications
  being sent.
- **Views** — exposes token data in Views, and ships a default admin view listing
  all tokens.
- **PrivateMSG** — when activated on this configuration page (and with PrivateMSG
  7.x-1.x present), messages sent through PrivateMSG are also delivered as a push to
  all recipients with a valid device token.

## Treat device tokens as credentials and personal data

A device token identifies a device and can be used to push to it, so:

- **Protect the token store** as you would any credential store, and restrict who
  can view the Views-exposed token list.
- **Set a retention rule.** Tokens outlive the app installs that created them, so
  plan how stale tokens are pruned rather than letting them accumulate
  indefinitely.
- **Keep provider secrets out of version control.** Store any API key or
  certificate secret in an environment variable rather than exported config:

  ```bash
  ddev dotenv set .ddev/.env --gcm-api-key=<value>   # do not commit .ddev/.env
  ddev restart
  ddev exec 'test -n "$GCM_API_KEY"'                 # exit 0 means it is set
  ```

  Reference the variable from settings (via `getenv()`) or a
  [Key](https://www.drupal.org/project/key) entity where supported.

## Save

Save the settings form, then send a test mass push to a single registered test
device to confirm end-to-end delivery before using it for real audiences.
