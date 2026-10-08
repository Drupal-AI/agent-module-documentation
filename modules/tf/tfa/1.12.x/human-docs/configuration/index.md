# Configuration

TFA has one required prerequisite (an encryption profile), a global settings form,
and a per-user enrollment flow. This page covers all three.

## Step 1 — Create an encryption profile (required)

TFA stores its secrets encrypted and **will not enable** until an encryption
profile is selected. Set this up first, in order:

1. **Enable an encryption method** — install and enable a module that provides one,
   such as Real AES or Sodium.
2. **Create an encryption key** — under **Configuration → System → Keys**
   (the Key module), add a key of the type the encryption method expects.
3. **Create an encryption profile** — under **Configuration → System → Encryption
   profiles** (the Encrypt module), create a profile that uses your encryption
   method plus the key you just made.

Until this profile exists, the *Enable TFA* checkbox on the settings form stays
disabled and the form cannot be saved.

## Step 2 — Configure TFA

1. Log in as a user with the **Admin tfa settings** permission.
2. Go to **Configuration → People → Two-factor Authentication**
   (`/admin/config/people/tfa`).

Key settings on the form:

- **Enable TFA** — the master switch for the second-factor login step. Off by
  default; you can only tick it once an encryption profile exists.
- **Allowed validation plugins** — which second-factor methods users are allowed to
  set up. TOTP (`tfa_totp`) is the usual default; you can also allow HOTP and
  recovery codes.
- **Default validation plugin** — the method offered by default during login
  (typically TOTP).
- **Encryption profile** — the Encrypt profile used to encrypt stored secrets.
  Select the one you created in Step 1.
- **Required roles** — the roles for which TFA is mandatory. Members of these roles
  must set up a second factor.
- **Validation skip** — how many times a user who is required to use TFA may still
  log in before setup is enforced (default **3**). This gives people a short grace
  period to enroll.
- **Redirect users without TFA to setup** — when on, users who haven't set up TFA
  are sent straight to their setup page on login.
- **Reset password skip** — lets a super administrator skip TFA during a password
  reset. Off by default.
- **Flood control** — the failed-attempt threshold (default **6**) and time window
  in seconds (default **300**) before repeated bad codes are blocked, plus whether
  to ban by user ID only.
- **Help text** — the message shown to users who cannot complete TFA (for example,
  telling them how to contact support). 
- **Login plugins** — enable conditional-bypass plugins such as the trusted-browser
  option, which lets a user skip the second step on a device they trust.

Individual methods have their own sub-settings — for example TOTP's time-skew
tolerance and the issuer/site-name prefix shown in the authenticator app, HOTP's
counter window, and how many recovery codes are generated.

Click **Save configuration** to apply. Because these are stored in the
`tfa.settings` config object, you can export and deploy them between environments —
which also makes it easy to turn TFA off in a dev or test environment (set
`enabled` to 0) so automated logins keep working.

## Step 3 — Users enroll

Once TFA is enabled and methods are allowed, each user sets up their second factor
from their account:

1. Grant the **Setup own tfa** permission to the *Authenticated user* role (or
   whichever roles should enroll).
2. Each user goes to their account's **security → TFA** tab
   (`/user/{uid}/security/tfa`), where they can:
   - Set up an authenticator by scanning the displayed QR code.
   - Save their recovery codes somewhere safe.
   - Disable a method they no longer want (requires *Disable own tfa*).

At the next login, after entering their password, they'll be prompted for a code
from their chosen method.

## Permissions

At **People → Permissions**, TFA defines:

- **Admin tfa settings** (`admin tfa settings`) — reach the global settings form and
  change how TFA works. A trusted, administrative permission.
- **Setup own tfa** (`setup own tfa`) — set up TFA on one's own account. Grant this
  to authenticated users for a normal rollout.
- **Disable own tfa** (`disable own tfa`) — disable one's own configured TFA
  methods.
- **Administer tfa for other users** (`administer tfa for other users`) — manage or
  reset TFA for other accounts. Trusted/administrative; useful for helping a
  locked-out user.

Note that whether TFA is *required* for a user is driven by the **Required roles**
setting above, not by a permission.
