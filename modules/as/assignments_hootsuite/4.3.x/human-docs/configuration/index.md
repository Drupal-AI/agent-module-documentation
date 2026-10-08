# Configuration

To use this module you connect your site to Hootsuite with an OAuth2 app. That
means registering an app on the Hootsuite side, then entering its client
credentials into Drupal — kept as a secret, not committed to configuration.

## Register a Hootsuite app

In your Hootsuite developer account, create an app to obtain its **OAuth2 client
ID** and **client secret**, and set the **redirect/callback URL** to point back at
your site (the OAuth2 Client module handles the callback). Keep the client secret
somewhere safe — you will store it as an environment variable below rather than
typing it into a form that ends up in config.

## Open the settings

1. Log in as a user with the **Administer hootsuite api settings** permission.
   Grant it under **People → Permissions** (`/admin/people/permissions`) to
   trusted operators only.
2. Open the module's Hootsuite API settings from the administration area, and the
   OAuth2 Client configuration where the connection's credentials are held.

## Store the credentials securely

Never hard‑code the client secret into a config file or commit it to Git. Keep it
in an environment variable. With DDEV:

```bash
ddev dotenv set .ddev/.env --hootsuite-client-secret=<your-secret>
ddev restart
```

The flag `--hootsuite-client-secret` becomes the variable
`HOOTSUITE_CLIENT_SECRET` inside the web container. Do **not** commit
`.ddev/.env`. Confirm the variable is present without printing its value:

```bash
ddev exec 'test -n "$HOOTSUITE_CLIENT_SECRET"'   # exit status 0 means it is set
```

Then reference the environment variable from where the credential is configured —
for example via a **Key** entity using the `env` key provider (the recommended
pattern for OAuth secrets), or from `settings.php` with `getenv()` — instead of
pasting the raw secret into the settings form.

## Connect via OAuth2

With the client ID and secret in place, complete the OAuth2 authorization flow so
your site is authorised against your Hootsuite account. Once authorised,
assignment workflows can post to the social accounts Hootsuite manages.

## Verify and stay safe

- Run a test post from an assignment and confirm it appears through Hootsuite.
- Keep **Administer hootsuite api settings** restricted — anyone with it can
  change where and how your site posts to social media.
- If a secret is ever exposed, rotate the Hootsuite app credentials and update the
  environment variable.
