# Configuration

Getting Sign in with Apple working is a two-sided job: you set things up in the
**Apple Developer portal**, and you enter the matching values on Drupal's settings
form. Nothing works until both sides agree.

## Open the settings form

1. Log in as a user with the **Administer social api authentication** permission.
2. Go to **Configuration → Social API Settings → User authentication → Apple**, or
   navigate directly to `/admin/config/social-api/social-auth/apple`. This is the
   `social_auth_apple.settings_form`.

## Set up Apple first

Before the form can be filled in, create these in the Apple Developer portal:

1. **A Service ID** with *Sign in with Apple* enabled. This Service ID is what you
   enter as the **Client ID** in Drupal (it is not an app/bundle ID).
2. **An Authorized redirect URI** — register your site's callback here. The exact
   value to paste is shown on the Drupal settings form as *Authorized redirect URL*
   (it points at `/user/login/apple/callback`).
3. **A Key** with *Sign in with Apple* enabled. Download the resulting **`.p8`**
   private key file (you can only download it once). Note its **Key ID** and your
   **Team ID**.

## The settings form, field by field

| Field | What to enter |
|---|---|
| **Client ID** | Your Apple **Service ID** (not an app id). |
| **Team ID** | Your 10-character Apple Developer Team ID. Required. |
| **Key file ID** | The **Key ID** of the key you created — it is also the prefix of the downloaded `.p8` filename. Required. |
| **Key file path** | The path to the `.p8` file, relative to the site root, e.g. `keys/AB12CD34.p8`. Required. |
| **Authorized redirect URL** | Display only — copy this value into Apple's *Authorized redirect URIs*. |
| **Client secret** | **Hidden and cleared on save.** Apple does not use a static secret; the module mints a JWT from your key file instead. |
| **Scopes / endpoints** | Advanced fields inherited from Social Auth. Apple requests `name` and `email` by default; add comma-separated extra scopes here if you need them. |

When you save, the form **validates the key file**: the file must exist at the path
you gave and must contain a PEM private key (the
`-----BEGIN PRIVATE KEY-----` … `-----END PRIVATE KEY-----` markers). If it can't
find a valid key there, it refuses to save and tells you why.

## Where to put the `.p8` key file — and keep it safe

The `.p8` file is the credential the whole flow hangs on: it is what the module
uses to mint Apple's client-secret JWT. Treat it accordingly.

- **Store it outside the webroot** (or somewhere your web server will not serve
  directly) and point `Key file path` at it. Do not drop it in a publicly reachable
  files directory.
- **Keep it out of version control.** Don't commit the `.p8` to your repository.
- **Rotating the key?** Create a new key in Apple, download the new `.p8`, upload it,
  and update the Key file ID and Key file path on this form.

## Save and test

After saving, the **Apple button** appears in the Social Auth Login block. Place
that block where you want it (for example on the login page), then test the round
trip: click the Apple button, authorise on Apple, and confirm you land back on your
site logged in.

> **A note on how the callback works.** When you request the name/email scopes,
> Apple sends its response as a POST, whereas Social Auth expects a GET. The module
> handles this automatically — it bounces Apple's POST back to the same callback URL
> as a GET — so you don't need to configure anything for it. CSRF protection (the
> OAuth2 *state* check) is handled by Social Auth and is left fully intact.

## Where user creation and login behaviour is configured

How Apple users are matched to existing accounts, whether new accounts are created,
and where people land after login are all controlled by **Social Auth's** own
settings, not by this module. Configure those under the main Social Auth
configuration.
