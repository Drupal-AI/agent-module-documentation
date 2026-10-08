# Configuration

Google Auth SSO has no settings page of its own. You configure it entirely on
**Social Auth Google's** form, where this module adds a couple of extra pieces.

## Step 1 — Configure the Google OAuth client (Social Auth Google)

1. In the [Google Cloud console](https://console.cloud.google.com/), create an
   OAuth 2.0 client for your site (this is the normal Social Auth Google setup) and
   note the **client ID** and **client secret**.
2. In Drupal, go to **Configuration → Social API settings → User authentication →
   Google** (`/admin/config/social-api/social-auth/google`).
3. Enter the **client ID** and **client secret**.

### Keep the client secret safe

The OAuth client secret is sensitive. Prefer supplying it through the environment
rather than committing it in exported configuration — for example, with DDEV:

```bash
ddev dotenv set .ddev/.env --google-oauth-secret=<value>
ddev restart
```

(The flag `--google-oauth-secret` becomes the variable `GOOGLE_OAUTH_SECRET`; keep
`.ddev/.env` out of version control.) The login flow and the directory lookups make
**outbound HTTPS** calls to Google, so your host must allow that egress.

## Step 2 — Add the Directory API scope

For role sync to work, Social Auth Google must request read access to your Google
Workspace directory. On the same settings form, under **Advanced settings →
Scopes for API call**, add:

```
https://www.googleapis.com/auth/admin.directory.user.readonly
```

This lets the module read each user's directory profile at login. It requires a
Google Workspace with **domain-wide delegation** set up for the credentials.

## Step 3 — Restrict who can start the login (optional)

Google Auth SSO adds a **Restricted IPs** field to the settings form. If you fill
it in with an allowlist of IP addresses/ranges, then the "sign in with Google"
route and the Google login block are only available to visitors whose client IP is
on the list — useful for locking SSO to office networks on an intranet site. Leave
it empty to allow login from anywhere.

> **Note on IP checks:** the allowlist is enforced against the client IP as the
> application sees it, which can be influenced by proxy headers. Treat it as a
> useful restriction, not an unbreakable security boundary, and make sure any
> reverse proxy in front of the site sets the client IP correctly.

## Step 4 — Set up the Workspace role schema

Roles are driven by a **custom schema** in Google Workspace. In the Google Admin
console, define a custom user schema named **Drupal** with a **Roles** field, and
populate each user's `customSchemas.Drupal.Roles` with the Drupal role machine
names they should have. On each login, the module reads that field and sets the
Drupal user's roles to match.

## Understand the trust and blast radius

This is the most important part to get right:

- **Your Google Workspace admin controls Drupal roles.** Whatever roles are listed
  in a user's `Drupal.Roles` schema become their Drupal roles — including, if
  listed, `administrator`. Restrict who can edit that schema in Workspace
  accordingly.
- **The sync replaces roles on every login.** A user's existing Drupal roles are
  removed and re-added from the Google data each time they log in. A user whose
  Google profile lists **no** Drupal roles will end up with **no** roles.
- This is by design, but high-impact. Test with a non-critical account first, and
  make sure you retain a local Drupal admin account (not dependent on SSO) so you
  cannot lock yourself out.

## Save and test

Save the Social Auth Google settings form, then test the login end-to-end with a
Workspace account that has a known `Drupal.Roles` value, and confirm the resulting
Drupal user gets exactly the roles you expect.
