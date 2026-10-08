# Group JSON:API Create Access — manual setup guide

**Group JSON:API Create Access** (`group_jsonapi_create_access`) fixes a
long-standing problem that stops decoupled and headless sites from adding group
content over JSON:API. In the [Group](https://www.drupal.org/project/group)
module, the *create* access check needs to know which group the new content is
being added to (`$context['group']`). On a JSON:API POST that context is not
present, so creating group relationship entities — memberships, group nodes, and
so on — over JSON:API, REST, or GraphQL normally fails outright (drupal.org issue
#2872645).

This module solves that by supplying the missing context from the request itself.
It watches for JSON:API POST routes that create `group_relationship` entities and
replaces their standard create-access requirement with its own check. That check
reads the group's UUID from the request body (`data.relationships.gid.data.id`),
loads the matching group, and then hands off to Group's *own* create-access
logic with the group now in context.

Importantly, the module does **not** grant access on its own or weaken any
permission. It only reconstructs the context so Group's real permission check can
run correctly — and if no valid group can be found in the request body, the
request is denied. Malformed JSON is treated the same way (denied). Standard
Group permissions still apply exactly as before.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Group and JSON:API.

There is **no configuration page** for this module — installing it is all that is
needed.

## Where it lives in the admin menu

Group JSON:API Create Access adds **no admin page, no settings form, and no
permissions of its own**. It works transparently on the relevant JSON:API routes
the moment it is enabled.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). No configuration
   is required.
2. From your JSON:API client, POST a `group_relationship` entity and include a
   `gid` relationship pointing at the target group — for example:
   `data.relationships.gid.data.id` set to the group's UUID.

Group's own create-access permissions are then evaluated with the correct group in
context, and the request succeeds or is denied according to those permissions.
