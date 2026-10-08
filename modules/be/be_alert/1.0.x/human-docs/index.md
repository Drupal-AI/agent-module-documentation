# BE-Alert — manual setup guide

**BE-Alert** (`be_alert`) integrates the Belgian government's
[BE-Alert](https://www.be-alert.be/) emergency-alert system with Drupal. BE-Alert
is the national system that warns residents about emergencies — floods, major
incidents, chemical hazards — relevant to their location. This module provides
the Drupal-side features for a Belgian public-sector or government site to work
with BE-Alert notifications, so residents can be informed of alerts through the
site.

The module talks to the BE-Alert service using API credentials. **Those
credentials are a secret and must be handled as one** — store them in an
environment variable (env-backed), never hard-code them in code or commit them to
configuration that lands in version control. On this project that means saving the
value with DDEV's dotenv command into `.ddev/.env` (which is not committed) and
referencing it from Drupal, rather than pasting the key into a settings form that
gets exported.

This module is only useful to sites that serve Belgian residents and have a
BE-Alert account; it is not a general-purpose notification tool. Its upstream docs
are thin (an early **1.0.0-alpha1** release), so this guide describes only what is
actually documented.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

BE-Alert provides its own permission, which you grant under **People →
Permissions** (`/admin/people/permissions`) to the roles that may manage alerts.
Its own configuration — where you supply the connection and credentials — is
reached under **Configuration**.

## How to use it

1. Obtain BE-Alert API credentials for your organisation.
2. Store those credentials securely in an environment variable (see the note
   above) — do not commit them.
3. Enable the module and grant its permission to the appropriate role.
4. Configure the BE-Alert connection so the module can reach the service, then use
   its alert features to inform residents of emergencies relevant to their area.
