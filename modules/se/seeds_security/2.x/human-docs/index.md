# Seeds Security — manual setup guide

**Seeds Security** (`seeds_security`) is a starter module that enables a curated
set of security modules for the Seeds distribution. It is a "security guard"
convenience aggregator: enabling it installs and turns on a group of well-known
hardening modules in one step, so a new site starts from a baseline of protections
instead of a blank slate.

Hardening a Drupal site normally means enabling and configuring a set of
established security modules. Seeds Security bundles that starting point. The
modules it pulls in are **Username Enumeration Prevention**
(`username_enumeration_prevention`), **CAPTCHA** (`captcha`), **reCAPTCHA**
(`recaptcha`), **Activities** (`activities`), **Password Policy**
(`password_policy`), **Remove HTTP Headers** (`remove_http_headers`), **Security
Kit** (`seckit`), **Session Limit** (`session_limit`), **Restrict IP**
(`restrict_ip`), and **Email TFA** (`email_tfa`). Composer installs them alongside
Seeds Security.

It adds security rather than posing a risk. The important thing to understand is
that it is an **opinionated bundle**: a starting point, not a substitute for
understanding each control. After enabling it, review which modules it brought in
and whether their default configuration matches your needs — several of them (for
example reCAPTCHA, Restrict IP, and Password Policy) need site-specific settings
before they do anything useful. It works as a curated security starter on a
non-Seeds site too, subject to that same review.

This module has **no configuration screen of its own** — hardening is configured
in the individual modules it enables.

This guide is written for a **human** working through the admin UI. If you want
terse references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   bundle.

## How to use it

There is nothing to configure on Seeds Security itself. After enabling it, work
through the settings pages of the modules it brought in — add your reCAPTCHA keys,
set a password policy, configure Security Kit's headers, define any IP
restrictions, and enable email two-factor authentication — then test each control
before production.
