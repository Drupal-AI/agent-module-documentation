# Configuration

All of miniOrange 2FA's screens live under **Configuration → People → miniOrange
2FA** (`/admin/config/people/miniorange_2fa`). Because most methods use the
miniOrange cloud to generate and verify one-time codes, the very first step is to
register a miniOrange account.

## Step 1 — Register the miniOrange account

1. Log in as an administrator and go to the **Account & License** tab
   (`/admin/config/people/miniorange_2fa/customer_setup`). This is the module's
   main "configure" screen.
2. Register (or sign in to) a miniOrange (Xecurify) customer account from this
   form. On success the module stores your **customer id**, **API key**, and
   **token key** — these are used for every challenge/verify call to the
   miniOrange API. Don't hand-edit these values; let the registration populate
   them.
3. From here you can later deregister the account or disable 2FA for all users.

> Some methods and higher usage volumes (SMS/phone are metered) require a
> **paid/licensed** miniOrange plan. The **Licensing** tab shows upgrade options;
> it's informational and doesn't change enforcement.

## Step 2 — Set up the admin's own second factor

Before enforcing 2FA on everyone, configure it for the primary admin so you don't
lock yourself out. Use **Setup Two-Factor** / **Configure admin 2FA**
(`/admin/config/people/miniorange_2fa/setup_twofactor`) to pick and register the
admin account's authentication method.

## Step 3 — Turn on and shape the policy

The **Login Settings** tab
(`/admin/config/people/miniorange_2fa/login_settings`) is where the site-wide 2FA
policy lives (stored in the `miniorange_2fa.settings` config object). Key options:

- **Enable Two-Factor Authentication** — the **master switch**. 2FA is only
  enforced at login when this is on.
- **Allowed 2FA methods** — restrict which second-factor methods users may choose
  from. Available methods include TOTP authenticator apps, OTP over email / SMS /
  phone, push notifications, QR code, knowledge-based questions, hardware tokens,
  grid pattern, and WebAuthn (with the submodule).
- **Allow users to reconfigure their method** — let end users change their chosen
  method later.
- **Recovery codes** — enable one-time recovery codes so a user who loses their
  device can still get in.
- **Role-based 2FA** — enforce 2FA only for chosen roles.
- **Domain-based 2FA** — enforce 2FA only for users whose email is on chosen
  domains.
- **Trusted IPs** — skip 2FA for requests from trusted IP ranges; a separate
  **whitelist IPs** option is also available.
- **Passwordless login** — allow signing in with just the second factor (no
  password).
- **Login with email / phone** — let users log in by email address or phone
  number instead of username.
- **2FA on password reset** — also require the second factor during the
  password-reset link flow.
- **2FA for APIs** — gate Basic-Auth API/REST requests behind completed 2FA.
- **OTP flood control / attempt limits** — throttle and cap OTP attempts.
- **Remember device (risk-based auth)** — reduce repeat prompts on trusted
  devices.

Once the master switch is on and users have configured a method, the second-factor
step is inserted into the normal login form automatically.

## Step 4 — Manage individual users

The **User Management** tab
(`/admin/config/people/miniorange_2fa/user_management`) lets you reset, enable, or
disable 2FA for a specific user — for example to help someone who has lost their
device. These actions are protected and available only to trusted admins.

## Headless / API 2FA

If you run a decoupled front-end, the **Headless** tab
(`/admin/config/people/miniorange_2fa/headlesSsetup`) provides a
challenge/validate API for completing 2FA outside the standard Drupal login form.

## Permissions

Most of the admin tabs are gated by dedicated, security-sensitive permissions
(`miniorange 2fa customer setup`, `miniorange 2fa login settings`, `miniorange 2fa
user management`, `miniorange 2fa headless`), all marked as restricted. The
powerful and destructive actions (disabling 2FA for everyone, per-user resets) sit
behind these permissions **and** CSRF protection. Grant them only to fully trusted
administrators at **People → Permissions**. The end-user setup and challenge
screens are not permission-gated — they're protected instead by the login session
state, so a user can only complete the second factor for the account that just
passed the password step.

## Emergency backdoor URL — off by default, use with care

The Login Settings tab exposes an **emergency backdoor** option
(`mo_auth_enable_backdoor`). When enabled, a special URL —
`/user/login?skip_2fa=<your customer API key>` — lets a user **bypass the second
factor**, but only if they also supply valid primary credentials (password) **and**
hold the `administrator`/`admin` role. It's intended as break-glass access for an
admin locked out of their device.

- It is **disabled by default**, and you should leave it off unless you
  specifically need it.
- The bypass secret travels in a **GET query string**, which means it can end up
  in server access logs, browser history, and `Referer` headers. Treat it strictly
  as emergency access, and **disable it again as soon as you've recovered**.

This is intentional, admin-only emergency access — not a default weakness — but it
deserves the caution above.

## Command-line control (optional)

The module provides a Drush command to enable or disable a specific user's 2FA:

```bash
ddev drush miniorange_2fa:change-status enable  user@example.com
ddev drush mo-2fa-status                disable user@example.com
```

This command **refuses to run** unless you first enable Drush control for 2FA
(`mo_auth_2fa_drush`) in the module's advanced settings. There is no CLI command to
configure methods or bypass the second factor — method setup happens through the
admin UI and the miniOrange cloud.
