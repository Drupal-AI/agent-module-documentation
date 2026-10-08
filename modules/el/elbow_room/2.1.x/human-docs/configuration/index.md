# Configuration

Elbow room is a small editing-UX module, so there's little to set up: grant a
permission, then adjust the options on its settings form.

## Grant the permission

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant **Administer elbow room settings** to the roles that should be able to
   manage the module's behaviour (typically administrators, and any editorial roles
   you want to give control of the sidebar toggle to).

This permission gates the settings form; core field access still governs what any
user may actually edit and save on a node form, and the module never changes that.

## Open the settings form

1. Log in as a user with the **Administer elbow room settings** permission.
2. Go to **Configuration → Content authoring → Elbow room**
   (`/admin/config/content/elbow-room`, route `elbow_room.settings`).

## The options

The admin form controls how the sidebar toggle behaves on node add/edit forms and
stores its options in the module's own configuration. Adjust the options to suit how
you want the sidebar to appear by default, then **Save**.

Because the toggle is a display preference, the chosen state is remembered
client-side (by a small state script) between forms — hiding the sidebar only widens
the editing area; it never hides fields from being saved.

## Uninstalling

Uninstalling the module removes its configuration and assets only — there's no data
migration and nothing to clean up, so it's safe to enable or disable at will.
