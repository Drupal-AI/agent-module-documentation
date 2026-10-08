# Configuration

This module has no global settings page. Everything is configured per image field,
on that field's **Manage form display**, through the widget's own settings. This
page walks through that.

## Prepare your crop types first

Cropping in Drupal works with **crop types** (defined by core's Crop module and
used by Image Widget Crop) and the **image styles** that apply them. Before you
configure the widget, make sure the crop types you want to offer already exist —
you'll select from them in the widget settings. Set up Image Widget Crop (and, if
you use it, Focal Point) as you normally would; this module reuses those crop
types and your existing image styles unchanged.

## Choose the widget on an image field

1. Go to **Structure → Content types → *(your content type)* → Manage form
   display** (or the equivalent screen for a media type or other fieldable
   entity).
2. Find the image field you want to use.
3. In its **Widget** column, choose **External Media with Image Widget Crop**.

## Configure the widget

Click the gear/edit icon next to the field to open the widget's settings. The key
option is **which crop types to expose**: tick the crop types you want editors to
be able to define on this field. Only the crop types you select will render in the
crop UI after an image is chosen.

Save the widget settings, then **Save** the Manage form display.

## What editors see

When an editor adds content, the field now offers the External Media picker to
import or upload an image from a third-party source. Once an image is in place,
the crop UI for each enabled crop type appears inline, and the editor can drag out
the crop region for each one. The crop coordinates are stored against the file as
standard Crop entities, so any image style that applies those crops will render
the cropped result everywhere the image is displayed.
