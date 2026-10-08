# Organic Groups access control — manual setup guide

**Organic Groups access control** (`og_access`) adds real privacy to
[Organic Groups](https://www.drupal.org/project/og). Once enabled, a group — and
each piece of content inside it — can be marked **Public** (visible to everyone on
the site) or **Private** (visible only to members of that group), and the module
makes sure that choice is actually enforced.

What makes it trustworthy is *how* it enforces access. Rather than hiding a page
at display time (which can leak through listings, search results, or an alternate
URL), it plugs into Drupal's **node access grant** system — the low-level
mechanism core uses to filter which nodes a user is allowed to see. That means
private group content is stripped out of the query itself, so it never shows up in
Views, listings, or any other node query for someone who isn't a member. This is
the correct, strong way to keep content private.

Because it builds directly on Organic Groups, it has no meaning on its own — you
install and configure it as part of an Organic Groups site. It depends only on the
`og` module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   rebuild node access permissions.

There is **no dedicated settings form** for this module. Group and content
visibility are set through fields on your groups and group content (added when you
enable the module), described in "How to use it" below.

## How to use it

1. Make sure Organic Groups itself is set up — you have at least one group type and
   one group‑content type configured. If you're new to Organic Groups, start with
   its own documentation; `og_access` only adds the *private/public* layer on top.
2. Enable `og_access` (see [Installation](installation/index.md)). Enabling it adds
   the visibility controls to your group and group‑content entities.
3. **Rebuild node access permissions.** Because this module changes how node access
   is calculated, Drupal needs to recompute the grants for existing content. Visit
   **Reports → Status report** and use the "rebuild permissions" link if Drupal
   prompts you, or run `drush php:eval 'node_access_rebuild();'`. Do this once after
   enabling, and again if you change visibility defaults later.
4. On each group, set its **Group visibility** to Public or Private, and on each
   item of group content set its **Group content visibility** the same way. Private
   content is then only reachable by members of that group.

> **Tip:** After setting things up, verify the behavior by browsing the site as a
> non‑member (for example in a private browser window while logged out) and
> confirming that private group content does not appear in listings or by direct
> URL.
