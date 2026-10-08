# Simple Secret Registration Code — manual setup guide

**Simple Secret Registration Code** (`ssrc`) gates account registration behind a
secret code. It adds a *Registration code* field to the user registration form, so
only people who know the correct code can create an account.

The problem it solves is the open self-registration form. If your site lets people
register but you only want a specific group — an invite-only community, a client
portal, members who were given a code — this module gives you a simple barrier
without building a full invitation system. You define one or more secret codes,
enable the feature, and from then on every anonymous visitor sees a *Registration
code* field they must fill in correctly to register.

It is important to understand exactly what kind of protection this is. The code is
a **shared secret**, so the barrier is only as strong as the code's secrecy: a
weak, short, or leaked code effectively re-opens registration to anyone. Use a
strong, non-guessable code; rotate it periodically and after any suspected leak;
don't post it publicly; and treat it as *one* layer rather than your only defence —
pair it with Drupal's core protections such as email verification, admin approval,
flood control, and a CAPTCHA. Used that way it is a genuinely useful
registration-hardening tool.

The module layers on top of core's registration, has no other module dependencies,
provides its own permission for managing the codes, and runs on Drupal 9, 10, and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add a secret code, turn the feature
   on, and manage the codes.

## Where it lives in the admin menu

Its settings screen is at **Configuration → Manage secret registration code**
(`/admin/config/ssrc`). Once you have added a code and enabled the feature, all
anonymous visitors will see the *Registration code* field on the user registration
page.
