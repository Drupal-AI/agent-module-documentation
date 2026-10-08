# Radioactivity — field settings, decay, and storage backends

No global admin page. Configuration is (1) per-field storage settings, (2) the emitter
formatter's energy, and (3) the `radioactivity.storage` config object.

## Field storage settings (schema `field.storage_settings.radioactivity[_reference]`)

Set on *Manage fields → the field → storage settings*.

| Setting | Default | Meaning |
|---|---|---|
| `profile` | `decay` | `count` (energy +1 per view, never decays), `linear` (increase by emission, −1/second), `decay` (increase by emission, −50% per half-life). |
| `granularity` | `900` (15 min) | Seconds energy is held before decay is applied; batches cron writes. `0` = decay every cron run. |
| `halflife` | `43200` (12 h) | Half-life in seconds for the `decay` profile. |
| `cutoff` | `1` | When computed energy ≤ cutoff it is set to 0 and the below-cutoff event fires. |
| `target_type` | `radioactivity` | (reference field only) fixed to the `radioactivity` entity; hidden in the form. |

`radioactivity_reference` also has field-level `default_energy` (default `0`).

## Emitter formatter settings (schema `field.formatter.settings.radioactivity_emitter`)

Set on *Manage display*.

| Setting | Default | Meaning |
|---|---|---|
| `energy` | `10` | Energy emitted each time this display renders the field. |
| `display` | `false` | Also render the current energy value (otherwise the field only emits, no visible markup). |
| `decimals` | `0` | Decimals shown when `display` is on. |

## Storage config object `radioactivity.storage`

No `config/install` default ships; absent `type` falls back to `default`. Set with Drush:

```bash
ddev drush config:set radioactivity.storage type default -y
# remote collector:
ddev drush config:set radioactivity.storage type rest_remote -y
ddev drush config:set radioactivity.storage endpoint 'https://collector.example.com/endpoints/file/rest.php' -y
```

| `type` | Backend | Emit endpoint injected to the page |
|---|---|---|
| `default` | `DefaultIncidentStorage` → DB table `radioactivity_incident` | `<base_url>/radioactivity/emit` (Drupal route, permission `access content`). |
| `rest_local` | `RestIncidentStorage`, endpoint = local module path | `<base_url>/<module_path>/endpoints/file/rest.php`. |
| `rest_remote` | `RestIncidentStorage`, endpoint = `radioactivity.storage.endpoint` | the configured remote URL. |

`StorageFactory::getConfiguredStorage()` reads `type`; `injectSettings()` puts
`drupalSettings.radioactivity.{type,endpoint}` on every page so `triggers.js` knows where to POST.
The REST backends exist for sites where the Drupal route can't serve the emit (e.g. full-page cache
in front of Drupal, or a decoupled front end).

## Decay / cron

`hook_cron()` → `RadioactivityProcessor`:
- `processIncidents()` — pulls stored incidents, clears storage, and queues
  `radioactivity_incidents` workers that add each incident's energy to the (referenced) entity
  without bumping the timestamp or creating a new revision.
- `processDecay()` — for `linear`/`decay` fields whose granularity threshold has passed, queues
  `radioactivity_decay` workers that recompute energy; unpublished entities are skipped; energy at
  or below `cutoff` is zeroed and dispatches `EnergyBelowCutoffEvent` (+ Rules event
  `radioactivity.field_cutoff`).
