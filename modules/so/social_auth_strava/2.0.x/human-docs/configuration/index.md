# Configuration

## Register a Strava application

1. Create an API application in your Strava account settings.
2. Note its **Client ID** and **Client Secret**.
3. Set the application's **Authorization Callback Domain** to your site's domain so
   Strava will redirect back to `user/login/strava/callback`.

## Enter the credentials in Drupal

1. Log in as a user with the **Administer social api authentication** permission.
2. Go to **Configuration → Social API → Social Auth → Strava**
   (`/admin/config/social-api/social-auth/strava`).
3. Enter the Strava **client id** and **client secret**.
4. In the **scopes** field, enter the comma-separated Strava OAuth scopes you want
   to request. The default is `read_all`.
5. Click **Save configuration**.

Treat the client secret like a password — keep it in an environment variable /
site secret rather than in exported configuration where practical.

## Show the login button

Go to **Structure → Block Layout** and place a **Social Auth login block**
somewhere on the site (if you have not already). That block renders the **Strava**
button. You can alternatively place or theme your own link pointing to
`user/login/strava`.

## What happens on login

When a visitor clicks **Strava**, they are redirected to Strava's consent screen.
On return, the module exchanges the authorization code for an access token, reads
their athlete profile, and passes name, athlete id, token and avatar to Social
Auth. Because Strava no longer exposes an email address, matching is done on the
**Strava athlete id**, not email. On a first login the athlete's Strava avatar can
become their Drupal user picture. The access token is kept in the session so that
downstream code (for example an event subscriber) can make further Strava API
calls on the user's behalf.
