# SAML Authentication Restrict to OU — manual setup guide

**SAML Authentication Restrict to OU** (`samlauth_restrict_to_ou`) adds a second
gate on top of SAML single sign‑on. Federated login answers *who you are* but
says nothing about *whether you belong here*: a university IdP authenticates every
student, staff member and contractor, and an enterprise IdP authenticates the
whole company. This module refuses site access to authenticated users whose
**Organizational Unit (OU)** attribute is not on a list you approve — so a site
meant for one faculty, one department or one business unit turns away everyone
else instead of quietly creating accounts for them.

It is aimed at enterprise environments using Active Directory, where you can limit
access to specific departments without creating and managing an individual Drupal
role for every user. It can parse OU values out of the complex Distinguished Name
(DN) strings that Active Directory typically sends (for example
`CN=user,OU=Marketing,OU=Users,...`), pulling out multiple OU values from a
single DN.

The module needs configuration to do anything — its settings form *is* the access
policy. It depends on the **samlauth** module and has no submodules. Note that
this project is **not covered by Drupal's security advisory policy**, so weigh
that before relying on it for a security‑critical gate.

A few things determine whether the gate is actually trustworthy, and they are
worth planning for. OU values are strings owned by another system, so a directory
reorganisation can rename them and break your list — usually by locking everyone
out — and someone should watch for that. A user may carry several OU values or a
nested path, so be deliberate about your allowed list. And the check runs after
authentication succeeds, so make sure a user who moves to a different OU actually
loses access rather than keeping a still‑usable local account.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   alongside samlauth.
2. [Configuration](configuration/index.md) — the restriction form, field by
   field.

## Where it lives in the admin menu

The configuration form is at **`/admin/config/people/saml-restrict`**, behind the
module's own restricted permission. That permission gates the screen that defines
the access‑control policy itself, so keep it to trusted administrators.
