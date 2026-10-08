# Configuration

Media Field Gallery is configured from a single settings page — there is no need to
edit each View or write any code. You tell the module which media field should be
rendered as a gallery, and on which View path(s) that gallery should appear.

## Before you start

Make sure the content type whose media you want to display already has a **media
reference field** (Entity Reference → Media), and that you have a **View** listing
that content. The gallery is applied to that field within those View pages.

## Open the settings form

1. Log in as a user with permission to administer the module's configuration.
2. Go to **Configuration → Media → Media Field Gallery**, or navigate directly to
   `/admin/config/media/mediafield-gallery`.

## Choose the media field

- **Media field** — select the media reference field you want the gallery layout
  applied to. This is the field whose referenced media items (images, video, audio,
  PDF, DOCX, and so on) will be rendered as the responsive gallery grid, showing
  the first four items with a **"+X more"** overlay for any extras.

## Set the View path(s)

- **Views path(s)** — enter the URL path(s) of the View(s) where the gallery should
  appear, for example `/posts` or `/gallery`. You can specify one or more paths.
- **Leave it blank** to apply the gallery layout to **all** Views that use the
  selected field.

## Save and clear the cache

1. Save the settings form.
2. **Clear the Drupal cache** so the gallery layout is picked up correctly — you can
   do this at **Configuration → Development → Performance**
   (`/admin/config/development/performance`) or with `drush cr`.
3. Visit the configured View path. The media field now renders as a responsive
   gallery, and clicking any thumbnail opens the item in a lightbox preview.
