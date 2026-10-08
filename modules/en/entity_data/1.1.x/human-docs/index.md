# Entity Data — manual setup guide

**Entity Data** (`entity_data`) is a small **developer API** for storing arbitrary
custom data against any entity. Think of it as core's `user.data` service, but not
limited to users: you can attach a named value to any content entity and read it
back later, without adding a field or changing the entity's schema.

It's the right tool when a module needs to remember a little extra information about
an entity — a flag, a timestamp, a preference — and creating a full field would be
overkill. The data is stored as a key/value record keyed by module, entity, and a
name you choose.

This is a **code‑facing module**: it has no admin UI and nothing to configure. You
use it through the `entity.data` service:

```php
// Set custom data on an entity.
\Drupal::service('entity.data')->set($module_name, $entity_id, $custom_data_name, $entity_type, $value);

// Get custom data for an entity.
\Drupal::service('entity.data')->get($module_name, $entity_id, $custom_data_name, $entity_type);

// Delete custom data for an entity.
\Drupal::service('entity.data')->delete($module_name, $entity_id, $custom_data_name, $entity_type);
```

Because the data it holds is whatever your calling code puts there, **the
sensitivity and access control of that data are your code's responsibility** —
Entity Data itself has no content or access role. It requires **PHP 8.1**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module so its service is available.

There is **no configuration page** — Entity Data is an API used from code, not the
admin UI.

## How to use it

Enable the module, then call the `entity.data` service from your own module code
using the `set()` / `get()` / `delete()` methods shown above. The value you store is
loaded when you ask for it, keyed by the module name, entity, entity type, and the
data name you supply.
