# Configuration

Configuring Social Auth Facebook is a two-part job: first create an app on Meta's
developer platform, then paste its credentials into the module's settings form.

## Step 1 — Create a Facebook app

1. Go to [Meta for Developers](https://developers.facebook.com/) and create a new
   app, adding the **Facebook Login** product.
2. In the app's Facebook Login settings, add your site's OAuth callback URL to
   **Valid OAuth Redirect URIs**:

   ```
   https://your-site.example/user/login/facebook/callback
   ```

   This is the exact callback route the module registers; Facebook will refuse the
   login unless this URL is listed.
3. Note the app's **App ID** and **App secret** (under the app's Basic settings) —
   you will paste these into Drupal next.

## Step 2 — Open the settings form

1. Log in as a user with the **Administer social api authentication** permission.
2. Go to **Configuration → Social API settings → Social Auth → Facebook**, or
   navigate directly to `/admin/config/social-api/social-auth/facebook`.

## The fields

- **App ID** (`client_id`) — the Facebook App ID from your Meta app. Required.
- **App secret** (`client_secret`) — the Facebook App secret. Required, and
  **sensitive** — treat it like a password (see the secrets note below).
- **Graph API version** (`graph_version`) — the Facebook Graph API version to call,
  for example `17.0`. Enter it **without** the leading `v` (the form strips a
  leading `v` for you, and validates the pattern like `2.8` or `17.0`). If this is
  empty the integration refuses to build the OAuth client, so it must be set.
- **Scopes** — any extra OAuth permission scopes to request from Facebook during
  authorization, beyond the defaults.
- **Endpoints** — the Graph API endpoints called to fetch the user's profile data.

Click **Save**. The Facebook button then appears in the Social Auth Login block and
at `/user/login/facebook`.

## Keeping the App secret out of version control

The App secret is a credential. If you export configuration to code, the exported
`social_auth_facebook.settings` would contain the secret in plain text — do not
commit that. The recommended pattern on this project is to keep the value in an
environment variable and override the config from `settings.php` at runtime, so the
secret never lands in exported config or Git. For example, store it with DDEV's
dotenv command and reference it:

```php
// settings.php
$config['social_auth_facebook.settings']['client_secret'] = getenv('FACEBOOK_APP_SECRET');
```

(Set the variable with `ddev dotenv set .ddev/.env --facebook-app-secret=<value>`
and `ddev restart`; never commit `.ddev/.env`.)

## Verify it worked

Log out (or use a private window), visit `/user/login/facebook` or the Social Auth
Login block, and click **Log in with Facebook**. You should be redirected to
Facebook, and after approving, returned and logged in (a new Drupal account is
created on first login). If you get a redirect-URI error from Facebook, re-check
that the callback URL in the Meta app exactly matches
`.../user/login/facebook/callback`.

## Reacting to Facebook logins with Rules (optional)

If the [Rules](https://www.drupal.org/project/rules) module is enabled, this module
exposes two events you can build reactions on:

- **User has logged in via Facebook login** (`social_auth_facebook.user_login`)
- **User has been created via Facebook login** (`social_auth_facebook.user_created`)

Both provide the affected user account as context.
