# Configuration

Image 404 Fallback works out of the box with a built-in placeholder, so this page
is **optional**. Configure it only when you want to use your own fallback image in
place of the default.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Media → Image 404 Fallback Settings**, or navigate
   directly to `/admin/config/media/image-404-fallback`.

## Fallback image path

The form has a single main setting: the path to the image to serve when a request
would otherwise 404. You can supply it in either of two ways:

- **An absolute path** — for example `/var/www/html/placeholders/my-fallback.png`.
- **A path relative to the Drupal root** — for example
  `sites/default/files/fallback.png`.

If you **leave the field empty**, the module falls back to its own default image
(`images/placeholder.svg` shipped inside the module). That is a fine choice if you
just want *something* sensible in place of broken icons.

Whichever image you choose, make sure it exists at the path you enter and is
readable by the web server, and pick one of the supported formats (JPG, PNG, GIF,
WebP, SVG, BMP, ICO, or AVIF).

## Save

Click **Save configuration**. The module will begin serving your chosen fallback
for missing images. If a previously cached 404 lingers, clear the cache
(`drush cr`).
