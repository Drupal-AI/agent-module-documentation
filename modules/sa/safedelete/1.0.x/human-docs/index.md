# SafeDelete — manual setup guide

**SafeDelete** (`safedelete`) protects your content from a quiet but common
problem: someone deletes (or archives) a node that other pages link to, and those
inbound links silently break. SafeDelete steps in at delete time, checks whether
the node is referenced by **Linkit**-created links inside other entities' body
fields, and if it is, blocks the operation and lists the referencing content right
there on the delete form — so the editor sees exactly what would break before
anything is lost.

The module was originally built to guard against deleting content that has Linkit
references, and it has grown to cover more: it validates on both node delete and
node save (including changes into an *archived* moderation state), can be turned on
or off per content type, can cap how many referencing records it lists, and can
optionally hide the delete button entirely for dependent content (users with a
special permission can still see it). It also provides an **orphaned-nodes report**
so you can find content nothing links to.

SafeDelete needs a little configuration to be useful — you choose which content
types it guards and a few options on its settings form. It depends on core's
**Node** module and on **Linkit**, and it needs the `ezyang/htmlpurifier` PHP
library (which it uses to parse links out of body fields). It has an optional
submodule that reports on menu links pointing at archived nodes, but the main
project ships without additional required submodules.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — Composer (including the HTML Purifier
   library), dependencies, and enabling the module.
2. [Configuration](configuration/index.md) — choosing guarded content types, the
   record limit, the delete-button option, and the orphaned-node reports.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → SafeDelete**
(`/admin/config/development/safedelete`, config route `safedelete.settings`),
protected by the **SafeDelete administration** permission. The orphaned-node report
is generated and viewed at `/admin/content/safedelete-orphanedpages` (and its
`/viewreport` sibling), each behind its own permission.

## How it protects content

Once configured, the protection is automatic. When an editor tries to delete a
guarded node — or change it into an archived moderation state — SafeDelete checks
for inbound Linkit references in other nodes' body fields. If any exist, it blocks
the action and shows the list of referencing content, so the editor can decide
whether to update those links first. All of SafeDelete's routes are permission-
gated; the module adds deletion-guard validation rather than any new public-facing
endpoints. The optimal-compatibility note from the module's docs recommends running
it on recent core (Drupal 10.4.8+ / 11.1.8+).
