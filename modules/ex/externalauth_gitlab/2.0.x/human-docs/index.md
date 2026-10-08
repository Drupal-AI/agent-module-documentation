# External Auth GitLab — manual setup guide

**External Auth GitLab** (`externalauth_gitlab`) lets people log in to your Drupal
site with their **GitLab** account. When a user chooses to sign in, they're sent
to your GitLab instance (or gitlab.com), they authenticate there, and on a
successful return the module logs them into Drupal. It's a straightforward way to
offer GitLab-backed single sign-on to a team that already lives in GitLab.

The trust model is worth being clear about. The module uses **OAuth 2.0** and maps
the GitLab identity to an existing Drupal account **by email address** — it does
**not** register new users. So a person can only log in through GitLab if a Drupal
account with the same email already exists. Drupal's permissions still come from
that mapped account, via the External Authentication (`externalauth`) module this
one builds on; GitLab handles *who you are*, Drupal still decides *what you can
do*.

On the operations side, look after the parts you control: keep the GitLab
**client secret** confidential, serve the whole login flow over **HTTPS**,
restrict the settings form to trusted administrators, and point the module at a
GitLab instance you trust — it is the authority that decides who may sign in.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it pulls in External Authentication).
2. [Configuration](configuration/index.md) — register a GitLab OAuth application,
   store the client secret safely, and fill in the module's settings.

## Where it lives in the admin menu

The settings form is at **Configuration → People → External Auth GitLab settings**
(`/admin/config/people/externalauth-gitlab-settings`). Once configured, the module
adds a login link as a local task on the user account area (`/user`); following it
sends the user to GitLab and back.
