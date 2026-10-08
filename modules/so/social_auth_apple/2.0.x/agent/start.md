# Social Auth Apple — agent index

"Sign in with Apple" for Drupal — a Social Auth network plugin (`apple`) over the
`patrickbussmann/oauth2-apple` League provider. Adds `/user/login/apple`, callback
`/user/login/apple/callback`, an Apple button in the Social Auth Login block, and a settings
form. Depends on `social_auth` (which supplies the login/callback plumbing, state validation,
and the `administer social api authentication` permission).

- **Settings form fields (Service/Client ID, Team ID, Key file ID, `.p8` key path), config keys, routes, Apple Developer setup** → [configure/settings.md](configure/settings.md)
- **Auth flow: the POST→GET callback quirk, the Network plugin, `AppleAuthManager` overrides, state/CSRF handling** → [api/flow.md](api/flow.md)

Key facts:
- `configure` → `social_auth_apple.settings_form` (`/admin/config/social-api/social-auth/apple`).
- Credentials = Service ID + Team ID + Key File ID + path to a `.p8` private key (NOT a static client secret; the `client_secret` field is hidden).
- Callback route access is `_access: 'TRUE'` (anonymous must reach it); OAuth2 `state` is validated by the inherited `OAuth2ControllerBase` (`social_auth`).
- No permissions, plugin types, or Drush of its own; provides a config schema.
