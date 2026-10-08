# acquia_contenthub_unsubscribe — agent start

**Experimental.** Lets a subscriber disconnect an individual imported entity from further
pushed updates so local edits survive. Requires `acquia_contenthub_subscriber`. No settings
form, permissions, Drush, or config schema.

## How it works
`hook_form_alter` adds a **"Disable auto updating of this entity"** checkbox to entity forms —
but only for entities tracked by `acquia_contenthub_subscriber.tracker`, and it is added with
**`#access => FALSE`** by default. Checking it sets the tracker status to
`SubscriberTracker::AUTO_UPDATE_DISABLED`, so later imports skip that entity.

## To use it you must write code
Expose the field by setting `#access` (e.g. in your own `hook_form_alter` running after this
one, or a permission check) to decide when editors may unsubscribe an entity. It ships as a
building block, not a turnkey UI — hence no configurable surface / solution docs.
