# Email Enumeration Prevention — manual setup guide

**Email Enumeration Prevention** (`eep`) closes a subtle privacy leak in two of
Drupal's built-in forms. By default, the **registration** form and the
**password-reset** form respond differently depending on whether an email address
or username already belongs to an account — which lets an attacker probe your site
to discover valid accounts (an "enumeration" attack). This module normalises those
responses so an outsider cannot tell a registered address from an unregistered one.

It is a small, configurable security hardening module: install it, enable the
protection on each form, and customise the messages users see. It depends on core's
**User** module and the **Token** module (used so your custom messages can include
tokens), defines its own permissions, and sits in the Security package.

Two honest caveats to keep it effective. First, enable it on **both** flows — the
registration form and the password-reset form — since either one on its own is an
enumeration oracle. Second, be aware that enumeration can still leak through other
channels this module does not touch: response **timing**, or other endpoints such
as JSON:API/REST user routes and login errors. EEP hardens the two forms it
targets; it is not a claim to have closed every possible oracle. It has no
access-control role beyond the permission it defines.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its User / Token dependencies.
2. [Configuration](configuration/index.md) — turn on protection for each form and
   customise the messages and registration email, field by field.

## Where it lives in the admin menu

The settings form is at **Configuration → EEP settings** (`eep.settings`). Grant
its permission at **People → Permissions** (`/admin/people/permissions`).
