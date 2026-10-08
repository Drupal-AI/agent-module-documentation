# Social Auth Apple — configuration

## Settings form

Route `social_auth_apple.settings_form` → `/admin/config/social-api/social-auth/apple`
(permission `administer social api authentication`, from Social Auth). Form
`Form\AppleAuthSettingsForm extends SocialAuthSettingsForm`.

Fields (on top of the base Social Auth network fields):

| Form field | Config key (`social_auth_apple.settings`) | Notes |
|---|---|---|
| Client ID | `client_id` | Apple **Service ID** (not an app id). Description overridden to say so. |
| Team ID | `team_id` | 10-char Apple developer Team ID. Required. |
| Key file ID | `key_file_id` | The Key ID (prefix of the downloaded key filename). Required. |
| Key file path | `key_file_path` | Path to the `.p8` private key relative to the site root, e.g. `keys/AB12CD34.p8`. Required. |
| Authorized redirect URL | (display only) | Copy into Apple's *Authorized redirect URIs*. |
| Client secret | `client_secret` | **Hidden** (`#access = FALSE`) and cleared on save — Apple uses a JWT minted from the key file instead. |
| Scopes / endpoints | `scopes`, `endpoints` | inherited advanced fields. |

`validateForm()` requires the key file to **exist** and to contain both
`-----BEGIN PRIVATE KEY-----` and `-----END PRIVATE KEY-----`; otherwise the form errors.
`submitForm()` saves `team_id`/`key_file_id`/`key_file_path` and `clear('client_secret')`.

## Config object `social_auth_apple.settings` (schema present)

Keys: `client_id`, `team_id`, `key_file_id`, `key_file_path`, `redirect_uri`, `scopes`, `endpoints`.

The Network plugin's `getExtraSdkSettings()` feeds `teamId`, `keyFileId`, `keyFilePath` to the
`\League\OAuth2\Client\Provider\Apple` provider; `validateConfig()` requires client id, team id,
key file id, and key file path to be set (logs an error and returns FALSE otherwise).

## Routes

| Route | Path | Access |
|---|---|---|
| `social_auth_apple.settings_form` | `/admin/config/social-api/social-auth/apple` | `administer social api authentication` |
| `social_auth_apple.callback` | `/user/login/apple/callback` (GET+POST, `no_cache`) | `_access: 'TRUE'` (anonymous can log in; authenticated can associate) |
| login redirect | `/user/login/apple` | provided by Social Auth (`social_auth.network.redirect`) |

## Apple Developer setup (summary)

1. Create a **Service ID** (used as Client ID) and enable Sign in with Apple.
2. Register the site's callback as an Authorized redirect URI (value shown on the settings form).
3. Create a **Key** with Sign in with Apple, download the `.p8`, note its Key ID (→ Key file ID) and your Team ID.
4. Place the `.p8` on the server and set its path in the form.

## `.p8` key file deployment

Store the `.p8` outside the webroot or in a non-web-served path where possible and reference it by
`key_file_path`; it is the credential from which the client-secret JWT is minted. (This is an
operator deployment choice — the module only reads the path from config.)
