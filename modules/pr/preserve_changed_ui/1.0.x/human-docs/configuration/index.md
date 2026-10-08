# Configuration

The settings form controls the module's **default behaviour** and where the
checkbox shows up. You need the **`administer preserve_changed_ui configuration`**
permission to reach it.

## Open the settings form

1. Log in as a user with the **`administer preserve_changed_ui configuration`**
   permission.
2. Go to **Configuration → System → Preserve Changed Timestamp UI**, or navigate
   directly to `/admin/config/system/preserve-changed-ui`.

## Set the default behaviour

On the form you define how the checkbox behaves by default — for example whether it
starts ticked or unticked when an editor opens a node form. This lets you set the
policy that fits your team: opt-in (editors deliberately tick it for minor fixes)
or a stronger default if most of your edits are cosmetic.

## Enable the checkbox on the content types you want

The checkbox is not forced onto every node form. After setting the defaults here,
make sure the field is **enabled on the node bundle(s)** you want to use it on, so
it appears on those content types' edit forms and not others.

## How editors then use it

Once configured, a user who holds the **`preserve_changed_ui allow preserve changed
time`** permission will see a checkbox at the bottom of the node edit form. Ticking
it before saving preserves the "Last saved" timestamp for that change — ideal for
typo fixes and other minor edits you do not want to surface as a "new" update.

## A word of caution

Preserving `changed` hides the edit from every listing, feed, sitemap `lastmod`,
and search re-index decision that relies on that field. Keep the "allow preserve
changed time" permission restricted to trusted editors, and treat the feature as a
deliberate editorial tool rather than a default for all saves.

## Save

Click **Save configuration**. Clear caches (`drush cr`) if the checkbox does not
appear on the expected forms right away.
