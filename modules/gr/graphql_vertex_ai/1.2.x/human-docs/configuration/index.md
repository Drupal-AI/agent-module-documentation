# Configuration

Configuring GraphQL Vertex AI has three parts: get the Google Cloud credential
into Drupal *safely*, point the module's settings form at your Vertex AI data
store, and make sure the resulting GraphQL search can only be run by clients you
trust.

## 1. Store the service-account credential with Key (do not paste it into a form)

The credential is a Google Cloud **service-account authentication file** — a
secret. Never hard-code it, never commit it, and never put it anywhere a client
could read it. Store it as an environment variable and expose it to Drupal
through a **Key** entity.

With DDEV, save the value into DDEV's dotenv file and restart so the container
picks it up:

```bash
ddev dotenv set .ddev/.env --vertex-ai-credentials="$(cat /path/to/service-account.json)"
ddev restart
```

The flag `--vertex-ai-credentials` becomes the environment variable
`VERTEX_AI_CREDENTIALS`. Keep `.ddev/.env` out of version control.

Confirm the variable is present in the container **without printing its value**:

```bash
ddev exec 'test -n "$VERTEX_AI_CREDENTIALS"'   # exit status 0 means it is set
```

Then create a Key that reads from that environment variable (enable the Key
module first if needed with `ddev drush en key -y`):

```bash
ddev drush key:save vertex_ai_credentials \
  --label='Vertex AI Credentials' \
  --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"VERTEX_AI_CREDENTIALS","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

You now have a Key entity the module can reference, with the secret itself living
only in the environment.

## 2. Fill in the module's settings

Open the module's settings form (it requires the **Administer GraphQL Vertex AI**
permission, `administer graphql_vertex_ai`, reached from the site's
Configuration area). There you connect Drupal to your Google Cloud project:

- **Credential Key** — select the Key you created above so the module
  authenticates to Vertex AI with your service account.
- **Data store / project details** — identify the Vertex AI data store and agent
  builder you configured in Google Cloud, so queries hit the right index.

Save the form. These values tell the module *where* to search and *how* to
authenticate; the credential itself stays in the Key, not in this configuration.

## 3. Lock down the endpoint

This is the part that protects your Google Cloud bill and your data. Every search
sent through the endpoint leaves your server for Vertex AI and costs money.

- Add the module's schema extension to your GraphQL schema, or use its data
  producers in your own field, so search is available where you intend.
- **Gate the GraphQL query/endpoint** so only your intended clients can run it —
  through GraphQL server permissions, OAuth, or another access mechanism. An
  open, anonymous Vertex AI search field is a direct cost- and abuse-vector.
- Keep the credential server-side. The module already uses it server-side and
  never exposes it to clients; don't undo that by echoing it into a response or
  a client-visible variable.
