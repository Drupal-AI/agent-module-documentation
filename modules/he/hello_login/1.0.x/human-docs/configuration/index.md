# Configuration

Configuring Hello Login means registering your Drupal site as a relying party with
the Hellō identity provider, giving Drupal the resulting **client id** and **client
secret**, and doing so in a way that keeps the secret out of your codebase.

## 1. Register your site with Hellō

Sign in at [hello.dev](https://hello.dev) and register your site (the **Quickstart**
flow is designed to walk you through this in a few clicks). Registration gives you:

- A **client id** — a public identifier for your site.
- A **client secret** — a private credential that authenticates your site to Hellō.

You will also be asked for (or shown) your site's **redirect/callback URL** — the
address on your Drupal site that Hellō returns users to after they authenticate.
Register the exact URL your site uses so the login round‑trip completes.

## 2. Store the client secret securely

The client secret is a real credential: anyone who obtains it can impersonate your
site to Hellō. **Never hard‑code it in settings, configuration, or anything committed
to Git.** Store it in an environment variable instead.

With DDEV, save it into the project's dotenv file and restart so the container picks
it up:

```bash
ddev dotenv set .ddev/.env --hello-client-secret=<the-secret-from-hello>
ddev restart
```

The flag `--hello-client-secret` becomes the environment variable
`HELLO_CLIENT_SECRET` inside the web container. Keep `.ddev/.env` out of version
control.

Confirm the variable is present **without printing its value**:

```bash
ddev exec 'test -n "$HELLO_CLIENT_SECRET"' && echo "set"
```

## 3. Reference the secret from Drupal via the Key module

Where the login client supports a **Key** entity for its credential (the recommended
pattern for `externalauth`/OIDC providers), install and enable Key, then create a Key
backed by the environment variable so Drupal reads the secret at runtime rather than
storing it in configuration:

```bash
ddev composer require drupal/key
ddev drush en key -y
ddev drush key:save hello_client_secret \
  --label='Hellō Client Secret' \
  --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"HELLO_CLIENT_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Then, on the module's settings, select this Key as the source of the client secret.
If the module version you are using stores the secret directly in its own settings
rather than via a Key reference, still populate it from the environment variable
(for example with `getenv('HELLO_CLIENT_SECRET')`) rather than typing the literal
value into an exported configuration file.

## 4. Enter the client id and connect

On the module's settings form, enter your **client id** and point it at the client
secret (the Key you created, or the environment‑backed value). Save. The client id
is not secret and can live in ordinary configuration.

## 5. Grant login permissions

Hello Login provides its own permission(s) governing who may use Hellō login. Go to
**People → Permissions** (`/admin/people/permissions`), grant the relevant
permission to the roles that should be allowed to register/log in through Hellō, and
save.

## 6. Test the login round‑trip

Log out, start a login using the Hellō option, authenticate at Hellō with a test
account, and confirm you are returned to your site logged in as a matching Drupal
user. If the round‑trip fails, the usual culprits are a mismatched redirect/callback
URL registered at Hellō or a client secret that was not loaded into the container —
re‑check steps 1 and 2.

## Security recap

- The **client secret is a credential** — store it in an environment variable
  (DDEV dotenv) and reference it via a Key entity; never commit it.
- The **client id and redirect URL are not secret** and can live in configuration.
- Because your site trusts identities asserted by Hellō, keep the connection over
  **HTTPS** end to end so the OIDC exchange cannot be intercepted.
