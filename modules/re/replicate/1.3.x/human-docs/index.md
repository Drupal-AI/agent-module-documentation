# Replicate — manual setup guide

**Replicate** (`replicate`) is a developer‑only API for cloning (duplicating) any
content entity in code. Give it a node, taxonomy term, comment, file, or any other
fieldable entity and it hands back a duplicate — either unsaved (so your code can
adjust it first) or already saved. Crucially, as it works it fires a series of
events so other code can control exactly *how* each entity type and each field type
is duplicated.

The reason those events matter is the difference between a **shallow** and a
**deep** clone. By default, entity‑reference fields on the copy keep pointing at the
same target entities — the reference is shared, not copied. By subscribing to the
right event you can instead recursively replicate a referenced entity so the clone
gets its very own copy, or make any other per‑field or per‑entity adjustment (append
" [clone]" to a title, reset a unique value, unpublish the copy, and so on). The
module ships two built‑in subscribers: one clears the URL alias on cloned `path`
fields so copies do not collide, and one (active only when Layout Builder is
enabled) deep‑clones inline blocks in a duplicated layout.

Importantly, Replicate has **no user interface, no configuration and no
permissions**. It is a building block for developers. Higher‑level, editor‑facing
clone tools such as Quick Node Clone and Entity Clone are built on top of this kind
of event‑driven duplication — reach for Replicate directly when you need
code‑level control over a cloning workflow rather than a UI.

This guide is written for a **human**. Because everything here is code‑level, the
sibling [`agent/`](../agent/start.md) docs — which include the service methods and
event examples — are the most useful reference; this page is the plain‑language
orientation.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Replicate has no admin pages, no settings form and no permissions. It
exists purely to be called from code.

## How to use it

Everything goes through one service, `replicate.replicator`. In code:

```php
/** @var \Drupal\replicate\Replicator $replicator */
$replicator = \Drupal::service('replicate.replicator');

// Clone WITHOUT saving — returns an unsaved duplicate you can adjust:
$clone = $replicator->cloneEntity($entity);
$clone = $replicator->cloneByEntityId('node', 1);   // loads, then clones

// Clone AND save in one call — returns the saved duplicate:
$clone = $replicator->replicateEntity($entity);
$clone = $replicator->replicateByEntityId('node', 1);
```

To shape how the clone comes out, register an event subscriber. For example, to
append " [clone]" to a duplicated node's title and unpublish it, subscribe to the
`replicate__alter` event; to control how a particular field type is copied (deep vs
shallow references), subscribe to that field type's
`replicate__entity_field__{field_type}` event. The full event list, service methods
and worked examples are in the sibling [`agent/`](../agent/start.md) docs.
