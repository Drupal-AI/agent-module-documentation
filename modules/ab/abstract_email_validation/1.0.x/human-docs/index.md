# Abstract API Email Validator — manual setup guide

**Abstract API Email Validator** (`abstract_email_validation`) checks email
addresses entered into your forms against **Abstract's email-validation API**
before they are accepted. When someone submits an email field, the module asks
Abstract's service whether the address looks deliverable and whether it is a
disposable or role-based address (like `info@` or a throwaway inbox), and rejects
the ones that fail.

The point is data quality and spam reduction: fewer invalid signups, fewer fake
or throwaway addresses in your user base, and cleaner data downstream. It is a
good fit anywhere you collect email addresses and care that they are real and
reachable.

There are two things to be honest about. Every validation is an **API call to
Abstract**, so it has a cost and, because the email address is sent to a
third-party service, a privacy dimension — the address leaves your site. And the
**API key** Abstract gives you is a credential that should be stored securely in
an environment variable, not committed to configuration. The module provides its
own permissions to control administration.

This guide is written for a **human** setting the module up through the admin UI.
If you want the terse, token-cheap reference written for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

> **Note on the available documentation.** The upstream agent docs are brief and
> do not spell out an exact settings-page path or a field-by-field breakdown, so
> the steps below are high-level. Confirm the specifics against the module's own
> README once it is installed.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and store your Abstract API key.

## How to use it

After enabling the module, obtain an API key from Abstract and store it securely
(see Installation). The validator then applies to email fields on your forms, so
that submitted addresses are checked against Abstract's service before being
accepted. Because each check costs an API call and sends the address to a third
party, apply it where email quality genuinely matters (for example, registration
and lead forms) rather than everywhere.
