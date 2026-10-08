# Configuration

Setting Patreon up is a four‑part job: register an OAuth client on Patreon's side,
enter and safely store its credentials, authorise your site against your creator
account, and (if you want membership login) configure the Patreon User submodule.
This page walks through each, and flags the security points that matter.

## 1. Register a Patreon OAuth client

Before Drupal can talk to Patreon you need an OAuth application:

1. Go to <https://www.patreon.com/portal/registration/register-clients> and
   register a client.
2. Note the generated **Client ID** and **Client Secret**.
3. Add the module's callback URLs as **allowed redirect URIs** on the client:
   - `https://your-site.example/patreon/oauth` (admin authorisation)
   - `https://your-site.example/patreon_user/oauth` (only if using Patreon User)

## 2. Enter the credentials

1. Log in as a user with the **`administer patreon`** permission and go to
   **Configuration → Web services → Patreon → Settings**
   (`/admin/config/services/patreon/settings`).
2. Enter the **Client ID** and **Client Secret** from your Patreon client.
3. Save.

Treat `administer patreon` as **credential access**: anyone who holds it can read
and change these secrets and trigger the authorisation flow. Grant it only to
trusted administrators.

### Storing the client secret safely

The client secret is a sensitive credential and should not be committed to version
control. Keep it out of exported configuration. The recommended pattern on this
project is to hold the value in an environment variable rather than hard‑coding it:

```bash
ddev dotenv set .ddev/.env --patreon-client-secret=<value>
ddev restart
```

That makes the value available as `PATREON_CLIENT_SECRET` inside the container
(never commit `.ddev/.env`). Where the module or your settings can read from the
environment — directly via `getenv('PATREON_CLIENT_SECRET')` in `settings.php`, or
through a [Key](https://www.drupal.org/project/key) entity using the environment
provider — reference it that way so the secret never lands in the database export
or the repository. If you do enter the secret directly in the settings form,
ensure your configuration export does not carry it into git.

### Outbound network access (egress)

This module makes **outbound HTTPS calls to the Patreon API** to exchange the
OAuth code for tokens and to fetch account, patron, and campaign data. If your
environment restricts egress, allow the site to reach Patreon's API and OAuth
hosts, otherwise authorisation and data fetches will fail.

## 3. Authorise the site

With credentials saved, run the admin authorisation flow. This sends you to
Patreon to approve access and returns to the admin callback at `patreon/oauth`
(gated by `administer patreon`), which exchanges the returned `code` for tokens
server‑side, fetches your creator record, and stores your creator ID and campaigns.

Security note on this flow: the **admin callback validates the OAuth `state`
parameter** against the value stored in your session before trusting the return,
and bails out on a mismatch. That is the correct, CSRF‑resistant behaviour for the
authorisation step.

## 4. Configure patron login (Patreon User submodule)

If you enabled **Patreon User**, its settings control how patrons sign in:

- **Login method** (`patreon_user_login_method`) — choose between single sign‑on
  (the user is logged straight in) and a password‑reset mail path.
- **Registration mode** (`patreon_user_registration`) — control who may log in via
  Patreon: no login at all, patrons only, or all Patreon users. Use "patrons only"
  if Patreon login is meant purely for members.

Roles are assigned from the patron's pledge/tier data on login, which is what lets
you gate content by membership.

### Important security caveat on the patron‑login callback

Unlike the admin authorisation flow, the public patron‑login callback at
`/patreon_user/oauth` (provided by Patreon User) **does not validate the OAuth
`state` parameter**. It reads only the returned `code` and, for an anonymous
visitor, completes the login. This is a **login‑CSRF weakness**: an attacker can
craft a callback that completes the OAuth return for a victim. The callback does
guard with an "anonymous only" check and honours the login/registration mode
settings above, but the missing `state` check means you should:

- Enable Patreon User only if you actually need patron login.
- Prefer the most restrictive registration mode that meets your need (for example
  "patrons only").
- Keep the module updated and watch the project's issue queue for a fix to the
  callback.

## Save and test

After saving, test the whole loop end to end: authorise as the creator, confirm
your campaigns are pulled in, and — if using Patreon User — have a test patron log
in and confirm the expected role is assigned.
