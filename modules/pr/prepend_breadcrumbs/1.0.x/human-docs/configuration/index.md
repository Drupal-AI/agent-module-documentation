# Configuration

Prepend Breadcrumbs has a single job, so its configuration is short: you tell it
which item (or items) should lead every breadcrumb trail.

## Open the settings form

1. Log in as a user with permission to administer the module (an administrator by
   default).
2. Go to **Configuration → User interface → Prepend Breadcrumbs**.

## Set the leading breadcrumbs

On the form you define the leading breadcrumb item(s) — the entry that should
appear at the **start** of the trail on every page, such as a "Home" or section
root link. The form supports setting these leading breadcrumbs in **two
languages**, so a bilingual site can present the correct label to each audience.

Once saved, the configured item(s) are prepended to the breadcrumb trail that Menu
Breadcrumb generates from your menu structure, giving every page a consistent
navigation root.

## Save

Click **Save configuration**, then clear caches (`drush cr`) if the change does not
appear immediately, and check a few pages to confirm the leading breadcrumb shows
where you expect.
