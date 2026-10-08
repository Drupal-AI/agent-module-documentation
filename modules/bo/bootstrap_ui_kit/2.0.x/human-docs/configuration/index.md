# Configuration

Bootstrap UI Kit is configured from its own settings form (the
`bootstrap_ui_kit.settings` route) under **Configuration**.

## Open the settings form

Log in as an administrator and open the **Bootstrap UI Kit** settings form under
**Configuration**. Adjust the options it offers for the kit's components and save.

## Make the theme inheritance work

The kit's value comes from components inheriting your theme's look, and that
depends on the theme as much as on this form:

- Confirm your **theme exposes its design values** as CSS custom properties or
  Bootstrap's SCSS variables. If the theme hard-codes colours in compiled CSS,
  the components have nothing to inherit and will fall back to default styling.
- After enabling and configuring the kit, view a page that uses one of its
  components and check that it picks up the theme's colours, spacing, and
  typography.

## Check accessibility, not just appearance

Because a component library sets behaviour for the whole site at once, review the
markup of the components you rely on: alerts should carry an appropriate role,
badges should stay readable at their size and contrast, and button groups should
be keyboard-navigable. Getting this right here fixes it everywhere the component
is used.

## Save and verify

Click **Save**, then review the front end. If styles do not update, rebuild the
cache (`drush cr`) and reload.
