# Configuration

This module has no settings page of its own. You "configure" it by **selecting it
as your site's image toolkit** on Drupal core's image‑toolkit settings page.

## Select FFmpeg as the image toolkit

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Media → Image toolkit**
   (`/admin/config/media/image-toolkit`).
3. Choose **FFmpeg Image Toolkit** from the list of available toolkits.
4. If the form exposes a path to the `ffmpeg` binary, make sure it points at the
   executable installed on your server (see
   [Installation](../installation/index.md)).
5. Click **Save configuration**.

From now on Drupal generates image‑style derivatives through FFmpeg, so animated
GIFs and APNGs are processed the same way still images are. The switch is
site‑wide — every image style uses the selected toolkit.

## Reverting

To stop using it, return to **Configuration → Media → Image toolkit**, select GD
(or another toolkit) again, and save. You can then disable the module if you no
longer need it.
