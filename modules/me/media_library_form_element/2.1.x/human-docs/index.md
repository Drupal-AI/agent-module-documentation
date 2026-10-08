# Media Library Form Element — manual setup guide

**Media Library Form Element** (`media_library_form_element`) takes Drupal
core's polished "select or add media" experience — the modal media browser you
already know from media reference fields — and makes it available as a reusable
Form API element you can drop into *any* form. Out of the box, core only wires
that widget up to entity reference fields, which makes it awkward to reuse the
same picker on a custom settings form, a block configuration form, or a
multi-step wizard. This module closes that gap.

Once enabled it adds a new form element type, `media_library`, that developers
and site builders can place in a form array. It opens the standard media library
modal, lets people select existing media or upload new items, shows the chosen
items with remove buttons and drag-to-reorder handles for multi-value use, and
returns the selected media IDs when the form is submitted. Because it is built
directly on core's Media Library, it inherits all of that module's access checks
and media-type configuration — you are reusing core, not reinventing it.

The module works the moment you enable it — there is nothing to configure in the
admin UI, and in fact it has no settings page. It is a building block: you get
value from it by *using* the element in a form (see "How to use it" below). It
depends only on core's **Media Library** (`media_library`) module, which Drupal
enables automatically. If you also have the **Webform** module installed, this
module provides a ready-made Webform element so site builders can add a media
picker to a webform without writing any code.

This guide is written for a **human** clicking through the admin UI (and for the
site builder or developer wiring up a form). If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

This module has no configuration page. It surfaces in two ways:

- **In a Webform (no code).** If the Webform module is installed, add a new
  element to your webform and choose the media library element. You can restrict
  which media types are allowed and whether one or many items may be selected,
  then let visitors pick or upload media right in the form.
- **In a custom or module form (a little code).** Add an element with
  `'#type' => 'media_library'` to your form array. Constrain it with
  `#allowed_bundles` (the media types allowed), set `#cardinality` to `1` for a
  single item or `-1` for unlimited, and pass a `#default_value` of existing
  media entity IDs to pre-populate it. On submit the element returns the selected
  media IDs. The exact element properties and return value are documented for
  developers in the sibling [`agent/`](../agent/start.md) docs.
