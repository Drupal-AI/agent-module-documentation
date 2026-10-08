# Social Auth Facebook settings

## Where

- Config object: **`social_auth_facebook.settings`** (schema-defined; **no `config/install`**, so
  it is absent until first saved).
- Form route: `social_auth_facebook.settings_form` → `/admin/config/social-api/social-auth/facebook`
  (a "Facebook" tab under Social Auth's integrations page).
- Permission: **`administer social api authentication`** (provided by Social Auth).

## Keys (all strings)

```yaml
client_id: '...'       # Facebook App ID (labeled "App ID" in the form)
client_secret: '...'   # Facebook App secret ("App secret")
graph_version: '17.0'  # Facebook Graph API version, WITHOUT the leading "v"
scopes: '...'          # extra OAuth permission scopes to request
endpoints: '...'       # Graph API endpoints to call for profile data
```

`graph_version` validation: the form strips a leading `v` and requires the pattern
`^([2-9]|[1-9][0-9])\.[0-9]{1,2}$` (e.g. `2.8`, `17.0`). If it is empty, the Network plugin
logs an error and refuses to build the OAuth client.

Legacy upgrade: in 4.x the old `app_id` / `app_secret` keys were renamed to
`client_id` / `client_secret` (update hook `social_auth_facebook_update_8202`), and `api_calls`
became `endpoints` (`_update_8201`).

## Read / write via drush

```bash
drush cget social_auth_facebook.settings
drush cset social_auth_facebook.settings graph_version 17.0 -y
drush cset social_auth_facebook.settings client_id  '<APP_ID>' -y
drush cset social_auth_facebook.settings client_secret '<APP_SECRET>' -y
```

## URLs the module adds

- Login: `/user/login/facebook`
- OAuth callback (the "Valid OAuth Redirect URI" to register in the Meta app):
  `/user/login/facebook/callback`

## Setup outline (needs an external Facebook app)

1. Create an app at Meta for Developers, add Facebook Login.
2. Copy the site callback URL (`.../user/login/facebook/callback`) into the app's Valid OAuth
   Redirect URIs.
3. Paste the App ID and App secret into the settings form, set the Graph API version, save.
4. The Facebook button then appears in the Social Auth Login block / at `/user/login/facebook`.
