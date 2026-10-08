# Magic Code — manual setup guide

**Magic Code** (`magic_code`) provides a **passwordless "magic code"
authentication and verification system**. A magic code is a short, alphanumeric
code — the kind you have seen apps like Slack use — that a user can be emailed and
then type in (or click through) to prove who they are: to log in without a
password, or to verify a sensitive action.

Rather than reinventing the wheel, Magic Code integrates with the
[Verification API](https://www.drupal.org/project/verification) module: it adds a
verification provider that handles the whole lifecycle of these codes —
**creating** them, **verifying** them, and **invalidating** them once used. Two
submodules turn that engine into ready‑made flows: **Magic Code Email Login**
(`magic_code_email_login`) for passwordless email login, and **Magic Code Verify
Form** (`magic_code_verify_form`) for a code‑entry verification form.

> **Security model — read this before deploying passwordless login.** A magic code
> is a login credential, so the strength of the implementation is what stands
> between a convenient sign‑in and an account‑takeover path. Magic Code is built
> carefully, and the details matter:
>
> - **Unguessable codes.** Codes are generated with a cryptographically secure
>   random number generator (`random_int`), not a predictable sequence.
> - **Short‑lived and single‑use.** Each code is stored with an **expiry (TTL)**
>   and a single‑use status flag, so an old or already‑used code cannot be
>   replayed.
> - **Flood protection (anti‑brute‑force).** Verification is rate‑limited, modelled
>   on Drupal core's `basic_auth`: independent **per‑IP** and **per‑user** limits
>   on both code creation and verification (by default on the order of ~50 failed
>   verifications per hour per IP), and those limits are checked **before** any
>   code lookup happens — so an attacker cannot grind through the code space.
> - **Tightly scoped.** A verification only succeeds when a non‑expired, active
>   code matches the exact user, email, operation, and client it was issued for.
>
> Because codes are unguessable, expiring, single‑use, and flood‑limited, brute
> force is well mitigated. Your remaining responsibilities are the ordinary ones:
> deliver codes over a **secure (TLS) mail path**, serve login over **HTTPS**, and
> keep the expiry short. Account security ultimately depends on the security of
> the user's email inbox.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   base module, its dependencies, and the submodule(s) for the flow you want.
2. [Configuration](configuration/index.md) — the security‑relevant settings (code
   lifetime and flood limits), the backend UI, and the login/verify flows.

## Where it lives in the admin menu

Magic Code adds a backend UI for managing issued codes (the exact location
appears in the admin menu once the module and its submodules are enabled). Its
behaviour is driven through the Verification API and the two submodules rather
than a single top‑level settings page.

## How to use it

1. Install and enable the module along with its **Consumers** and **Verification**
   dependencies (see [Installation](installation/index.md)).
2. Enable the submodule for the flow you need — **Magic Code Email Login** for
   passwordless login, **Magic Code Verify Form** for action verification.
3. Review the security‑relevant settings (code lifetime, flood limits) and make
   sure outbound email is configured over a secure path — see
   [Configuration](configuration/index.md).
