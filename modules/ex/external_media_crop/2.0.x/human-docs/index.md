# External Media Crop — manual setup guide

**External Media Crop** (`external_media_crop`) is the glue between two other
modules: [External Media](https://www.drupal.org/project/external_media), which
lets editors pull files in from cloud services, and
[Image Widget Crop](https://www.drupal.org/project/image_widget_crop), which lets
them draw crop regions on an image. On its own each module does half the job;
together, through this bridge, an editor can import an image from a third-party
source *and* crop it — all in one widget, without a separate step.

It provides a single image-field widget, **External Media with Image Widget
Crop**. Choose it on an image field and, after the editor selects or uploads an
image, the crop types you've enabled render right there in the form. The crop
coordinates are saved against the file, and everything downstream — image styles,
Crop entities — is standard Drupal, so your existing image styles keep working.

There is nothing to configure globally: this module has no admin page, no
permissions, and no server endpoints of its own. It's a pure editing-UI
enhancement, set up entirely through a field's form-display widget settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its two required modules.
2. [Configuration](configuration/index.md) — choose the widget on an image field
   and pick which crop types appear.

## Where it lives in the admin menu

External Media Crop adds no admin page of its own. You set it up on an entity's
**Manage form display** (Structure → Content types → *(bundle)* → Manage form
display), by choosing the **External Media with Image Widget Crop** widget on an
image field. The crop types themselves are defined in Image Widget Crop / core's
Crop module.
