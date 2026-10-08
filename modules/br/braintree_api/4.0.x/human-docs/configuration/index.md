# Configuration

Braintree API's settings form (under **Configuration**) is where you connect
Drupal to your Braintree account. You will set:

- **Environment** — sandbox (for testing) or production (for live payments).
- **Merchant ID** — your Braintree merchant account identifier.
- **Public key** — your Braintree public key.
- **Private key** — your Braintree private key. **This is a secret.**

## Handling the private key as a secret

The private key must never be committed to exported configuration or to code. The
module depends on the **Key** module precisely so the private key can be stored
as a Key entity rather than as plain config. The recommended workflow keeps the
secret in an environment variable and references it from a Key:

1. **Store the value in an environment variable.** With DDEV, save it into the
   project's dotenv file (which stays out of version control):

   ```bash
   ddev dotenv set .ddev/.env --braintree-private-key='<your-private-key>'
   ddev restart
   ```

   The flag `--braintree-private-key` becomes the variable
   `BRAINTREE_PRIVATE_KEY` inside the web container. Confirm it is present without
   printing it:

   ```bash
   ddev exec 'test -n "$BRAINTREE_PRIVATE_KEY"'   # exit status 0 means it is set
   ```

2. **Create a Key entity backed by that variable.** If the Key module's env
   provider is available:

   ```bash
   ddev drush key:save braintree_private_key \
     --label='Braintree Private Key' --key-type=authentication \
     --key-provider=env \
     --key-provider-settings='{"env_variable":"BRAINTREE_PRIVATE_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

3. **Select that Key** in the Braintree API settings form's private-key field, so
   the module reads the secret from the environment at runtime and never stores it
   in the database or in exported config.

Do the same for the public key and merchant ID if you prefer to keep them out of
config too, though the private key is the critical one.

## Sandbox first

Start in the **sandbox** environment with sandbox credentials, verify that
transactions and webhooks behave, and only switch the environment to production
once you are confident. Keep separate credentials (and separate Key entities) for
sandbox and production.

## Webhooks

Braintree signs its webhook notifications, and this module verifies that
signature before dispatching anything. In your Braintree account, set the webhook
destination URL to `/braintree/webhooks` on your site so notifications reach the
verified endpoint. No signature secret needs to be entered here — verification
uses your existing credentials through the SDK.
