# Configuration

Connecting Drupal to Teamleader is a matter of registering an app in Teamleader and
handing its credentials to the module.

## Connect to the Teamleader API

1. In your **Teamleader** account, create (or open) an integration/app so you have
   an OAuth2 **client ID** and **client secret**. Note the redirect/callback URL
   the module expects, if the connection screen asks for one.
2. In Drupal, log in as a user with permission to administer the integration and
   go to **Configuration → Web services → Teamleader**
   (`/admin/config/services/teamleader`).
3. Enter your Teamleader app **client ID** and **client secret**, then follow the
   on‑screen instructions to authorise the connection. Teamleader uses OAuth2, so
   completing the connection typically involves being redirected to Teamleader to
   approve access and then back to Drupal.

Once authorised, the module holds a token that lets it call the Teamleader API on
your behalf.

## Store the credentials safely

The client ID, client secret and the resulting tokens are **secrets**:

- Keep them out of version control. Prefer environment variables, and use the
  **Key** module to reference the client ID and secret as managed keys rather than
  storing them as plain configuration.
- Always connect over **HTTPS**.

## Understand the data you are sending

The integration **sends contact and customer information — personal data — to
Teamleader**, a third‑party service outside your site. Treat that as a
data‑egress and privacy decision: only send what you need, and make sure it is
covered by your privacy policy and any consent you rely on. The
`teamleader_contact` submodule, for example, forwards Contact form submissions
(which contain names, email addresses and message text) straight into your CRM.

## Verify it worked

After connecting, use the module's functionality (or the `teamleader_contact`
submodule) to push a test record — for example submit the Drupal Contact form —
and confirm the corresponding contact appears in your Teamleader account.
