# Prefer Latest Content — manual setup guide

**Prefer Latest Content** (`prefer_latest_content`) is a small access/workflow
helper for sites that use Content Moderation. When an editor with the right
permission opens a published node, the module automatically sends them to the
node's **latest pending draft** instead of the published revision — so reviewers
see the newest edits on the normal canonical URL without having to click over to
the "Latest version" tab.

Concretely, when a permitted user views a published node's page, the module checks
whether a newer forward revision exists whose moderation state is *draft*. If one
does, it issues a redirect to `/node/{nid}/latest`. The behaviour is deliberately
narrow: the administrator role is excluded, anonymous visitors never trigger it
(they always stay on the published revision), and the `/node/{nid}/latest` page is
still protected by core's own "view latest version" access check. The module only
redirects — it grants no ability to edit or publish.

There is nothing to configure beyond assigning the permission. It is driven
entirely by the **`prefer latest content`** permission, which you grant to the
roles that should get the "always show me the latest draft" behaviour.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Worth knowing before you deploy:** the module's redirect logic assumes an
> `en`/`fr` bilingual setup in places, and the code paths around route matching
> are convoluted. It works well for the common case, but review its behaviour if
> your site has a different language configuration.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission.

There is **no configuration page** for this module. All setup happens by granting
the `prefer latest content` permission — see below.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **People → Permissions** (`/admin/people/permissions`).
3. Grant **`prefer latest content`** ("Force latest if available") to the
   non-administrator roles that should always land on the newest draft — typically
   editors and reviewers.
4. Leave the permission off for anonymous and general roles so ordinary visitors
   continue to see published content.

Once granted, a member of that role who opens a published node that has a newer
draft revision will be redirected to its latest version automatically. This pairs
naturally with Content Moderation's draft/forward-revision workflow.
