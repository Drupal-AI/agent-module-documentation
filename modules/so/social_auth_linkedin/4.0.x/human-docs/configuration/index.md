# Configuration

Social Auth LinkedIn is configured through Social Auth's generic **network
settings form** for the LinkedIn network. There's no separate config page of its
own.

## Where the settings form lives

Go to **Configuration → User authentication → LinkedIn**
(`/admin/config/social-api/social-auth/linkedin`). The form saves four values in
the `social_auth_linkedin.settings` config object:

- **Client ID** — your LinkedIn app's Client ID.
- **Client Secret** — your LinkedIn app's Client Secret.
- **Scopes** — extra OAuth scopes, **comma-separated**, appended to the defaults.
  (The default profile/email scopes are built in — see the note below.)
- **Endpoints** — extra API endpoints; a generic Social Auth field, usually left
  blank.

## Setup steps

1. In Drupal, open the LinkedIn settings form and copy the **Authorized redirect
   URL** — it ends in `/user/login/linkedin/callback`.
2. In the [LinkedIn Developer portal](https://developer.linkedin.com/), create an
   app (this requires an associated LinkedIn Company Page), then add the **"Sign
   In with LinkedIn"** product to it.
3. On the app's **Auth** tab, add the redirect URL you copied to the
   *Authorized redirect URLs* list.
4. Copy the app's **Client ID** and **Client Secret**.
5. Back in Drupal, paste them into the settings form and save.
6. Add the login button: place a **Social Auth Login** block at
   *Structure → Block layout*, or link to **`/user/login/linkedin`** directly.

## Keeping credentials out of exported config

Because these are ordinary Drupal config values, keep the real credentials out of
your exported configuration by overriding them per environment in `settings.php`
from environment variables:

```php
$config['social_auth_linkedin.settings']['client_id'] = getenv('LINKEDIN_CLIENT_ID');
$config['social_auth_linkedin.settings']['client_secret'] = getenv('LINKEDIN_CLIENT_SECRET');
```

You can also set the values directly with Drush (fine for the non-secret ID; keep
the secret in an environment variable where possible):

```bash
drush config-set social_auth_linkedin.settings client_id 'YOUR_CLIENT_ID' -y
drush config-set social_auth_linkedin.settings client_secret 'YOUR_CLIENT_SECRET' -y
```

## Important: legacy scopes vs OpenID Connect

The module requests LinkedIn's **legacy** "Sign In with LinkedIn" scopes
(`r_liteprofile` and `r_emailaddress`), which are hard-coded and merged with
anything you add in the **Scopes** field. LinkedIn now steers new apps toward
**"Sign In with LinkedIn using OpenID Connect"** (`openid`, `profile`, `email`).

If your LinkedIn app only has the OpenID Connect product, the legacy scopes will
be **rejected** and logins will fail. In that case you need a LinkedIn app that
has the classic "Sign In with LinkedIn" product, or a newer provider setup. This
is a compatibility gotcha with LinkedIn's platform, not a setting you can simply
toggle away in the module.

## Troubleshooting

Failed logins are logged to the `social_auth_linkedin` logger channel — check
**Reports → Recent log messages** (dblog) to see why a sign-in attempt didn't
complete.
