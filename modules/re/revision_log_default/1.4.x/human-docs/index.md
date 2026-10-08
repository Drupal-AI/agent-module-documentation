# Revision Log Default — manual setup guide

**Revision Log Default** (`revision_log_default`) fills in a sensible revision log
message automatically whenever a revisionable content entity is saved without one.
Instead of a revisions tab full of blank rows, your content histories end up
reading like a changelog — "Created new Article", "Updated the Title field",
"Created German translation" — with no extra effort from editors.

This is especially useful for the many ways content gets saved *without* a log
message: content created programmatically (`Node::create()->save()`), imported by
migrations, saved over REST/JSON:API, or edited with Quick Edit / in-place
editing. In all of those cases Drupal would normally leave the revision log empty;
this module steps in and writes a description of what happened. It also quietly
repairs common metadata problems along the way — a missing or stale revision
timestamp, or a blank revision author (falling back to the content's owner when
the save happened as an anonymous CLI/migration user).

The module is deliberately tiny: it is a single "before save" hook with **no
configuration, no admin UI, no permissions, and no settings** to manage. It works
with any revisionable entity type that supports log messages (nodes and others),
and it is aware of Content Moderation and Workbench Moderation — for moderated
content it compares against the latest revision so forward-revision workflows get
correct messages. Crucially, it never overwrites a message you set explicitly: if
your code or an editor already provided one, it is left untouched.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module. That is the entire setup.

## Where it lives in the admin menu

Nowhere — there is no settings page and nothing to click. Once enabled it works
site-wide automatically.

## How to use it

There is nothing to do beyond enabling it. From then on:

- Save any node (or other revisionable entity) without typing a revision log
  message, and the module writes one for you — "Created new *Bundle*" for the first
  save, "Updated the *Field* field" (or a list of changed fields) for edits, and
  "Created *Language* translation" for a new translation. When it can't pin down
  the exact change it falls back to "Updated *Bundle*".
- Review the results on the content's **Revisions** tab, which now reads like a
  meaningful history instead of a wall of blank entries.
- If you *want* a specific message, just set it before saving — for example
  `$node->setRevisionLogMessage('my message')` in code, or by typing one in the
  edit form. The module only acts when the message is empty, so your wording always
  wins.
