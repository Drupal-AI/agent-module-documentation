# Configuration

Entity Translation Reminder shows nothing until you tell it which content should
trigger the reminder. You do that on its settings page.

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → Regional and language → Entity Translation Reminder**,
   or navigate directly to `/admin/config/regional/entity-translation-reminder`.

## Choose where the reminder appears

The form lets you **enable the reminder per entity type and bundle**, for those
bundles that are configured to be translatable. Tick each entity type and bundle
where you want editors to be reminded — for example the *Article* and *Basic page*
content types on a multilingual site. Bundles that aren't translatable won't be
eligible, since there would be nothing to remind about.

Save the form when you're done.

## What editors will see

Once configured, whenever an editor saves an entity of a chosen bundle that
already has one or more translations, a reminder message appears prompting them to
update those translations so they stay in sync with the change they just made. The
message is informational — it doesn't block saving or change who can edit what.
