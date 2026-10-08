# External Media Focal Point — manual setup guide

**External Media Focal Point** (`external_media_focal_point`) bridges two modules:
[External Media](https://www.drupal.org/project/external_media), which lets editors
import files from third-party cloud services, and
[Focal Point](https://www.drupal.org/project/focal_point), which lets them mark the
most important point of an image so automatic crops keep it in frame. Put them
together and an editor can pull an image in from an external source *and* set its
focal point, in a single image-field widget.

It provides one image-field widget, **External Media with Focal Point**. After an
image is selected, the editor sees a preview with a draggable focal-point marker;
wherever they place it is stored (as a left/top offset in percent) so that
Focal-Point image styles crop around that spot on every rendering. The widget
mirrors core's image widget behavior — alt/title fields, min/max resolution,
allowed extensions, image validation — and adds the focal-point layer on top.

This module has no admin settings page, permissions, or endpoints of its own. It's
an editing-UI enhancement configured entirely through a field's form-display widget
settings, where you set the preview image style, whether to show a full-preview
link, and a default focal point for new images.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its two required modules.
2. [Configuration](configuration/index.md) — choose the widget and set its preview
   style, preview link, and default focal point.

## Where it lives in the admin menu

There is no admin page for this module. You set it up on an entity's **Manage form
display** (Structure → Content types → *(bundle)* → Manage form display), by
choosing the **External Media with Focal Point** widget on an image field. The
crop type that Focal Point uses is configured in the Focal Point module's own
settings.
