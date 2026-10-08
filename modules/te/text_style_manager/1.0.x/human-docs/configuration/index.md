# Configuration

Text Style Manager is configured from a single settings page, where you set the
text styling for each section of the site. You need the module's own
administration permission (grant it on **People → Permissions**) to open the
form.

## Open the settings form

1. Go to **Configuration → User interface → Text Style Settings**, or navigate
   directly to `/admin/config/user-interface/text-style-settings`.

## Set styles per section

The form lets you customise text styling separately for the site's main
sections:

- **Header**
- **Footer**
- **Main body**

For each section you can adjust the typography — such as font, size, colour and
weight — to suit your design. When you save, the module generates the matching
CSS and injects it into the site, so your changes appear on the front end
without you having to edit the theme's stylesheets.

## Save

Save the form to apply your styles. If a change does not appear immediately, a
cache rebuild (**drush cr**, or *Clear all caches*) ensures the freshly generated
CSS is served.
