# Configuration

Configuring ORCID means registering an OAuth application with ORCID and giving Drupal
its **client ID** and **client secret**.

## 1. Register an ORCID OAuth application

In your ORCID account (developer tools), register an application to obtain:

- a **client ID**, and
- a **client secret**.

You will also configure the **redirect / callback URL** so ORCID returns users to
your site's callback (`/orcid/oauth`). Use an **HTTPS** URL for your site.

## 2. Store the client secret safely

The ORCID **client secret** is a credential — never hard‑code it or commit it to
version control.

If you are working in **DDEV**, save it as an environment variable:

```bash
ddev dotenv set .ddev/.env --orcid-client-secret=<value>
ddev restart
```

The flag `--orcid-client-secret` becomes the environment variable
`ORCID_CLIENT_SECRET` inside the web container. Keep `.ddev/.env` out of version
control.

Where the settings accept a **Key entity** for the secret, prefer that. Make sure the
Key module is installed (`ddev composer require drupal/key` and
`ddev drush en key -y`), confirm the variable is present in the container **without
printing its value**:

```bash
ddev exec 'test -n "$ORCID_CLIENT_SECRET"'   # exit status 0 means it is set
```

then create a Key that reads from the environment variable:

```bash
ddev drush key:save orcid_client_secret \
  --label='ORCID Client Secret' \
  --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"ORCID_CLIENT_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Where a Key entity does not apply, reference the environment variable directly (for
example via `getenv('ORCID_CLIENT_SECRET')` in `settings.php`) rather than storing the
secret in exported configuration.

## 3. Enter the credentials and review permissions

Enter the client ID (and the secret, or a reference to the stored secret) in the
module's ORCID settings, then review the module's permissions under **People →
Permissions** (`/admin/people/permissions`) to control who can use ORCID login and
account linking.
