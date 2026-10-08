# Iconify Field — manual setup guide

**Iconify Field** (`iconify_field`) adds a dedicated **icon field** to Drupal —
a field type, a friendly picker widget, and a formatter — backed by the
[Iconify](https://iconify.design/) icon sets. Iconify aggregates well over a
hundred open icon collections (Material Design Icons, Bootstrap, Font Awesome's
free set, Simple Icons, Tabler, and many more) under a single `collection:name`
naming scheme, such as `mdi:account`.

Storing icons this way is more robust than the common workarounds: a plain text
field holding a CSS class name works until someone mistypes it, and a separate
image field per icon is heavy and inconsistent. A real field type with a picker
gets it right — editors choose from a list, and the chosen icon renders as inline
SVG on the front end with no client‑side JavaScript required.

One implementation detail is worth knowing because it shapes where this module
fits: **icons come from the `iconify/json` PHP package installed by Composer, not
from Iconify's public API**. The module reads the collection JSON from disk and
inlines the SVG into the page, caching the result. That means **no runtime request
to any third‑party host** — a real win for privacy, offline/air‑gapped
environments, and strict content‑security policies. The trade‑off is that the icon
data is a sizeable Composer dependency, and updating the icon sets is a Composer
operation rather than something you do in the UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (which pulls in the icon data) and enable it, plus the optional CKEditor
   submodule.

This module has **no central settings form**. You use it by adding an icon field
to a content type and, optionally, enabling the CKEditor plugin — described below.

## How to use it

- **Add an icon field.** On any content type (or other fieldable entity), add a
  field of the **Iconify** field type — for example an "Icon" field on a card or
  service‑listing content type. Editors then use the built‑in **icon picker** to
  choose an icon; you can allow all collections or restrict which collections are
  offered. The formatter renders the selection as inline SVG on the front end.
- **Add icons in body text (CKEditor).** Enable the **Iconify Field CKEditor**
  submodule (`iconify_field_ckeditor`) to give content editors a CKEditor 5 plugin
  for inserting icons directly into rich‑text content.
- **Embed an icon in a Twig template.** For custom theming, the module provides an
  `iconify_field` Twig function — pass a `collection:name` and it renders the
  icon, e.g. `{{ iconify_field('mdi:account') }}`.
- **Reuse the picker in a custom form.** Developers can add the picker as a form
  element (`'#type' => 'iconify_field'`), optionally restricting `#collections`
  and setting a `#default_value`.

If an icon name can't be resolved, the module falls back to rendering the raw name
in a `<span>` rather than erroring, so a typo degrades gracefully.
