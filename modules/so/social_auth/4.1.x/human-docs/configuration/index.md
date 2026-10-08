# Configuration

Configuring Social Auth happens on two levels: the **per‑provider credentials** you
enter for each "Sign in with…" service, and the **site‑wide login policy** that
applies to all of them. Both are reached from the same place.

## The integrations page

Go to **Configuration → Social API settings → Social Auth**
(`/admin/config/social-api/social-auth`). This page lists every auth provider you
have installed and links to each one's settings form. You need the **Administer
social api authentication** permission to open it.

## Per‑provider credentials

Click a provider (or visit `/admin/config/social-api/social-auth/{provider}`) to open
its settings form. Here you enter the details from the OAuth application you
registered with that provider:

- **Client ID** *(required)* — the public identifier of your OAuth app.
- **Client secret** *(required)* — the app's secret key. Keep it out of version
  control.
- **Scopes** — any extra permission scopes to request, comma‑separated.
- **Endpoints** — extra provider API endpoints to call the first time a user
  authenticates, one `endpoint|name` per line (for example to fetch profile data).
- **Authorized redirect URL** — a read‑only value the form shows you. Copy it into
  the provider's developer console as the app's allowed callback/redirect URL, so
  the provider will accept the round‑trip back to your site.

Each provider stores its credentials in its own configuration object (for example
`social_auth_google.settings`), so different providers never overwrite each other.

## Site‑wide login policy

The same provider settings form also carries the shared Social Auth settings, which
apply to every provider. These control who may log in and where they land:

- **Post‑login path** *(default `/user`)* — where users are sent after a successful
  login. Must start with `/`, `#`, or `?`.
- **User allowed** — choose **Register** (new visitors can create an account *and*
  existing users can log in) or **Login only** (existing linked users can log in, but
  no new accounts are created).
- **Redirect to the user form** *(off by default)* — send newly created users
  straight to their Drupal account edit form so they can finish their profile.
- **Disable admin login** *(on by default)* — block social login for user 1, the main
  admin account. Leaving this on is a sensible security hardening; the admin should
  log in with a password.
- **Disabled roles** — pick roles for which social login is switched off.

You can also read or set these from the command line:

```bash
drush config:get social_auth.settings
drush config:set social_auth.settings post_login /user/me -y
drush config:set social_auth.settings user_allowed login -y
```

## Show the login buttons

Two things surface the "Sign in with…" links:

- **The Social Auth Login block.** Place the **Social Auth Login** block from
  **Structure → Block layout** in a visible region (for example near the login form).
  It renders one link per installed provider.
- **The user edit form.** Logged‑in users automatically get a **Social
  Authentications** table on their account edit page where they can link or unlink
  provider accounts.

## Managing linked identities

Every time someone logs in through a provider, the link between that provider account
and the Drupal user is stored as a **Social Auth profile**:

- A user manages their own linked providers at
  `/user/{uid}/social-auth/profiles` (they need update access to that account).
- Administrators with **Administer social auth profiles** can view and delete
  profiles site‑wide. When a Drupal user is deleted, their social auth profiles are
  removed automatically.

## A reminder about the external side

Everything above — the config keys, routes, login block, and profile entity — exists
as soon as the modules are enabled. But a real end‑to‑end login also requires (1) a
provider implementer module and (2) a working OAuth application on the provider's
side supplying the client ID and secret. Those are set up outside Drupal, in the
provider's developer console.
