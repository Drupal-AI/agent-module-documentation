# Configuration

OData Client is configured by creating one or more **OData server** configuration
entities. Each one records where a server lives, which collection to use by
default, and how to authenticate. Your code then refers to a server by its name.

## Create a server configuration

1. Log in as an administrator.
2. Go to **Structure → OData server** (`/admin/structure/odata_server`).
3. Click to **add a new server configuration** and fill in:
   - A **name / machine name** (for example `default`) — this is how your code will
     refer to the server.
   - The **service root URL** — the OData endpoint you're connecting to.
   - The **default collection**, if you want one (you can switch collections at
     runtime with `setCollection()`).
   - The **authentication** details the server requires. For Azure‑protected
     endpoints (such as Microsoft Dynamics CRM), this uses the bundled Azure OAuth2
     library — supply the tenant, client id, and client secret as required.
4. Save the configuration.

## Store credentials securely

The OData endpoint's credentials — especially any **client secret** or password —
are sensitive. **Never hard‑code them or commit them.** Keep them in an environment
variable and reference them from configuration/`settings.php`:

1. With DDEV, store the secret in `.ddev/.env` (kept out of version control) and
   restart so it loads into the web container:

   ```bash
   ddev dotenv set .ddev/.env --odata-client-secret=<value>
   ddev restart
   ```

   The flag `--odata-client-secret` becomes `ODATA_CLIENT_SECRET` inside the
   container. Confirm it arrived without printing it:

   ```bash
   ddev exec 'test -n "$ODATA_CLIENT_SECRET"' && echo present
   ```

2. Read it via `getenv('ODATA_CLIENT_SECRET')`, or — where the workflow supports it
   — reference it through the [Key](https://www.drupal.org/project/key) module's
   environment provider so the secret is named rather than pasted into a form.
3. Make sure your outbound firewall/egress rules allow the site to reach the OData
   service root URL. Always use an **HTTPS** endpoint so credentials and data are
   never sent in the clear.

## Using it from code

Once a server named (say) `default` is configured, connect and work with it through
the module's services:

```php
// Direct operations.
$odata = \Drupal::service('odata_client.io');
$odata->connect('default');
$odata->setCollection('People');
$russell = $odata->find('russellwhyte');
$total   = $odata->count();

// Fluent query builder.
$query = \Drupal::service('odata_client.query');
$result = $query->connect('default')
  ->fields(['FirstName', 'LastName'])
  ->condition('FirstName', 'Teresa')
  ->orderBy('LastName', 'desc')
  ->range(0, 4)
  ->execute();
```

You can also create records with `$odata->post($data)`, where `$data` is an array
matching the collection's structure.
