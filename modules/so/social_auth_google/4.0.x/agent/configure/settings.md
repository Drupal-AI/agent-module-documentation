<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings — OAuth credentials & options

Form `\Drupal\social_auth_google\Form\GoogleAuthSettingsForm` (extends the Social Auth base
settings form), route `social_auth_google.settings_form` →
`/admin/config/social-api/social-auth/google` (shown as the "Google" tab under Social Auth
integrations; permission `administer social api authentication`).

**Config object: `social_auth_google.settings`** (schema type `config_object`).

| Key | Type | Meaning |
|---|---|---|
| `client_id` | string | Google OAuth **Client ID** (from the Google Cloud console). |
| `client_secret` | string | Google OAuth **Client Secret**. |
| `scopes` | string | Extra scopes, comma-separated (e.g. `https://www.googleapis.com/auth/youtube.readonly`). `openid`, `email`, `profile` are **always** requested. |
| `endpoints` | string | Extra Google API endpoints to request after login. |
| `restricted_domain` | string | Limit sign-in to one Google Workspace domain (empty = any Google account). |

## Google Cloud setup

1. Create an OAuth 2.0 Client ID (type "Web application") in the Google Cloud console.
2. Set the **Authorized redirect URI** to the site's Social Auth Google callback
   (`https://<your-site>/user/login/google/callback` — the exact path is provided by the base
   Social Auth module and shown on the settings form).
3. Set the Authorized JavaScript origin to your site's origin.
4. Paste the Client ID / Secret into the settings form and save.

## Set with drush

```bash
drush config:set social_auth_google.settings client_id     'xxxxx.apps.googleusercontent.com' -y
drush config:set social_auth_google.settings client_secret 'yyyyy' -y
drush config:set social_auth_google.settings restricted_domain 'example.com' -y   # optional
drush cr
```

Read back: `drush config:get social_auth_google.settings`. Without a valid client id/secret
the Google login button appears but the OAuth handshake fails. The actual login/callback
routes and account handling are provided by the base `social_auth` module.
