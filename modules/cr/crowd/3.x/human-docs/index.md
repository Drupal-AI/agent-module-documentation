# Atlassian Crowd — manual setup guide

**Atlassian Crowd** (`crowd`) provides single sign-on between Drupal and an
**Atlassian Crowd** server — Atlassian's identity/SSO product. With it, users
authenticate against Crowd instead of against Drupal's local user table: the login
form's validation is redirected to Crowd, and if the credentials check out, Drupal
finds or automatically creates a matching local account for that user (provisioned
with a random local password, in the standard external-authentication pattern). It
can also detect the Crowd SSO cookie to log in users who are already authenticated
via Crowd elsewhere.

Beyond basic login, the module can associate **Crowd groups with Drupal roles** and
**redirect Drupal's self-service user forms** (such as password reset) to their
remote Crowd equivalents, so account management stays in one place. It communicates
with Crowd over REST, so the only infrastructure requirement is an open HTTP(S) link
between your Drupal and Crowd servers — no special PHP libraries.

It depends on **External Authentication** (`externalauth`, which handles the account
provisioning) and the **Key** module (`key`, which securely stores the Crowd
application credentials rather than putting them in plain config). This 3.x branch
supports Drupal 9, 10, and 11.

> This module and its maintainers are in no way affiliated with Atlassian.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its External Authentication and Key dependencies.
2. [Configuration](configuration/index.md) — store the Crowd application credentials
   as a Key, point Drupal at your Crowd server, and set up group/role mapping and
   form redirects.

## Where it lives in the admin menu

You configure the Crowd connection from the module's settings form (reach it via the
**Configure** link next to Atlassian Crowd on the **Extend** page, or under
**Configuration**). Full steps — including securely storing the credentials — are in
[Configuration](configuration/index.md).
