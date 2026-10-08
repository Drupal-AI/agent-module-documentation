# One Time Password — manual setup guide

**One Time Password** (`one_time_password`) adds authenticator‑app two‑factor
authentication to Drupal. It implements the standard one‑time‑password
algorithms — **HOTP (RFC 4226)** and **TOTP (RFC 6238)** — the same codes
produced by Google Authenticator, Authy, Aegis, 1Password, Duo Mobile, and every
other standards‑compliant app. A user scans a QR code to enrol their device, and
from then on logging in requires the rotating six‑digit code as a second factor.

Drupal core has no built‑in second factor, so this fills a real gap. It is a
deliberately narrow, lightweight take on the problem: standards‑based one‑time
passwords only, with no pluggable framework of alternative methods (which is what
distinguishes it from the older, broader `tfa` module). It depends only on core's
**User** module and ships with a small settings form.

Enrolment lives at `/user/{user}/two-factor-auth`, protected by the
`user.update` entity‑access check — the correct pattern, because it lets each user
manage their own second factor and lets holders of **Administer users** help
someone who has lost their device, without any bespoke access logic. The
verification step during login is guarded by a custom check that ties the attempt
to a value stashed in a private tempstore when the login began, so it cannot be
driven by guessing user IDs.

**Two things to plan before you roll this out** — they are what makes 2FA
deployments painful if left to chance:

1. **Recovery.** If a user loses their device and has no recovery codes, an
   administrator has to clear the factor by hand. Decide in advance who is allowed
   to do that and how they will verify the person's identity first.
2. **Which roles must enrol.** A second factor that is optional for the very
   accounts that matter (administrators, editors) is just decoration. Decide which
   roles are required to set it up and enforce it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form and the
   permissions that control enrolment.

## Where it lives in the admin menu

The settings form is at **Configuration → People → One Time Password**
(`/admin/config/people/one_time_password/settings`). Individual users enrol their
device at **My account → Two‑factor authentication**
(`/user/{user}/two-factor-auth`).

## How to use it

Each user visits their own **Two‑factor authentication** page, scans the
displayed QR code into their authenticator app, and confirms with the first
generated code to complete enrolment. After that, every login prompts for the
current rotating code. Store the recovery codes somewhere safe at enrolment time —
they are the self‑service escape hatch if the device is ever lost.
