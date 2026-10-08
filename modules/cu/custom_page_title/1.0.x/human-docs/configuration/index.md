# Configuration

Custom Page Title does nothing until you tell it which pages should get which
titles. That happens on the module's settings form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Open the **Custom Page Title** settings form under **Configuration** (route
   `custom_page_title.custom_page_title_settings_form`). If you can't find it in
   the menu, your administrator's *Configuration* page lists it.

## Set a custom title

The form works by **matching a page's path alias** and applying the custom title
you supply for it. For each page you want to override:

- Enter the **path** (path alias) of the page whose title you want to change.
- Enter the **custom page title** to display for that page.

When a visitor loads a page whose alias matches one of your entries, the module
replaces the default page title (the browser `<title>` and the on-page H1) with
the custom title you set. Pages you haven't listed keep their normal Drupal
titles.

## Save

Save the form to apply your changes. Reload the target page to confirm the new
title appears. To change or remove an override later, come back to this form and
edit or clear the entry.
