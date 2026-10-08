# Configuration

Mailchimp E-Commerce doesn't have a big settings screen of its own — the important
configuration is (1) connecting to Mailchimp through the base **Mailchimp** module,
and (2) handling customer data and consent responsibly. Once the connection is in
place, this module syncs Commerce carts and orders for you.

## Connect to Mailchimp

The API connection lives in the base **Mailchimp** module, not here. In that
module's settings you provide your Mailchimp **API key**, after which
Mailchimp E-Commerce can push order data to your account.

### Store the API key as a secret

Your Mailchimp API key is a credential — treat it like a password, and keep it out
of plaintext configuration and version control. The recommended pattern on this
project is:

1. Save the value into an environment variable with DDEV's dotenv command:

   ```bash
   ddev dotenv set .ddev/.env --mailchimp-api-key=YOUR_KEY_HERE
   ddev restart
   ```

   (Keep `.ddev/.env` out of version control.)

2. Store it as a **Key** entity using the [Key](https://www.drupal.org/project/key)
   module's environment provider, and point the Mailchimp module at that key
   rather than pasting the value into a config field. This keeps the secret out of
   exported configuration.

If the Mailchimp module version you're using only offers a plain settings field
for the key, at minimum exclude its settings from configuration export so the
credential doesn't travel between environments.

## Add subscription to checkout (optional)

To let shoppers opt into a Mailchimp audience while buying, add the **Mailchimp
Subscription field** (provided by the base Mailchimp module) to your checkout flow.
That gives customers an explicit choice to join, which is also the right place to
capture marketing consent — see below.

## Privacy and consent — this sends customer data to Mailchimp

This is the part to get right. Mailchimp E-Commerce forwards **personal and
commercial data** — customer identities and order details — to Mailchimp, a
third-party service. That means:

- **Capture consent** before turning a customer into a marketing contact. Don't
  silently add buyers to marketing audiences; use the subscription field so opting
  in is a deliberate choice.
- **Disclose the data sharing** in your privacy policy, and make sure it's
  compatible with the regulations you operate under (for example GDPR).
- **Confirm the scope** of what's sent matches what you intend to share — review
  what customer and order fields are being synced.

## Permissions

The module provides its own permissions. Grant them only to trusted store
administrators at **People → Permissions** (`/admin/people/permissions`).
