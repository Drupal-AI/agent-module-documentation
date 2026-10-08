# Configuration

Configuration has two parts: first store your API credentials as a **Key** (so they
never live in plain config or version control), then tell the ROI Solutions module
to use that key on its REST API settings form.

## Open the settings form

1. Log in as a user with the **Administer ROI Solutions** (`administer roisolutions`)
   permission.
2. Go to **Configuration → ROI Solutions → REST API**, or navigate directly to
   `/admin/config/roisolutions/settings/rest-api`.

## Store the credentials securely first

The ROI Solutions REST API authenticates with a username and password. Rather than
typing secrets straight into a configuration form, this module uses the **Key**
module so the value comes from an environment variable that is never committed to
your repository.

If you are working in DDEV, the recommended flow is:

1. Save the secret into DDEV's environment file (the flag name becomes the variable
   name), then restart so the container picks it up:

   ```bash
   ddev dotenv set .ddev/.env --roisolutions-api-password=<value>
   ddev restart
   ```

   Keep `.ddev/.env` out of version control.

2. Confirm the variable is present in the container **without printing it**:

   ```bash
   ddev exec 'test -n "$ROISOLUTIONS_API_PASSWORD"'   # exit status 0 = it is set
   ```

3. Create a **Key** entity that reads from that environment variable at
   **Configuration → System → Keys** (`/admin/config/system/keys`), choosing the
   *Environment* key provider and pointing it at your variable.

## Point the module at your credentials

Back on the **REST API** settings form
(`/admin/config/roisolutions/settings/rest-api`), enter the API connection details
ROI Solutions gave you and select the **Key** you created above for the API
username/password. Save the form.

Because the sensitive value is resolved from the environment through the Key module,
the credential itself is never stored in Drupal's configuration and will not appear
in a `drush cex` export.

## Verify the connection

The simplest check is to exercise the client from code (see *How to use it* on the
[overview page](../index.md)) — for example fetching a known donor — and then watch
**Reports → Recent log messages** (`/admin/reports/dblog`) for any authentication or
connection errors. A clean call with no logged errors means the credentials and key
are wired up correctly.
