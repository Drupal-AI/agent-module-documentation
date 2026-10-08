# Configuration

The module needs to authenticate with the Engaging Networks REST API before it
can do anything useful.

## Open the REST API settings

1. Log in as a user with permission to administer the module's settings.
2. Go to **Configuration → Engaging Networks → REST API**, or navigate directly
   to `/admin/config/engaging-networks/settings/rest-api`.

## Set the API credentials

On this form you configure the **REST API authentication** for your Engaging
Networks account. The API access credentials are stored through the **Key**
module, so the recommended flow is:

1. Create a **Key** for your Engaging Networks API token first, at
   **Configuration → System → Keys** (`/admin/config/system/keys`). Use a secure
   key provider — an environment/secret provider rather than storing the token in
   configuration.
2. Return to the REST API settings form and select that Key for authentication.
3. Save the form.

> **Secret handling.** Keep the API token out of version control. With DDEV,
> store it as an environment variable
> (`ddev dotenv set .ddev/.env --engaging-networks-token=<value>`, then
> `ddev restart`) and point a Key **env** provider at it, rather than pasting the
> token into configuration. Always ensure the connection to the API uses HTTPS.

## Verify it worked

After saving, exercise the client (for example via the code snippet in the
[main guide](../index.md#how-to-use-it)) and check **Reports → Recent log
messages** (`/admin/reports/dblog`) for any Engaging Networks API errors. A clean
call with no logged authentication errors means the credentials are set up
correctly.

> **Privacy reminder.** Once connected, the module sends supporter personal data
> to Engaging Networks. Disclose that egress in your privacy policy and handle the
> data in line with your obligations.
