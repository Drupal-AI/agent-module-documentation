# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Entity Form Monitor**, or navigate
   directly to `/admin/config/content/entity-form-monitor`.

## The settings

- **Entity types / bundles to monitor** — pick the specific
  entity-type-and-bundle combinations you want watched (for example only Article
  and Page nodes). **Leaving everything unselected monitors all eligible content
  entities** — that's the catch-all default. Only content entities that implement
  `EntityChangedInterface` and are not brand-new get the monitor attached, so
  unsaved entities are never watched.

- **Polling interval (seconds)** — how often the browser checks the server for the
  entity's current changed timestamp. The default is **30** seconds. **Set it to
  0 to disable monitoring** entirely without uninstalling the module — a
  convenient off switch.

## How it behaves

When an editor opens a monitored entity's form, a background poller checks the
server on your chosen interval. If someone else has saved that entity in the
meantime, the editor sees a warning dialog prompting them to reload before they
overwrite the newer changes. Config is cache-aware, so changing these settings
updates which forms carry the monitor.

Behind the scenes the poller calls a `/entity-form-monitor` endpoint that returns
only a changed timestamp, and only for entities the current user is allowed to
update — it checks update access per entity, so the feature doesn't disclose
anything about content the user couldn't already edit.

## Save

Click **Save configuration**. The change takes effect on the next form load.

## Tip

For stronger protection against concurrent edits, you can pair this with a locking
module such as Content Lock (which prevents simultaneous editing) or a merge-based
module such as Conflict (which reconciles changes) — Entity Form Monitor's role is
the early warning, not enforcement.
