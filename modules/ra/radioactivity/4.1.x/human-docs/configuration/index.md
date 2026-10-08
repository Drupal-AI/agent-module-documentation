# Configuration

Radioactivity has no single settings page. Instead you configure it in three
places: the **field storage settings** (how energy behaves), the **Emitter
formatter** (how much energy a view emits), and a **storage config object** (how
view events are collected). This page walks through each, then explains how cron
processes and decays the energy.

## Step 1 — add the field

On the content type (or other entity bundle) you want to track:

1. Go to **Structure → Content types → *your type* → Manage fields → Add field**.
2. Choose **Radioactivity reference** — this is the recommended field type. It
   references a small dedicated entity that holds the energy value, so recording a
   view never creates a new revision of your node.

   *(There is also an older plain **Radioactivity** field that stores energy inline
   on the entity, but it is deprecated — don't use it for new sites.)*

## Step 2 — set the field's storage settings

On the field's **storage settings**, choose how energy behaves:

| Setting | Default | What it does |
|---------|---------|--------------|
| **Profile** | Decay | **Count** (energy +1 per view, never decays), **Linear** (rises on view, loses 1/second), or **Decay** (rises on view, halves every half‑life). |
| **Granularity** | 900 (15 min) | How many seconds energy is held before decay is applied — this batches cron writes to reduce load. `0` means decay on every cron run. |
| **Half‑life** | 43200 (12 h) | For the *Decay* profile, the number of seconds over which energy halves. |
| **Cutoff** | 1 | When the computed energy falls to or below this, it's set to 0 and the "energy below cutoff" event fires. |

The reference field also has a **default energy** (default `0`) applied to new
items.

## Step 3 — turn on the Emitter formatter

The field only emits energy when it's displayed with the **Emitter** formatter:

1. Go to **Manage display** for the same content type and view mode.
2. Set the Radioactivity field's format to the **Emitter** (there's a reference
   emitter for the reference field).
3. In its settings:

   | Setting | Default | What it does |
   |---------|---------|--------------|
   | **Energy** | 10 | How much energy is emitted each time this display renders the field. You can emit different amounts from different view modes — e.g. more from the full view than the teaser. |
   | **Display** | off | Also show the current energy value on the page (otherwise the field emits invisibly). |
   | **Decimals** | 0 | How many decimals to show when *Display* is on. |

   There's also a display‑only **Value** formatter that shows the current energy
   without emitting anything.

## Step 4 — choose the storage backend

How view events ("incidents") are collected is controlled by the
`radioactivity.storage` config object. There's no install default; if unset it
falls back to `default`. Set it with Drush:

```bash
# The default: a Drupal route + database table.
ddev drush config:set radioactivity.storage type default -y

# Or send events to a remote collector:
ddev drush config:set radioactivity.storage type rest_remote -y
ddev drush config:set radioactivity.storage endpoint 'https://collector.example.com/endpoints/file/rest.php' -y
```

| `type` | Backend | Where events are posted |
|--------|---------|--------------------------|
| **default** | Database table, via the Drupal route | `/radioactivity/emit` (permission `access content`) |
| **rest_local** | Standalone PHP file endpoint on this site | `<module_path>/endpoints/file/rest.php` |
| **rest_remote** | Standalone endpoint at a remote URL | the configured `endpoint` |

The **default** backend works for most sites. The **REST file** backends exist for
cases where the Drupal route can't serve the emit — for example when an aggressive
full‑page cache sits in front of Drupal, or when a decoupled front end sends events
to a remote collector.

> **Note.** View events are cryptographically signed with your site's hash salt, so
> energy values can't be forged.

## How processing and decay work (cron)

Everything is applied on cron, so make sure cron runs regularly:

- **Processing incidents** — pending view events are read from the configured
  storage, cleared, and queued; workers then add each event's energy to the
  (referenced) entity, without bumping its timestamp or creating a new revision.
- **Decay** — for *Linear* and *Decay* fields whose granularity threshold has
  passed, workers recompute the energy. Unpublished entities are skipped. When
  energy reaches or falls below the **cutoff**, it's zeroed and an
  `EnergyBelowCutoffEvent` (plus the Rules event `radioactivity.field_cutoff`) is
  dispatched — useful for automatically un‑featuring content that has cooled off.

## Building a "most popular" view

Radioactivity exposes the energy value to **Views**, so to build a trending list,
create a view of your content and add the Radioactivity energy as a **sort**
(descending) — optionally filtering by it too. Because energy decays over time, the
listing naturally favors recently and frequently viewed content.
