# Configuration

Setting this module up is a back-and-forth between Drupal and the X Developer
Portal: Drupal shows you a callback URL to register with X, and X gives you an API
key and secret to paste back into Drupal.

## 1. Copy the callback URL from Drupal

1. Log in as a user with the **Administer social api authentication** permission.
2. Go to **Configuration → Social API → Social Auth → Twitter**
   (`/admin/config/social-api/social-auth/twitter`).
3. Copy the **Callback URL** shown (disabled) on the form — it ends in
   `/user/login/twitter/callback`.

## 2. Create and configure the X app

1. In the **X Developer Portal**, create an app with **OAuth enabled**.
2. Paste the Drupal callback URL into the app's allowed callback / redirect URLs.
3. If you want the user's email address, enable **"Request email from users"** in
   the app.
4. Copy the app's **API Key** and **API Key Secret**.

## 3. Enter the credentials in Drupal

Back on the **Twitter** settings form:

| Field | What to enter |
|---|---|
| **Client ID** | The X app's **API Key** |
| **Client secret** | The X app's **API Key Secret** |
| **Scopes** | Optional extra OAuth scopes, added to the defaults |
| **Endpoints** | Optional extra API endpoints to call on first authentication |

The default scopes requested are `tweet.read`, `users.read`, `users.email` and
`offline.access` (the last yields a refresh token). Click **Save configuration**.

Treat the Client secret like a password — keep it in an environment variable / site
secret rather than in exported configuration where practical.

## 4. Show the login button

Go to **Structure → Block Layout** and place a **Social Auth login block**
somewhere on the site (if you have not already). That block renders the **Twitter/X**
button. You can alternatively place or theme your own link pointing to
`user/login/twitter`.

## What happens on login

When a visitor clicks the button, the module builds the authorize URL, generates a
PKCE code verifier (stored in the session), and redirects to X. On return, Social
Auth's callback exchanges the code plus the stored verifier for an access token,
reads the user's id, name, email and avatar, and logs them in — matching an
existing account or creating one per your Social Auth settings. Auth errors are
recorded to the `social_auth_twitter` log channel, a good first place to look when
debugging.
