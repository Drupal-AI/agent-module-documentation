# Migrate Default If No Stored Value — manual setup guide

**Migrate Default If No Stored Value** (`migrate_default_if_no_stored_value`)
provides a single Migrate **process plugin**, `default_if_no_stored_value`, that
applies a field's default value **only when the destination doesn't already have
one**. On the first import it fills the field with your default; on later re‑runs
with the update flag it leaves any existing value alone.

The problem it solves is a real annoyance with core's `default_value`: that
approach re‑applies the default **every time** you run a migration with updates,
clobbering values that may have changed on the destination. The team at OHSU
couldn't find a way to make core Migrate (or Migrate Plus) apply a default only
once, so they built this plugin. It's ideal for "seed a sensible default the first
time, then never touch it again" fields.

There is **no settings form** — the plugin is configured inside your migration
YAML. It depends only on core's **Migrate** module and runs on **Drupal 9, 10, and
11**. (The project is *minimally maintained*, in maintenance‑fixes‑only mode.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — you configure the plugin in
your migration YAML, as shown below.

## How to use it

Add the plugin to the process pipeline for the field you want to seed:

```yaml
process:
  field_prof_provider_type:
    plugin: default_if_no_stored_value
    default_value: Specialist
    entity_type: node
    bundle: profile
```

The configuration keys are:

- **`default_value`** — the value to assign when the destination field is
  currently empty.
- **`entity_type`** — the destination entity type. Currently only **`node`** is
  supported.
- **`bundle`** — the bundle (content type) to load.

On the first migration the field receives the default; on subsequent update runs,
any value already stored on the destination is preserved.
