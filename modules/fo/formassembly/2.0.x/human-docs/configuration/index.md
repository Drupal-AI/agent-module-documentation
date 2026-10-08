# Configuration

Configuring FormAssembly has three parts: keep your OAuth credentials out of
version control, authorise the site against FormAssembly, then create the form
entities you want to render. You need the **Administer FormAssembly form
entities** permission (a restricted‑access permission) throughout.

## Step 1 — Store your OAuth credentials safely

FormAssembly authenticates with OAuth, and the client ID/secret and the resulting
tokens are **secrets** — never hard‑code them or commit them to configuration.
Store the secret value in an environment variable and reference it from Drupal.

With DDEV, save the value into the project's dotenv file and restart so the web
container picks it up:

```bash
ddev dotenv set .ddev/.env --formassembly-oauth-secret=<value>
ddev restart
```

The flag `--formassembly-oauth-secret` becomes the environment variable
`FORMASSEMBLY_OAUTH_SECRET`. Keep `.ddev/.env` out of version control.

Optionally, install the **Key** module and create a Key entity backed by that
environment variable, so the credential is managed through Drupal's key system
rather than typed into a form:

```bash
ddev composer require drupal/key
ddev drush en key -y
```

Confirm the variable is present in the container **without printing its value**:

```bash
ddev exec 'test -n "$FORMASSEMBLY_OAUTH_SECRET"'   # exit status 0 means it is set
```

Then create the Key with the built‑in environment provider:

```bash
ddev drush key:save formassembly_oauth_secret \
  --label='FormAssembly OAuth Secret' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"FORMASSEMBLY_OAUTH_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

## Step 2 — Authorise the site against FormAssembly (OAuth)

The module uses a two‑step authorisation flow, both steps gated by **Administer
FormAssembly form entities**:

1. Go to **`/admin/structure/fa_form/settings/authorize`** (the *authorize*
   step). This sends the site off to FormAssembly to authorise the connection
   using the OAuth credentials from Step 1.
2. FormAssembly returns an authorization code, which the site captures at
   **`/admin/structure/fa_form/settings/code`** (the *code* step). This exchanges
   the code for the tokens the module will use for API calls.

Once this completes, the site holds a valid OAuth token and can fetch form markup
from the FormAssembly API. Because the token is a secret, keep it out of any
configuration you export.

> **Outbound access:** the site makes server‑side HTTPS calls to FormAssembly's
> API during authorisation and whenever it fetches or refreshes a form's markup.
> If your environment restricts outbound traffic, allow egress to the
> FormAssembly service host.

## Step 3 — Create and place form entities

With the site authorised, create an `fa_form` entity for each FormAssembly form
you want to use:

1. Go to **Structure → FormAssembly forms** (`/admin/structure/fa_form`) and add
   a form entity, identifying the remote FormAssembly form it represents. The
   module fetches and parses that form's markup so it renders natively in Drupal.
2. Decide how it appears:
   - **On its own path**, or
   - **Embedded in content** through an entity‑reference field that points at the
     form entity.
3. Configure the post‑submission behaviour — a **thank‑you message** or a
   **redirect** to another page. When embedded, the form is replaced in place by
   the thank‑you message.
4. If the **Token** module is enabled, set default field values using tokens to
   pass Drupal data into the form as pre‑filled parameters.

## Permissions

FormAssembly ships four permissions that separate the roles of working with form
entities — **administering** them (the restricted‑access permission that also
gates the OAuth flow), **editing**, **listing**, and **viewing**. Grant
administration only to trusted roles, and hand out the narrower permissions to
editors who merely need to place or view forms.
