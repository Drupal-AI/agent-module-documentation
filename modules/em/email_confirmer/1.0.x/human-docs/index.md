# Email confirmer — manual setup guide

**Email confirmer** (`email_confirmer`) provides a shared, reusable way to check
that an email address really belongs to whoever typed it in — the classic
"double opt-in" pattern. When your site (or a module) needs to verify an address,
Email confirmer emails a unique, signed confirmation link, records whether the
recipient confirmed or cancelled, and remembers addresses that have already been
confirmed so nobody has to confirm the same address twice.

The base module is mostly **developer-facing**: it exposes an `email_confirmer`
service and a confirmation content entity, so other modules can call
`\Drupal::service('email_confirmer')->confirm($email, ...)` to start a
confirmation and react to the result. On its own it shows nothing to end users
apart from the confirmation link they receive and the response page. The bundled
**Email confirmer (user)** submodule (`email_confirmer_user`) wires all of this up
to Drupal's own user email-change flow, so it is the easiest way to see the module
in action without writing code.

What you *can* control from the UI is on the **settings form**: how long a
confirmation link stays valid, how long confirmation records are kept before cron
deletes them, how soon a link can be resent, whether responses are locked to the
requesting IP address, the wording of the request email, and whether hitting the
link confirms instantly or shows a response form first. Security rests on an
unguessable HMAC signature baked into each link, not on a password or login.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent (including the service API and
`hook_email_confirmer()`), read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and decide whether to enable the user submodule.
2. [Configuration](configuration/index.md) — the settings form field by field,
   plus the permissions the module defines.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Email Confirmer**
(`/admin/config/system/email-confirmer`) and requires the **Administer site
configuration** permission. The module also defines two of its own permissions
(see [Configuration](configuration/index.md)).
