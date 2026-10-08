# Mobile Number Login — manual setup guide

**Mobile Number Login** (`mobile_number_login`) lets users sign in with their
**mobile number** instead of (or in addition to) a username or email — phone-based
authentication, typically confirmed by an SMS one-time code (OTP). It's useful on
sites where the mobile number is already the mandatory, primary account identifier
and you want the login form to match. The module is part of the **Mobile** package
and layers on top of Drupal's core authentication.

Because it is an authentication feature, it is **security-sensitive**. Phone login
depends on a one-time code delivered by SMS, and to be safe that code must be
cryptographically random, single-use and expiring, with **flood/rate-limiting** on
both *sending* (to prevent SMS-bombing and cost abuse) and *verification* (to
prevent brute-forcing the code). Those protections, and the SMS delivery itself,
generally come from the underlying mobile-number / SMS layer your site uses, so part
of setup is confirming that layer is configured correctly and that its **SMS-gateway
credentials are stored as secrets**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable phone login and verify the
   SMS/OTP and flood-control setup.

## How to use it

Once installed and configured, users can enter their mobile number on the login
form and confirm with the OTP they receive by SMS. See
[Configuration](configuration/index.md) for the setup and the security checks that
matter.
