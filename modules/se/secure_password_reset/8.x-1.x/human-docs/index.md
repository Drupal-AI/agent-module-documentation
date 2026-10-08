# Secure Password Reset — manual setup guide

**Secure Password Reset** (`secure_password_reset`) closes a small but real
information leak in Drupal's "forgot password" flow. Out of the box, when someone
submits the password-reset form, core tells them whether an account with that name or
email actually exists — which lets an attacker probe the form to build a list of valid
usernames. Those lists then feed brute-force, credential-stuffing, and phishing
attacks. This module removes the leak by returning the **same neutral message whether
or not the account exists**.

This is a purely security-positive hardening module. It changes only the message the
reset form shows; it does not add content types, permissions, or any settings, and it
has no role in access control. It works across a wide range of Drupal versions
(core 8 through 11).

The best part is that there is nothing to configure. The moment you enable the module,
the reset form stops disclosing whether a username or email is valid — that is all it
does, and it does it automatically.

This guide is written for a **human** installing and enabling the module. If you are an
AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (no configuration needed).

## How to use it

Simply enable the module — there is no settings form. To confirm it is working, go to
the password-reset form (`/user/password`) and submit a name or email that does *not*
belong to any account: the response should be the same neutral confirmation you get for
a valid account, rather than an error saying no such account exists.

> Note: the module's project page mentions a similar, more widely installed option,
> **Username Enumeration Prevention**, which you may want to compare before choosing.
