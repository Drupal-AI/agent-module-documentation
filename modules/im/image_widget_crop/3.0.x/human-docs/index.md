# Image Widget Crop — manual setup guide

**Image Widget Crop** (`image_widget_crop`) adds an interactive image-cropping
widget to your image fields, built on top of Drupal's **Crop API**. The core Image
module lets you upload a picture and apply an image style, but the crop is decided
globally by that style — editors have no say in *how* each image is framed. Image
Widget Crop closes that gap: when an editor uploads an image they get a live
cropping interface (powered by the Cropper JavaScript library) and can draw a crop
region for each configured **crop type** — for example a "16:9 hero" and a "square
thumbnail" from the same upload. Those selections are stored through the Crop API as
`crop` entities tied to the file, and any image style that uses the **Manual crop**
effect then renders using the region the editor chose.

Because it is built on the Crop API, this module **depends on the Crop module**
(`crop`), which is where you define the crop types themselves (their aspect ratios
and limits). If you have not set up Crop yet, start with its
[manual setup guide](../../../crop/2.6.x/human-docs/index.md) — the two modules are
used together. This guide is written for a **human** clicking through the admin UI:
it walks you from installing the module to wiring the widget onto a real image field.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Image Crop Widget settings page](images/settings.png)

## Where it lives in the admin menu

The module's one global settings page sits under **Configuration → Media → Image
Crop Widget** (`/admin/config/media/crop-widget`). The rest of the setup happens on
pages that belong to other systems you already know:

- **Crop types** live under **Configuration → Media → Crop types**
  (`/admin/config/media/crop`), provided by the [Crop module](../../../crop/2.6.x/human-docs/index.md).
- **Image styles** (where you add the *Manual crop* effect) live under
  **Configuration → Media → Image styles** (`/admin/config/media/image-styles`).
- **The widget itself** is switched on per field under a content type's **Manage
  form display** tab (**Structure → Content types → *(your type)* → Manage form
  display**).

## Contents

1. [Installation](installation/index.md) — install Image Widget Crop with Composer
   and enable it along with the Crop dependency.
2. [Configuration](configuration/index.md) — the global widget settings, then the
   full setup flow: create crop types, build image styles that use the *Manual
   crop* effect, and switch an image field to the ImageWidget crop widget.
