# Setup & configuration — Varnish Image Purge

## Enable

```
drush en varnish_image_purge -y
```

Depends on `varnish_purger` and `purge`. It reuses hostname/port from your existing
`varnish` purger settings entities (found via a `LIKE 'varnish_purger.settings%'` config
query), so add and configure a `varnish` purger first (see the parent module's
configure/setup.md).

## Config form

- **Route:** `varnish_image_purge.configuration` (verified) —
  `/admin/config/development/varnish_image_purge`
- **Permission:** `administer site configuration`
- **Menu:** under Configuration → Development; also a local task on the Performance settings.
- Form (`VarnishImagePurgeConfiguration`, a `ConfigFormBase`) lists every **content entity
  type** with a checkboxes group of its bundles. Tick the bundles that should trigger image
  purging on update.
- **If you select nothing, ALL bundles of ALL content entity types are purged** (the
  default). Only `image`-type fields are purged.

## Config object

Stored in `varnish_image_purge.configuration`:

```yaml
entity_types:
  node:
    - article
    - page
  media:
    - image
```

Schema: `entity_types` is a `sequence` (keyed by entity type id) of `sequence`s of bundle-id
strings.

## Required Varnish VCL (URIBAN)

The module sends the **`URIBAN`** HTTP method for each image-style derivative URL. Your
Varnish must handle it — example from the module help:

```vcl
if (req.method == "URIBAN") {
  ban("req.http.host == " + req.http.host + " && req.url == " + req.url);
  # Throw a synthetic page so the request won't go to the backend.
  return (synth(200, "Ban added."));
}
```

## Behaviour

On `hook_entity_update()`: if the entity's bundle isn't selected (and a selection exists) it
returns early; otherwise it loads all image styles, builds each derivative URL for every
image field on the entity, and fires concurrent `URIBAN` requests (Guzzle `Pool`,
concurrency 10 = `VarnishPurger::VARNISH_PURGE_CONCURRENCY`). Non-fieldable entities and
entities with no image fields are skipped.
