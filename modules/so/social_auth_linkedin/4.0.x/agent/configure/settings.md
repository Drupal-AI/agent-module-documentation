# Configure Social Auth LinkedIn

## Config object

Single config object `social_auth_linkedin.settings` (schema `config/schema/social_auth_linkedin.schema.yml`):

| Key | Type | Meaning |
|---|---|---|
| `client_id` | string | LinkedIn app Client ID. |
| `client_secret` | string | LinkedIn app Client Secret. |
| `scopes` | string | Extra OAuth scopes, **comma-separated**, appended to the defaults. |
| `endpoints` | string | Extra API endpoints (Social Auth generic field; usually blank). |

The default requested scopes (`r_liteprofile`, `r_emailaddress`) are hard-coded in
`LinkedInAuthManager::getAuthorizationUrl()`; the `scopes` config value is merged on top.

## Where the settings form lives

This module ships **no routing.yml**. The editable form is Social Auth's generic network settings
form, reached via the local task in `social_auth_linkedin.links.task.yml`:

- Route: `social_auth.network.settings_form`, `route_parameters: { network: linkedin }`
- Path: `admin/config/social-api/social-auth/linkedin`
  (*Configuration » User authentication » LinkedIn*)

(`info.yml` declares `configure: social_auth_linkedin.settings_form`, a legacy route name; use the
task/path above.)

## Setup steps

1. In Drupal, open the LinkedIn settings form and copy the **Authorized redirect URL**
   (ends in `/user/login/linkedin/callback`).
2. In [LinkedIn Developers](https://developer.linkedin.com/): create an app (a LinkedIn Company
   Page is required), add the **"Sign In with LinkedIn"** product.
3. Under **Auth**, add the copied redirect URL to *Authorized redirect URLs*.
4. Copy the app's **Client ID** and **Client Secret**.
5. Back in Drupal, paste them into the form and save.
6. Place a **Social Auth Login** block (Structure » Block Layout) so the LinkedIn button appears,
   or link to `/user/login/linkedin` directly.

## Set config with Drush (example)

```bash
drush config-set social_auth_linkedin.settings client_id 'YOUR_CLIENT_ID' -y
drush config-set social_auth_linkedin.settings client_secret 'YOUR_CLIENT_SECRET' -y
```

Because these are ordinary Drupal config, you can keep the real credentials out of the exported
config by overriding them per environment in `settings.php`:

```php
$config['social_auth_linkedin.settings']['client_id'] = getenv('LINKEDIN_CLIENT_ID');
$config['social_auth_linkedin.settings']['client_secret'] = getenv('LINKEDIN_CLIENT_SECRET');
```

## Scopes: legacy vs OpenID Connect (important)

`getAuthorizationUrl()` requests `r_liteprofile` and `r_emailaddress` — LinkedIn's **legacy**
"Sign In with LinkedIn" scopes. LinkedIn now steers new apps to **"Sign In with LinkedIn using
OpenID Connect"** (`openid`, `profile`, `email`). If your LinkedIn app only has the OIDC product,
the legacy scopes will be rejected; you may need a LinkedIn app with the classic product, or a
newer provider setup. This is a compatibility gotcha, not a module setting you can toggle away.
