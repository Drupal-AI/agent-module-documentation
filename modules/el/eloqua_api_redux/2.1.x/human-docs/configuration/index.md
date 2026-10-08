# Configuration

Configuring Eloqua API Redux means entering your Eloqua OAuth application
credentials and then completing the OAuth handshake so Drupal receives an access
token. From then on, other modules (such as Webform Eloqua) use the shared
connection.

## Before you start

In your Eloqua account, create/obtain an OAuth application and note its
**client id** and **client secret**. Configure its **redirect (callback) URL** to
point at this site's callback: `/eloqua_api_redux/callback` (for example
`https://your-site.example/eloqua_api_redux/callback`).

## Enter the credentials

1. Log in as a user with the **Administer Eloqua API settings** permission.
2. Go to **Configuration → Web services → Eloqua API Redux**
   (`/admin/config/services/eloqua_api_redux`).
3. Enter your Eloqua **client id**, **client secret**, and the other connection
   details the form asks for (such as your Eloqua company/site name).
4. Save the form.

## Complete the OAuth connection

After saving, use the form's connect/authorize action to start the OAuth flow.
You will be sent to Eloqua to authorise, and Eloqua returns you to
`/eloqua_api_redux/callback`, where the module exchanges the code for an access
token. Because the callback is gated by the same admin permission, the person
finishing the connection is the person who began it.

Once connected, the module can refresh the access token as needed, and dependent
modules can use the client.

## Handle the credential as personal data

The Eloqua credential grants access to **contact data**, which is personal data.
Treat it accordingly:

- **Keep it out of config exports.** Do not commit the configuration object that
  holds the secret to version control, and exclude it from configuration sync.
- **Prefer a Key entity** for the secret where the module supports it, so the
  value can live in an environment variable rather than in configuration. With
  DDEV you can store such a value out of the codebase with
  `ddev dotenv set .ddev/.env --eloqua-client-secret=<value>` followed by
  `ddev restart` (never commit `.ddev/.env`).
- **Restrict the permission.** Only trusted administrators should hold *Administer
  Eloqua API settings*.

## Verify

If you have a dependent module such as Webform Eloqua, run a test submission and
confirm it reaches Eloqua. Otherwise, confirm the settings form reports a
connected/authorised state after completing the OAuth flow.
