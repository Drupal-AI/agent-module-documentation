# Amazon Cognito — manual setup guide

**Amazon Cognito** (`cognito`) hands Drupal's user sign-in over to an **Amazon
Cognito user pool**. When it is enabled, the authentication flows people are used
to — registration, login, and password reset — are handled through Cognito rather
than by Drupal's own account system, and each Cognito identity is mapped to a
Drupal account. It builds on the **External Authentication** (`externalauth`)
module, which is how the account linking is done, and it ships its own Drush
commands and permissions.

The reason to reach for it is *federated login*. If you have a mobile app, another
web app, or several Drupal instances that should all share one set of user
credentials, pointing them at the same Cognito user pool gives you a single source
of truth for who your users are. Because the Cognito token can also unlock other
AWS resources (for example API Gateway endpoints), a Cognito-backed Drupal login
can become part of a wider AWS access story.

This module does **not** work the moment you enable it — it needs configuration.
You must create a Cognito user pool on the AWS side (using the *Email* sign-in
flow, since that is currently the only flow supported, and it cannot be changed
after the pool is created), then tell Drupal how to reach it. The connection
details — AWS region, access key and secret, user pool ID, and app client ID — are
supplied through `settings.php`, not through an admin form.

A few security points are worth keeping in mind, as with any single sign-on
integration: keep the Cognito app **client secret** and AWS credentials out of
exported configuration (store them as environment-backed secrets), run everything
over **HTTPS**, and think carefully about account creation and role mapping so a
new Cognito user does not silently receive more access than you intend.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   pull in the External Authentication dependency.
2. [Configuration](configuration/index.md) — the AWS-side user pool, the
   `settings.php` connection block, and account/role mapping.

## Where it lives in the admin menu

Amazon Cognito has **no dedicated settings page** of its own — its connection to
AWS is configured in `settings.php` (see [Configuration](configuration/index.md)).
Account linking is handled through the External Authentication module, so once a
user has signed in via Cognito you will see the mapped account under **People**
(`/admin/people`) like any other user. The module's permissions appear on the
usual **People → Permissions** screen.
