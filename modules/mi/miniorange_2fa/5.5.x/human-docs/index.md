# miniOrange Two-Factor Authentication (2FA / MFA) — manual setup guide

**miniOrange Two-Factor Authentication** (`miniorange_2fa`) adds a second step to
Drupal login, so that after entering a password a user must also prove they hold a
second factor — a code from an authenticator app, a one-time passcode over email
or SMS, a push notification, a hardware token, and more. It's a broad two-factor /
multi-factor suite with role-, domain-, and IP-based policies, recovery codes, and
even passwordless login.

Supported second factors include: **authenticator apps** (TOTP — Google, Microsoft,
Authy, Duo, and others), **OTP over email**, **OTP over SMS or phone call**, **push
notifications**, **QR-code scan**, **knowledge-based authentication** (security
questions), **hardware/OTP tokens** (e.g. YubiKey), a **grid-pattern** challenge,
and **WebAuthn / passkeys** (via the bundled `miniorange_webauthn` submodule). A
second submodule, `registration_verification`, can OTP-verify new user
registrations.

> **How it works — and an honest note about the cloud service and licensing.**
> For most methods, the actual OTP generation and verification are performed by
> the **miniOrange (Xecurify) cloud service**, not on your own server. That means
> you must register a miniOrange customer account from inside the module; the
> site's stored customer id and API key are used to make challenge/verify calls to
> their API. Some capabilities and higher usage volumes (SMS/phone are metered,
> and certain advanced features) fall under miniOrange's **paid/licensed** tiers,
> while a core set of methods is available for free. Check the miniOrange plan
> details for exactly what your use case needs before rolling out to production.

The module inserts its second-factor step into the standard login form and the
password-reset flow, and it can also gate Basic-Auth API requests behind completed
2FA. It provides admin policy pages, per-user management, recovery codes, and an
optional emergency "backdoor" URL for admins locked out of their second factor
(off by default — see the configuration guide for the important caveats).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (plus the optional submodules).
2. [Configuration](configuration/index.md) — register the miniOrange account, set
   the 2FA policy, choose methods, manage users, and the emergency backdoor.

## Where it lives in the admin menu

All of miniOrange 2FA's admin screens live under **Configuration → People →
miniOrange 2FA** (`/admin/config/people/miniorange_2fa`). The first stop is the
**Account & License** tab, where you register the required miniOrange account.
