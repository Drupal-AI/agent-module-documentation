# Revision Summary — manual setup guide

**Revision Summary** (`revision_summary`) is a small developer helper. It answers
a very specific question: *which fields changed between two revisions of a content
entity, and what were the added and removed values?* It does this by wrapping the
[Diff](https://www.drupal.org/project/diff) module's comparison engine in a tidy
service you can call from your own code.

It is important to understand what this module is **not**. It adds no pages, no
menu items, no permissions, no blocks, and no settings form. There is nothing to
click. Everything it offers is a service — `revision_summary.compare_revisions` —
meant to be called from a custom module, a preprocess function, a Twig template,
or a Drush script. If you are looking for an editor-facing "compare revisions"
screen, that is what the Diff module itself provides; Revision Summary is the
lower-level building block for developers who want the changed-field data in
their own code.

Typical uses include building a revision changelog for editors, powering a
notification email when a particular field changes, or feeding changed-field data
into a custom dashboard. Because the helpers load revisions without applying user
access checks, **you are responsible for your own access control** before showing
any results to a visitor.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Diff
   dependency with Composer, and enable it.

This module has **no configuration page** — it is a code-facing service with no
settings form. See "How to use it" below for how to call it from your own code.

## How to use it

Fetch (or inject) the `revision_summary.compare_revisions` service and call one of
its methods, passing the loaded "new" entity and the revision id you want to
compare it against:

```php
$cmp = \Drupal::service('revision_summary.compare_revisions');
$entity = \Drupal\node\Entity\Node::load($nid); // the "new" revision
$old_vid = 1461634;                             // the revision id to compare against

// Map of changed field machine name => human label.
$changed = $cmp->listChangedFields($entity, $old_vid);

// Added/removed lines for a single field.
$delta = $cmp->listChangesInField($entity, $old_vid, 'body');
// => ['added' => [...], 'removed' => [...]]

// Renderable markup for a field, or an inline "Label: added X; removed Y" summary.
$build  = $cmp->listChangesInFieldAsMarkup($entity, $old_vid, 'body');
$inline = $cmp->giveFieldNameWithChangesInlineAsMarkup($entity, $old_vid, 'field_x', 'My label');
```

A few things worth knowing:

- The service is currently **node-centric** — some helpers hard-code node storage
  and the `nid` column, so it is happiest working with nodes.
- No access checking is performed. Gate the output yourself before showing it to
  users.
- `latestRevisionIdWithChangedField()` builds a raw SQL query using the field name
  you pass in. Treat that argument as trusted developer code — **never** pass
  request/user input into it.

> **Tip for list fields:** the underlying Diff module shows core list fields
> (numeric lists, text lists) by their key rather than their label by default. If
> you want a change to read "added *Wheelchair Full Access*" instead of "added
> *3*", visit **Configuration → Content authoring → Diff → Fields**
> (`/admin/config/content/diff/fields`), edit the relevant field's settings, and
> change its comparison method from "Key" to "Label" (or "Label (key)").
