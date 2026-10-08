# Term Reference Change — manual setup guide

**Term Reference Change** (`term_reference_change`) is a small, behind‑the‑scenes
API module that finds every entity referencing a taxonomy term and can rewrite
those references from one term to another in bulk. It is the plumbing you reach
for when you want to *merge* two duplicate terms — re‑point everything that used
the old term at the surviving term — without breaking the content that links to
them.

It is important to understand what this module is **not**: it ships no user
interface, no settings page, no admin menu item, no permissions and no Drush
command. On its own, enabling it changes nothing you can see. It exists to be a
shared dependency — either for a contributed "merge terms" module that builds a
UI on top of it, or for your own custom code and Drush scripts. Everything it
does lives behind two services: a *reference finder* (which discovers term
reference fields and lists the entities pointing at a term) and a *migrator*
(which swaps references from a source term to a target term and saves each
changed entity).

Because the work is done directly in code, there is no batch runner, no queue and
no "dry run" mode built in — the calling code owns chunking, progress reporting
and, importantly, deleting the old term afterwards (the module deliberately never
deletes it for you). It depends only on core's **Taxonomy** module and supports
Drupal 10.2 and 11.

This guide is written for a **human** installing and understanding the module. If
you are an AI coding agent — or a developer who just wants the exact service
signatures, return shapes and gotchas — read the sibling
[`agent/`](../agent/start.md) docs instead, which document both services in
detail.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it. There is nothing else to set up.

## Where it lives in the admin menu

Nowhere. Term Reference Change adds no admin pages, no configuration form and no
menu links. After enabling it, the only way to confirm it is present is
`drush pm:list --status=enabled | grep term_reference_change` (or the
*Extend* page).

## How to use it

Term Reference Change is used from code, not from the UI. The two services it
registers are:

- **`term_reference_change.reference_finder`** — discovers every taxonomy term
  reference field on the site and loads every entity (node, media, user, term,
  custom block, paragraph…) that references a given term. Use it to answer "is
  this term still in use, and by how many things?" before offering to delete it.
- **`term_reference_change.migrator`** — its `migrateReference($source, $target)`
  method re‑points every reference to `$source` so it points at `$target`, then
  saves each changed entity through the normal `$entity->save()` path (so all the
  usual hooks and validation run). An optional `$limit` argument restricts the
  work to specific entity types or entity IDs, which is how you drive a staged
  rollout or a chunked batch.

A typical "merge term B into term A" from Drush looks like this:

```bash
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  $source = Term::load(7);
  $target = Term::load(9);
  \Drupal::service("term_reference_change.migrator")->migrateReference($source, $target);
  $source->delete(); // the module will not do this for you
'
```

The full method signatures, the exact meaning of the `$limit` array, how
multi‑value fields are de‑duplicated, and the fields the finder deliberately
skips are all documented in the [`agent/`](../agent/start.md) reference.
