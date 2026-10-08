# Role request — manual setup guide

**Role request** (`role_request`) adds a self-service **request → approve** workflow
for roles. Instead of an administrator granting every role by hand, a user can
request one or more roles from their profile page, and a designated role manager
reviews the request and approves or denies it. On approval, the requested roles are
granted to the user. The classic use case is a community site where members apply
for elevated status.

The workflow is: a user (with the *Request role* permission) submits a request,
optionally with a message explaining why; the request is created as "pending
review"; an administrator with the *Administer role requests* permission reviews it
and approves or denies it, optionally attaching a note; and on approval the roles
are actually granted. Approval and denial emails can be configured with tokens to
personalize the message.

The module requires Drupal 11 and depends on core's User module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which roles can be requested,
   set permissions, and configure the emails.

## Where it lives in the admin menu

Once enabled, configure the module at **Configuration → People → Role request**
(`/admin/config/people/role-request`). Users make requests from their own profile
page, and role managers review them.

## Important: this permission is powerful

Approval grants whatever role was requested, so give the *Administer role requests*
permission only to people you trust as full site administrators and — as covered in
[Configuration](configuration/index.md) — do **not** offer privileged roles in the
list of requestable roles.
