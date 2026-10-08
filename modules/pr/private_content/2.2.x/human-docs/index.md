# Private Content — manual setup guide

**Private Content** (`private_content`) lets users flag an individual node as
"private" so that only people with the right permission — plus the node's own
author — can see or edit it. Everyone else is locked out, and not just from the
node's page: private nodes disappear from search results, the front page, and
Views listings too, so sensitive content stays hidden wherever it would normally
appear.

It's a lightweight way to add per-node privacy without reaching for heavier
access frameworks like Group or Domain Access. The module adds a **Private**
checkbox to node forms (tucked in next to Published and Promoted), and per content
type you decide how that checkbox behaves: privacy can be off entirely, available
but off by default, available and on by default, or forced on for every node of
that type. Three permissions decide who can flip the flag, who can edit someone
else's private content, and who can view private content at all.

A couple of important design points: the module only ever *removes* access — it
never grants access a user wouldn't otherwise have — and a node's author always
retains full access to their own private nodes regardless of the permissions.
Because it switches on Drupal's node-access-grants machinery, enabling the module
(or changing a content type's privacy mode) requires a **node access rebuild** to
apply the rules to existing content, and there is a small performance cost from
the extra access checks.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and run the initial node access rebuild.
2. [Configuration](configuration/index.md) — set each content type's privacy
   mode, grant the three permissions, use the Private checkbox and the bulk
   actions, and rebuild node access.

## Where it lives in the admin menu

Private Content has **no dedicated settings page**. You configure it in two
familiar places:

- **Per content type** — **Structure → Content types → *(type)* → Edit**, in the
  "Privacy settings" group under *Additional settings*.
- **Permissions** — **People → Permissions**
  (`/admin/people/permissions`), where you grant the three Private Content
  permissions.

## How to use it

Once the module is enabled and each content type's privacy mode is chosen (see
[Configuration](configuration/index.md)), authors and editors mark content
private by ticking the **Private** checkbox on the node form. You can also
bulk-mark a selection of nodes private (or public again) from the content admin
listing using the provided actions. A node's author always keeps access to their
own private nodes; other users need the **Access private content** permission to
view them, or **Edit private content** to change them.
