# Configuration

Druplicon has a single, simple job: upload a custom image and it becomes the
toolbar logo. All of that happens on one settings form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Druplicon**, or navigate directly to
   `/admin/config/druplicon/settings`.

## Upload your logo

The form has a single **managed file** upload field:

1. Click **Choose file** and select the image you want to use as the toolbar
   logo. Accepted file types are **PNG, JPEG/JPG, JPE, WebP, and SVG**.
2. Click **Save configuration**.

Your image is stored as a managed file (kept under the site's public files
directory) and its file id is recorded in the module's configuration. The next
time the admin menu is rendered, Druplicon loads that image, attaches its small
JavaScript library, and swaps the toolbar logo for your picture on the client
side.

If the logo does not change immediately, clear the site caches (**drush cr** or
**Configuration → Development → Performance → Clear all caches**) and reload an
admin page.

## Removing the custom logo

To go back to the default Druplicon, clear the uploaded file on the settings form
and save — or simply disable the module.

## A note on SVG uploads

The upload field accepts **SVG** files, and SVG files can contain embedded
scripts. This form is restricted to users who hold **Administer site
configuration** (trusted administrators), so on a normal single-admin site this
is not a concern. On a site where several people can reach this form, be aware
that whoever uploads the logo could upload a scriptable SVG that is then served
from the public files directory. Only allow trusted roles to reach this page, and
if SVGs worry you, upload a PNG or WebP instead and consider serving the public
files directory with appropriate response headers.
