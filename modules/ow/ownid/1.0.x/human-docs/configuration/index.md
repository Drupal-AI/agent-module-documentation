# Configuration

Configuring OwnID has two halves: creating a project in the OwnID console to get
your credentials, and entering those credentials into Drupal — safely, because
one of them is a secret.

## Step 1 — create your OwnID project

1. Sign up at the **OwnID console** (<https://console.ownid.com>).
2. Select the **Drupal** integration and complete the onboarding.
3. The console gives you two values:
   - an **App ID** — an identifier for your OwnID application, and
   - a **Shared Secret** — a confidential key used to secure the integration.

## Step 2 — store the Shared Secret as a secret (recommended)

The Shared Secret is a credential. Never hard‑code it in `settings.php` that is
committed, and keep it out of exported configuration and version control. On a
DDEV project the recommended pattern is to put the value in an environment
variable and load it from there:

```bash
ddev dotenv set .ddev/.env --ownid-shared-secret='<value-from-console>'
ddev restart
```

This makes the value available inside the web container as the environment
variable `OWNID_SHARED_SECRET` (and keeps `.ddev/.env` out of version control).
You can then reference it from `settings.php` via `getenv('OWNID_SHARED_SECRET')`
when overriding the module's config, so the real secret never lives in a
committed file. The App ID is not secret and can be entered directly.

## Step 3 — enter the credentials in Drupal

1. Log in as a user with the **Administer site configuration** permission.
2. Open the OwnID **settings form** — the quickest route is the **Configure** link
   next to OwnID on the **Extend** page (`/admin/modules`).
3. Paste in the **App ID** and the **Shared Secret** (or, if you are keeping the
   secret in an environment variable, override that config value in
   `settings.php` instead of pasting it here).
4. Save the form.

## Step 4 — confirm connectivity and the login flow

- Make sure outbound **HTTPS** to the OwnID service is allowed from your
  environment; the passwordless flow will not work if egress to OwnID is blocked.
- Test a login. Because this is authentication, treat the first successful login
  as a checkpoint: confirm that the account the user lands in is the one you
  expect (unambiguous email‑to‑account mapping) and that a Drupal session is only
  established after OwnID's verification succeeds.

> **Security reminder:** authentication modules are high‑stakes. Verify the
> token/verification flow in your own setup, keep the Shared Secret out of any
> committed file, and only exchange credentials over HTTPS before you rely on
> OwnID for real user logins.
