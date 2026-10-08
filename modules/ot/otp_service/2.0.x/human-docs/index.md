# OTP Service — manual setup guide

**OTP Service** (`otp_service`) is a building block for adding **one‑time password
(OTP)** verification to your site. It gives your users a way to set up an
authenticator secret and gives your code a service to validate the codes they
enter — so you can gate a page or feature behind an OTP without implementing the
crypto yourself. Under the hood it uses the well‑known `pragmarx/google2fa`
library, so users' codes come from standard authenticator apps like Google
Authenticator or Microsoft Authenticator.

It provides two main pieces:

- A **block** that lets a logged‑in user set up their secret by scanning a QR code
  with their preferred authenticator app.
- A **validation service** (and a validation form) your custom code can call to
  check a user‑entered OTP, returning true/false so you can decide whether to grant
  access.

The typical use case: users already log in normally (no 2FA at login), but when
they reach a sensitive page or feature they must enter an OTP to continue. You
place the setup block, collect the code with a form, and call the service to
validate it.

> **Security note — the secret is stored unencrypted.** Each user's OTP secret is
> saved as a field on the user entity and is **not** encrypted at rest. Factor that
> into your threat model, and restrict who can read user field data accordingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls in
   the google2fa library) and enable the module.
2. [Configuration](configuration/index.md) — place the setup block, set
   permissions, and wire the validation service.
