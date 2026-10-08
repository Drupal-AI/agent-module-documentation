# Configuration

## Register a Vipps application

1. In the **Vipps Developer Portal** (the login details for which arrive by email a
   day or two after you apply for Vipps på Nett), create or open a **Vipps Login /
   merchant application**.
2. Note its **client id** and **client secret**.
3. Set the application's **redirect URI** to:

   ```
   https://<your-site>/user/login/vipps/callback
   ```

   It must use **HTTPS**. If Vipps shows an error when a visitor clicks to log in,
   the usual cause is a missing or mismatched redirect URL here.

## Enter the credentials in Drupal

1. Log in as a user with the **Administer social api authentication** permission.
2. Go to **Configuration → Social API → Social Auth → Vipps**
   (`/admin/config/social-api/social-auth/vipps`).
3. Enter the Vipps **client id** and **client secret**.
4. Optionally append extra **scopes**. The defaults requested are `openid`,
   `address`, `email`, `name` and `phoneNumber`.
5. Click **Save configuration**.

Treat the client secret like a password — keep it in an environment variable / site
secret rather than in exported configuration where practical.

## Show the login button

Go to **Structure → Block Layout** and place a **Social Auth login block**
somewhere on the site (if you have not already). That block renders the **Vipps**
button. You can alternatively place or theme your own link pointing to
`user/login/vipps`.

## What happens on login

When a visitor clicks **Vipps**, the module builds the Vipps authorization URL and
stores the OAuth2 `state` both in the session and (timestamped) in Drupal's state
store. The visitor authenticates in the Vipps app and is returned to the callback,
where the module re-validates the state (the base check plus its own hardened,
time-limited re-check), exchanges the code for a token, fetches the Vipps profile,
and — provided the email is verified — hands name, email and avatar to Social Auth
to log in, register or link the account. If Vipps returns an error, the visitor is
redirected back to the login page with the error message, and token-exchange
failures are logged to the `social_auth_vipps` channel.
