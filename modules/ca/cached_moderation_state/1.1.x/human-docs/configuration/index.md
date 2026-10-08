# Configuration

There is almost nothing to configure — the field manages itself. The only manual
step is a **one‑time back‑fill** of content that existed before the module was
installed.

## Turning the caching on or off for a content type

You do not add or remove the field yourself. The rule is simply:

- **To cache a bundle's moderation state**, add that bundle to a Content
  Moderation workflow at **Configuration → Workflow → Workflows**
  (`/admin/config/workflow/workflows`). The `cached_moderation_state` field
  appears on it automatically.
- **To stop caching it**, remove the bundle from the workflow. The field is
  removed automatically.

The field is hidden from the Field UI and its direct display is blocked on
purpose — it is meant to be read in code or used in Views, not shown to editors.

## Back-filling existing content

Content created or edited *after* the field exists caches its state automatically.
Content that already existed has an empty cached value until you back‑fill it once.

### Using the form

1. Log in as a user with the **Access cached moderation state update form**
   permission.
2. Go to `/admin/cached-moderation-state/update`.
3. Run the update over the bundles you want. It processes the entities as a batch,
   so large amounts of content won't time out.

The back‑fill updates entities — including their non‑default (pending) revisions —
**without creating new revisions** or firing unwanted side effects.

### Using Drush

```bash
# Back-fill every moderated bundle:
drush cached-moderation-state:update-all

# Back-fill only specific bundles:
drush cached-moderation-state:update node:article,node:page

# Only touch entities whose cached value is still empty (good for resuming):
drush cached-moderation-state:update-all --only-uninitialized --batch-size=50
```

Two more commands help you inspect and repair things:

```bash
# List the bundles currently moderated (and thus carrying the field):
drush cached-moderation-state:list-moderated-bundles

# Re-create/delete the field instances to match the moderated bundles,
# if the automatic sync ever gets out of step:
drush cached-moderation-state:sync-fields
```

## Reading the value

Developers read the cached state as an ordinary field, or use it in Views and
entity queries:

```php
$state = $node->cached_moderation_state->value;    // e.g. 'draft'
$when  = $node->cached_moderation_state->updated;   // timestamp of last cache write
```
