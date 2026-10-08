Social Auth LinkedIn lets users register and log in to a Drupal site with their LinkedIn account, adding a `/user/login/linkedin` route, a LinkedIn button in the Social Auth login block, and a settings form for the LinkedIn OAuth2 client ID and secret. It is a thin network plugin on top of the [Social Auth](https://www.drupal.org/project/social_auth) / Social API framework.

---

The module registers a Social Auth **Network plugin** (`LinkedInAuth`, `@Network(id = "social_auth_linkedin", short_name = "linkedin")`) that wires the `league/oauth2-linkedin` OAuth2 provider into Social Auth, and an **OAuth2 manager** (`LinkedInAuthManager`, extending `social_auth`'s `OAuth2Manager`) that drives the LinkedIn calls. The heavy lifting — the redirect and callback controllers, CSRF/state handling, user matching and account creation, the login block — all lives in the shared `social_auth`/`social_api` modules; this module only supplies LinkedIn specifics. `getAuthorizationUrl()` requests the scopes `r_liteprofile` and `r_emailaddress` (plus any extra comma-separated scopes from config), `authenticate()` exchanges the `code` query parameter for an access token, and `getUserInfo()` builds a `SocialAuthUser` from the LinkedIn resource owner (name, id, email, avatar). Configuration is a single `social_auth_linkedin.settings` config object with `client_id`, `client_secret`, `scopes`, and `endpoints`; it is edited through Social Auth's generic network settings form (route `social_auth.network.settings_form`, network `linkedin`) reached from *Configuration » User authentication » LinkedIn*. Set up a LinkedIn app, add the "Sign In with LinkedIn" product, register the `/user/login/linkedin/callback` redirect URL, then paste the client ID/secret into the form. Note the `r_liteprofile`/`r_emailaddress` scopes are LinkedIn's **legacy** OAuth scopes; newer LinkedIn apps use "Sign In with LinkedIn using OpenID Connect" (openid/profile/email), which may require adjusting scopes/endpoints or a newer provider library.

---

- Let visitors register a new Drupal account using their LinkedIn profile.
- Let existing users log in with LinkedIn instead of a username/password.
- Add a "Log in with LinkedIn" button via the Social Auth login block.
- Link a LinkedIn identity to an already-authenticated Drupal user account.
- Match returning users by LinkedIn user id or email and log them straight in.
- Pull the user's name, email, and avatar from LinkedIn at first login.
- Place a custom LinkedIn login link anywhere by pointing it at `/user/login/linkedin`.
- Configure the LinkedIn OAuth2 client ID and secret from the network settings form.
- Request additional LinkedIn scopes beyond the default profile/email set.
- Provide LinkedIn SSO for a professional/B2B community or intranet site.
- Reduce signup friction on membership sites by offering LinkedIn login.
- Reuse the Social Auth framework's user-mapping and data-token handling for LinkedIn.
- Offer LinkedIn alongside Google/Facebook/GitHub via sibling Social Auth network modules.
- Copy the LinkedIn callback URL from the settings form to register it in the LinkedIn app.
- Restrict or theme the LinkedIn login entry point through block visibility and templates.
- Override the client id/secret per environment via `settings.php` config overrides.
- Diagnose failed logins through the `social_auth_linkedin` logger channel (dblog).
