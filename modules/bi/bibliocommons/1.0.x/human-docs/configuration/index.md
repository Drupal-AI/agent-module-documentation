# Configuration

Bibliocommons Book List talks to the BiblioCommons API, which is authenticated with
an API key. The key is a credential, so it is handled through the **Key** module and
kept out of plain, committed configuration.

## 1. Store the BiblioCommons API key as a secret

Keep the key in an environment variable rather than typing it into a settings form
or committing it to configuration.

With DDEV, save it into the project's dotenv file and restart so the container picks
it up:

```bash
ddev dotenv set .ddev/.env --bibliocommons-api-key=YOUR_KEY_HERE
ddev restart
```

The flag `--bibliocommons-api-key` becomes the environment variable
`BIBLIOCOMMONS_API_KEY` inside the web container. Never commit `.ddev/.env` — keep it
out of version control.

You can confirm the variable is present **without printing its value**:

```bash
ddev exec 'test -n "$BIBLIOCOMMONS_API_KEY" && echo set || echo missing'
```

## 2. Create a Key entity backed by that environment variable

Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and add a key
that uses the **Environment** provider, pointing at `BIBLIOCOMMONS_API_KEY`. This way
Drupal reads the secret from the environment at runtime and never stores it in the
database or exported config.

The equivalent Drush command:

```bash
drush key:save bibliocommons_api_key \
  --label='BiblioCommons API Key' \
  --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"BIBLIOCOMMONS_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

## 3. Point the module at the key and your catalog

In the module's configuration, select the Key you just created as the BiblioCommons
API credential, and provide the catalog/library details for the lists you want to
display. The module then fetches the book lists from BiblioCommons and renders them
through UI Patterns.

## 4. Grant the administration permission

Under **People → Permissions** (`/admin/people/permissions`), grant
`administer bibliocommons` only to the roles that should manage this integration.

## Security notes

- The API key is a secret. Store it in the environment and reference it through a Key
  entity, as above — do not paste it into plain configuration that gets exported or
  committed.
- Calls to BiblioCommons are outbound to an external service over the network; make
  sure they run over HTTPS.
