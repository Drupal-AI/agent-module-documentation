# Configuration

Moderation Sidebar works as soon as it is enabled and the **Use moderation
sidebar** permission is granted — there is nothing you *must* configure. The one
settings form it provides is entirely optional and does just one thing: it lets
you hide specific workflow transitions from the sidebar so editors see a shorter,
tidier list of actions.

## Open the settings form

1. Log in as a user with the **Administer moderation sidebar** permission.
2. Go to **Configuration → User interface → Moderation Sidebar**, or navigate
   directly to `/admin/config/user-interface/moderation-sidebar`.

## Disabling transitions per workflow

The form lists each **workflow** you have defined in Content Moderation. Under
each workflow is a set of checkboxes, one for every transition that workflow
allows (for example *Create New Draft*, *Publish*, *Archive*).

- **Tick a transition** to *disable* it — it will no longer appear as a quick
  button in the sidebar for that workflow.
- **Leave it unticked** to keep it available.

This only affects what the sidebar offers. It does not change the workflow itself,
and it does not grant anyone new abilities: the sidebar already only shows
transitions the current user is permitted to make, so this form is for trimming
that list further (for instance, hiding an *Archive* action you would rather
editors performed from the full edit form).

## Save

Click **Save configuration**. Your changes apply immediately — reopen the sidebar
on a moderated item and the disabled transitions will be gone.

Because these settings are stored as configuration
(`moderation_sidebar.settings`), you can move them between environments with
`drush config:export` and `drush config:import` like any other configuration.
