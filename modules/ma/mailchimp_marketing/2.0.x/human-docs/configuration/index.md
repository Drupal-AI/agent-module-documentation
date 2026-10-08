# Configuration

Configuring Mailchimp marketing means connecting to your Mailchimp account with an
API key, then working with audiences, taxonomy sync, and campaigns. The privacy
side — subscriber data leaving your site — is just as important as the connection
itself.

## Open the settings page

1. Log in as a user who can administer the module.
2. Go to the settings page provided by the `mailchimp_marketing.admin` route,
   under **Configuration**.

## Connect to Mailchimp with your API key

Enter your Mailchimp **API key** so the module can authenticate to your account.
Once connected, it can read your audiences and sync data to them.

### Store the API key as a secret

The API key is a credential — keep it out of plaintext configuration and version
control:

1. Save the value into an environment variable with DDEV's dotenv command:

   ```bash
   ddev dotenv set .ddev/.env --mailchimp-api-key=YOUR_KEY_HERE
   ddev restart
   ```

   (Keep `.ddev/.env` out of version control.)

2. Store it as a **Key** entity using the [Key](https://www.drupal.org/project/key)
   module's environment provider, and reference that key rather than pasting the
   value into a config field — this keeps the secret out of exported configuration.

If the version you're running only offers a plain settings field for the key, at
minimum exclude its settings from configuration export so the credential doesn't
travel between environments.

## Audiences, taxonomy, and campaigns

With the connection in place, you can:

- **Sync groups and taxonomy terms** from Drupal to Mailchimp, keeping your
  Mailchimp structure aligned with your site's vocabularies.
- **Create RSS campaigns based on taxonomy terms**, so new content in a category
  can feed a recurring Mailchimp newsletter.
- Manage the **audiences** subscribers are synced into.

If you enabled the **Subscribe (content type)** submodule, you can also tie
subscription to a content type.

## Privacy and consent — subscriber data goes to Mailchimp

Syncing subscribers means sending **personal data** (emails, names) to Mailchimp, a
third-party service that then stores it. Before relying on the module:

- **Obtain consent** before adding people as subscribers — don't add contacts who
  haven't opted in.
- **Disclose** the data sharing in your privacy policy and make sure it's
  compatible with regulations such as GDPR.
- **Confirm the scope** of what's synced matches what you intend to share.

## Permissions

The module provides its own permissions. Grant them only to trusted
administrators at **People → Permissions** (`/admin/people/permissions`).
