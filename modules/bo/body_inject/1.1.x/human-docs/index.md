# Body Inject — manual setup guide

**Body Inject** (`body_inject`) inserts admin‑configured content into a page's
body based on conditions you define. Instead of editing every node to add the
same notice, call‑to‑action or boilerplate, you set up **profiles** that describe
what to inject and when, and the module appends or prepends that shared content to
matching content bodies automatically.

That makes it useful for site‑wide or section‑wide snippets — a seasonal banner,
a legal disclaimer, a promotion — that you want to manage in one place rather than
copy into each piece of content. This release supports Drupal 8 through 11.

Treat this as a **trusted‑administrator** capability. The injected content is
admin‑authored markup that is inserted into the rendered body, so whoever holds
the `administer body_inject profiles` permission can effectively inject markup or
scripts site‑wide. Grant that permission only to trusted administrators and keep
the injected snippets under their control. The module has no other
access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

1. Under **People → Permissions** (`/admin/people/permissions`), grant
   **`administer body_inject profiles`** only to trusted administrator roles.
2. Create one or more **inject profiles**, each defining the content to inject,
   whether it is appended or prepended, and the conditions under which it applies.
3. Save. Matching content then renders with the injected snippet in its body.

Because the snippets become part of the rendered page, only trusted staff should
be able to create or edit these profiles.
