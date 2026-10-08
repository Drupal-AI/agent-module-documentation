# Color Picker Field — manual setup guide

**Color Picker Field** (`color_picker_field`) provides a **color-picker field and
widget** for choosing a **text color**, intended for use with a content type's body
(text) field. Editors pick a color from a color-picker widget and the chosen value
is stored on the entity, so the text can be rendered in that color.

It is a small content-editing/field feature that depends only on core **Field**. The
stored value is simply a color, and the module has no content or access role of its
own. As with any user-chosen color that ends up in markup, make sure the value is
output as a **sanitized style value** when it is applied.

There is no site-wide settings page — you add the field through the Field UI and
configure it per bundle. That setup is described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** — the field is set up through the Field UI,
described in "How to use it" below.

## How to use it

1. Go to a content type under **Structure → Content types → *(type)* → Manage
   fields**.
2. **Add field** and choose the **Color Picker** field type; give it a label and
   save.
3. On **Manage form display**, confirm the color-picker widget is used so editors get
   the picker when editing content.
4. On **Manage display**, arrange how the stored text color is applied/shown.
5. Edit content and pick a text color — the value is stored on the entity.
