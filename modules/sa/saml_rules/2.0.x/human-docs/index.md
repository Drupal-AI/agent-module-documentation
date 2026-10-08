# SAML Rules — manual setup guide

**SAML Rules** (`saml_rules`) sits on top of the SAML Authentication
(`samlauth`) module and lets you decide what should happen to a user account the
moment someone signs in through your identity provider (IdP). Instead of hand‑
editing accounts, you write rules that fire automatically on login: give a person
a role because their SAML data says they belong to a certain group, set or
correct their email address, or copy attribute values from the IdP straight into
custom fields on the user profile.

It solves a very common single sign‑on headache. Many IdPs send group,
department or entitlement information as SAML attributes, and some send a
duplicated or empty email address. SAML Rules turns those attributes into
concrete Drupal actions — role assignment, email normalisation and
attribute‑to‑field mapping — using simple `[attribute]` placeholders so you can
build quite custom mappings without writing code.

The module does nothing until you configure it: enabling it adds the admin
screens and the login hook, but you have to create at least one rule before any
change takes effect. It requires the `samlauth` module and has no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module alongside `samlauth`.
2. [Configuration](configuration/index.md) — the two rule types, the admin
   matrices, and the settings form, field by field.

## Where it lives in the admin menu

Once enabled, the module's screens live under
**Configuration → People → SAML Rules** (`/admin/config/people/saml-rules`).
Every route there is gated by the **Administer SAML Rules**
(`administer saml rules`) permission, so only trusted administrators can create
or change rules. You will find matrix views for authentication rules and for
user‑field rules, add/edit/delete forms for each, and a general settings form.

## How to use it

The rules you build run automatically on SAML login — there is no button to
press per user. Set up `samlauth` with your IdP first, define your authentication
and user‑field rules here, then test with a real login and confirm the account
received the roles, email and field values you expect.
