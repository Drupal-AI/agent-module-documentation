# User Default Page — manual setup guide

**User Default Page** (`user_default_page`) controls where a user lands after they
log in or log out. Instead of the default `/user/{uid}` profile page, you can send
users to a custom destination — a dashboard, a content listing, a membership area,
or a Views page — chosen by their role and/or their specific user ID, with an
optional status message shown on arrival.

Each rule is a small configuration entity you create in the admin UI. A rule
targets a set of roles and/or a list of user IDs, and holds a login redirect (with
message) and a logout redirect (with message). When a user logs in or out, the
module picks the matching rule: a match on the user's ID takes priority, otherwise
the highest-weight matching role rule wins.

The destination always comes from admin-entered configuration, not from a request
parameter, and it is validated before the redirect happens — so there is no
open-redirect risk from user input. The module also plays nicely with related
modules: it leaves one-time / password-reset logins alone, skips autologout's
logout routes, and can cooperate with Rename Admin Paths and the Redirect module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create redirect rules and understand
   how the matching works, field by field.

## Where it lives in the admin menu

Redirect rules are managed at **Configuration → People → User Default Page**
(`/admin/config/people/user_default_page`). The module defines no permission of
its own — the admin UI is gated by core's **Administer site configuration**
permission.
