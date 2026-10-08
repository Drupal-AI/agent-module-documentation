# Configuration

Media Remote Image works as soon as it is enabled — the **Remote image** media
type is ready to use immediately. The settings below are for tuning behaviour, the
most notable being whether Drupal generates local thumbnail previews.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Media → Media Remote Image settings**, or navigate
   directly to `/admin/config/media/media-entity-remote-image-settings`.

## Generate thumbnail previews

The key option on this form controls whether Drupal creates **local thumbnail
previews** when a remote‑image media entity is saved. Thumbnails make the media
admin listing and the Media Library much easier to work with, since editors see
the actual image rather than a placeholder.

- **Enable it** if you want those previews and your site can reach the remote
  images. Bear in mind this means the site downloads the remote image server‑side
  when the media is saved, and that generating the thumbnail depends on the remote
  image being reachable and processable by your configured image toolkit.
- **Leave it off** if you would rather the site not store local copies, accepting
  that the admin/library views will show a generic placeholder instead of the
  picture.

Adjust the option to suit your site and click **Save configuration**.

## Display settings live on the field, not here

How a remote image actually renders is controlled per display, not on this global
form. On the Remote image media type's (or your host entity's) **Manage display**
tab, the formatter offers settings for **maximum display width and height**,
**lazy or eager loading**, and whether the image **links** to anything. Set those
where you configure the field's display.

## Let editors enter a name manually (optional)

By default the media type may derive its name automatically. If you want editors
to type a name for each remote image, enable the **Name** field on the Remote
image media type's **Manage form display** page under **Structure → Media types →
Remote image**.

## A reminder on rights and reliability

Because you are embedding images hosted elsewhere, confirm you have the right to
hotlink them — many hosts forbid it or require attribution — and remember that if
the remote URL breaks or moves, the image breaks on your site with no local
fallback. Where you have the rights and reliability matters, hosting the image
yourself is the more robust choice.
