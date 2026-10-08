# Configuration

Configuring Decoupled Cookie Auth has **two parts**: a settings form in the admin
UI where you tell Drupal about your front end, and a one‑line change in your
`services.*.yml` file that the admin form cannot make for you. Both are needed for
cookies to be shared between the two sites.

## Part 1 — The settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **`/admin/config/decoupled_cookie_auth/configuration`**.

On this form you configure the **domain and paths of your front end** — where the
module should redirect users for login, password reset, and related flows. These
values are what the module uses when it rewrites the `[site:login-url]` token and
when it sends users from Drupal's reset journey over to your front end's
equivalent pages. Fill in the front‑end login page and the other front‑end paths
so those redirects land in the right place.

The form also exposes the **allow registration by email only**
(`allow_registration_only_email`) option. When enabled, a user can register
through the JSON registration endpoint with just an email address and password —
the module auto‑generates a unique username from the email's local part behind the
scenes. Turn this on if your front end's sign‑up form does not collect a username.

Click **Save configuration** when you are done. The stored settings live in the
`decoupled_cookie_auth.configuration` config object.

## Part 2 — Set the cookie domain in services.*.yml

For the browser to share Drupal's session cookie with your front end, Drupal must
issue the cookie for the **shared base domain**. This is a code/environment change,
not something the admin form can do. Edit the appropriate
`services.[your-environment].yml` file and set the cookie domain to your shared
base domain:

```yaml
# services.development.yml
parameters:
  session.storage.options:
    cookie_domain: '.myfrontend.com'
    cookie_domain_bc_mode: true
```

Replace `.myfrontend.com` with your own shared base domain (the leading dot lets
all subdomains share it). Clear caches after editing.

## How the pieces fit together

Once both parts are in place, the module's event subscribers take over the
relevant flows automatically — there are no further per‑flow toggles:

- **Auto‑login after registration** — when a user registers via the core JSON
  registration route while anonymous, with email verification off and an active
  account, they are logged straight in. (This mirrors core's own trust model: a
  user logging into the account they just created.)
- **Password‑reset journey** — after a valid one‑time‑login link, the user is
  redirected to your front end's password‑reset page with the `pass-reset-token`
  appended, so your front end can collect a new password and send the token back
  to Drupal.
- **Reset edge cases** — an already‑logged‑in user hitting a reset link is sent to
  your front‑end password‑change form with `already_logged_in=1`; a missing or
  blocked account is sent to your front‑end home page with `account_blocked=1`.
- **Login‑URL token** — the `[site:login-url]` token (used by default in welcome
  emails) is rewritten to your front‑end login page.

## A note on browser cookie rules

Browsers are generous about cookies across subdomains — different subdomains and
ports on the same domain count as the "same site" for cookies — but strict about
JavaScript's same‑origin rules, where any difference in protocol, port, or host is
"cross origin". Keep this in mind if calls that rely on the cookie work while
cross‑origin JavaScript calls do not. Some hosts (for example Netlify) support
proxying requests so the client reaches Drupal at the same domain; the module has
not been tested with such proxy setups.
