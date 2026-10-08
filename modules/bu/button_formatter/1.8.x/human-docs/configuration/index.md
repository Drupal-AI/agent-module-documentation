# Configuration

Button Formatter is configured in two steps: first you define the set of button
styles for the whole site, then you apply the formatter (and pick a style) on
each field you want rendered as a button.

## Step 1 — Define the site's button styles

1. Log in as a user with the **administer button formatter** permission. This
   permission is marked *restrict access* — it controls your site's button style
   vocabulary, so treat it as a design-system control and grant it only to trusted
   administrators.
2. Go to **Configuration → Button Formatter**, or navigate directly to
   `/admin/config/button-formatter`.
3. Define the button styles you want available (for example primary and secondary
   variants that match your design system) and save.

These styles are defined once here and become the choices offered on every field.

## Step 2 — Apply the formatter to a field

1. Go to the **Manage display** screen of the bundle that has the link or file
   field — for a content type that is **Structure → Content types → [type] →
   Manage display**.
2. For the link or file field, choose **Button Formatter** as its format.
3. In the formatter's settings, pick one of the button styles you defined in
   step 1.
4. Save the display.

Because the style choice is stored in the field display configuration, it exports
with `drush config:export` and applies anywhere that display is rendered —
including Views fields rendered through their formatter.

## Overriding the markup

The button is rendered by a single Twig template, `button-link.html.twig`. To
change the markup, override that template in your theme.
