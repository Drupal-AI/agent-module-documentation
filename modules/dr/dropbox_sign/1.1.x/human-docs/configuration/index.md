# Configuration

All of Dropbox Sign's settings live on one form. This is where you connect the
module to your Dropbox Sign account and set a couple of behavior options.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Dropbox Sign API**, or navigate directly to
   `/admin/config/system/dropbox-sign`.

## Settings, field by field

- **Dropbox Sign API Key** — the API key associated with your Dropbox Sign
  account. This is the credential that authenticates every request the module
  makes on your behalf. The module stores it **encrypted** (via the Encryption
  module) and decrypts it only when it's needed. Create a key from your Dropbox
  Sign account if you don't have one yet.
- **Dropbox Sign Client ID** — the client ID assigned to the client you create in
  Dropbox Sign for the domain you're using. This is required for embedded signing
  flows.
- **CC email addresses** — a comma‑separated list of addresses that will be copied
  on *every* signature request. Handy if you want a shared inbox or an archive
  address to receive a copy of each completed request without adding it to every
  request by hand.
- **Test mode** — when enabled, every request sent to Dropbox Sign is flagged as a
  **test** request (not legally binding, not counted against your plan). Turn this
  on while you're setting things up and verifying the integration, and turn it off
  for production signing.

Click **Save configuration** when you're done.

## Handling the API key securely

The API key lets anyone act on your Dropbox Sign account, so protect it. You
enter it on the settings form, and the module stores it **encrypted** through the
**Encryption** module rather than as plain text — so set up Encryption's
encryption profile and key first (that is a dependency of this module). Keep the
encryption key itself out of version control, and keep exported configuration out
of any location you would not want the (encrypted) value to travel to.

The module reads the key only from this encrypted configuration; it does not read
it from an environment variable or a Key entity.

## Security notes

- **External service handling sensitive data.** Documents sent for signature and
  the signer information involved are sensitive and are processed by Dropbox Sign
  under their terms. Only send what you need to, and disclose the use of Dropbox
  Sign where appropriate.
- **Always use HTTPS** for the connection to the Dropbox Sign API.
- **The callback is verified.** Dropbox Sign posts signature events to the public
  callback route `/process-dropbox-sign-callback`. The module verifies each event
  with an HMAC (`hash_hmac('sha256', event_time.event_type, api_key)`) against the
  received `event_hash` and rejects mismatches and replays — so you can safely
  register that URL in your Dropbox Sign account. Register it there so status
  updates flow back to your site.
