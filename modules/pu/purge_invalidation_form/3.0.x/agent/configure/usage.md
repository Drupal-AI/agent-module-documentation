# Using Purge Invalidation Form

## The form

- Route: `purge_invalidation_form.invalidation_form` → `/admin/config/development/performance/purge-invalidation-form`
  (class `InvalidationForm`, permission `purge_invalidation_form purge invalidation`, `_admin_route: TRUE`).
- **Type** select: options = invalidation types whose id is provided by an **enabled** purger
  (`purge.purgers->getPluginsEnabled()` ∩ each purger's `types`). Common types: `url`, `path`, `tag`,
  `wildcardurl`, `wildcardpath`, `everything`. If no purger is loaded, the form shows a message instead.
- **Items** textarea (AJAX-revealed): shown for every type except `everything`; one expression per line.
  Placeholder is populated from the selected type's `examples`. Required when shown.
- **Purge** submit → calls `InvalidationManager::invalidate($type, $items)`.

## Prerequisites

1. `purge` installed and at least one **purger** enabled (contrib, e.g. a Varnish/CDN purger) — that
   purger determines which types appear.
2. The **Invalidation Form Processor** (`invalidation_form`) must be present in Purge's processors; it is
   `enable_by_default = true`, but if missing the manager throws
   *"Please add the required processor: Invalidation Form Processor"*.

## `InvalidationManager` service (programmatic)

Service id `purge_invalidation_form.invalidation_manager` (also aliased to the interface). Call it to
invalidate without the form/queue:

```php
/** @var \Drupal\purge_invalidation_form\InvalidationManagerInterface $m */
$m = \Drupal::service('purge_invalidation_form.invalidation_manager');
$m->invalidate('url', ['https://example.com/foo', 'https://example.com/bar']);
$m->invalidate('tag', 'node:123');   // string or array accepted
$m->invalidate('everything');        // no expressions
```

Behaviour: fetches the `invalidation_form` processor, builds one invalidation object per expression via
`purge.invalidation.factory`, then `purge.purgers->invalidate($processor, $invalidations)` — synchronous,
no queue. Throws `\Exception` if the type is unsupported (no purger for it) or if any invalidation ends in
a non-`SUCCEEDED` state (the message lists the failed type/expression/state). The form catches these and
shows them as error messages; successes are logged to the `purge_invalidation_form` logger channel.

## Processor plugin

`Drupal\purge_invalidation_form\Plugin\Purge\Processor\FormInvalidateProcessor` — id `invalidation_form`,
an empty `ProcessorBase` subclass. Its only role is to be the authorising processor passed to
`purgers->invalidate()`; it has no config form.
