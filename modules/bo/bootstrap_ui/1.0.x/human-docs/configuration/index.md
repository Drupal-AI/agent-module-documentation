# Configuration

Bootstrap UI is configured from a single settings form (the `bootstrap.settings`
route) under **Configuration**. This is where you turn the Bootstrap framework on
and shape how it behaves, without touching theme files.

## Permission

The module provides its own permission for managing these settings. Before you
start, go to **People → Permissions** (`/admin/people/permissions`) and give that
permission to the role that should administer Bootstrap — typically a site
administrator. Only users with it can open the settings form.

## Open the settings form

Log in as a user with that permission and open the **Bootstrap UI** settings form
under **Configuration**. The form lets you configure Bootstrap in three broad
areas:

- **Components** — enable and customise the Bootstrap components you want the site
  to use.
- **Variables** — adjust Bootstrap's variables (such as colours, spacing, and
  typography values) so the framework matches your design.
- **Plugins** — enable the Bootstrap JavaScript plugins you need.

## Save and verify

Click **Save** to store your configuration. Because this affects front-end
styling, review a few pages afterwards to confirm the components and variables you
changed look the way you intended. If styles do not appear to update, rebuild the
cache (`drush cr`) and reload.
