# Clone Entity Revision — manual setup guide

**Clone Entity Revision** (`clone_entity_revision`) lets editors duplicate a chosen
node *revision* into a brand-new node. Ordinary "duplicate this node" tools only ever
copy a node's *current* state; this module goes further by letting you pick any
historical revision from the node's revision history and create a fresh node from
exactly that version. That's handy for reverting-by-copy, branching content off an
earlier draft, or recovering an older version as a new page without disturbing the
original.

It declares core's **Content Moderation** module as a dependency (alongside **Node**),
so both must be enabled. Note, however, that the module itself contains **no
moderation-specific code**: the clone is a straight duplicate of the revision, so the
new node simply carries over whatever moderation state the revision's field held (any
further defaulting is core's normal handling for a new node, not something this module
sets). It supports Drupal 10 and 11.

A small but important detail for installation: the project's machine name is
`clone_entity_revision`, but its Composer package name is spelled
`drupal/clone_enity_revision` (note the transposed "enity"). Use the package name as
written for `composer require`, and the machine name for `drush en` — see
[Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. It
adds a cloning action within the node revision interface, described under "How to
use it" below.

## How to use it

1. Open a node and go to its **Revisions** tab, where its revision history is
   listed.
2. Choose the revision you want to start from and use the module's clone action for
   that revision.
3. A new node is created from that revision's content (referenced paragraphs are
   deep-cloned and file/image fields become independent copies). It opens ready for
   you to continue editing. Note the new node keeps the *original* revision's author,
   not you.

Make sure the roles that should be able to do this have the module's cloning
permission granted (see [Installation](installation/index.md)).
