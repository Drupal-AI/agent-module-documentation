# Configuration

Media Expire has no admin settings page. You enable and tune it **per media
type**, on that type's edit form.

## Step 1 — Make sure the type has a datetime field

The expiry trigger is a datetime field on the media type. If the bundle has no
datetime field, the expire settings will tell you to add one first — do that at
**Structure → Media types → (your type) → Manage fields** before continuing.

## Step 2 — Enable expiry on the media type

Go to **Structure → Media types → (your type) → Edit**
(`/admin/structure/media/manage/<type>`). The module adds an **Expire
configuration** section with three controls:

- **Activate media expire** — the master switch for this media type. (Stored on
  the type as the `enable_expiring` third-party setting.)
- **Expire field** — a select of the non-base **datetime** fields on the bundle.
  Whichever you choose is the date compared against "now" to decide if an item
  has expired. (Stored as `expire_field`.)
- **Fallback \<type\>** — an optional autocomplete to pick a media item **of the
  same type** to show in place of expired items. Leave it empty to show nothing
  for expired media. (Stored as `fallback_media`, referencing the item's UUID.)

Save the media type. Editors can now set the expiry date on each media item when
they create or edit it, then forget about it.

## Step 3 — Let it run (cron) or trigger it manually

The expiry sweep runs automatically **on every cron run**: it finds published
media of each expiring type whose expire date is in the past, unpublishes them,
and clears the expire field value so they aren't reprocessed.

To force a sweep immediately — for example right after changing an expiry date,
or in a deployment/QA script — run the Drush command:

```bash
drush media:expire-check
```

(Aliases: `mec`, `media-expire-check`.) It takes no arguments and does exactly
what cron does.

## What visitors see

When an **unpublished** media item of an expiring type is viewed, the module
replaces its rendered output with the **fallback** media's output (or renders
nothing if no fallback is configured). So an expired hero image or banner
gracefully shows your placeholder instead of a broken or empty spot, in view
modes and in Layout Builder alike. On decoupled sites, a GraphQL data producer
exposes the fallback so your front end can render it too.

## Setting it up with Drush / PHP (optional)

Because the settings are third-party settings on the media type, you can set them
in code:

```php
$type = \Drupal::entityTypeManager()->getStorage('media_type')->load('image');
$type->setThirdPartySetting('media_expire', 'enable_expiring', TRUE);
$type->setThirdPartySetting('media_expire', 'expire_field', 'field_expire_date');
// Optional fallback (store the media UUID):
$fallback = \Drupal::entityTypeManager()->getStorage('media')->load(42);
$type->setThirdPartySetting('media_expire', 'fallback_media', $fallback->uuid());
$type->save();
```
