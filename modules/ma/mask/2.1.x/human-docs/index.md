# Mask Field — manual setup guide

**Mask Field** (`mask`) applies an *input mask* to text fields so people type
values in exactly the format you want — a phone number as `(00) 0000-0000`, a
date as `00/00/0000`, a ZIP code, an IP address, and so on. As the visitor types,
the field guides them: literal characters like brackets and dashes appear
automatically, and only characters that fit the pattern are accepted. It is built
on the well-known jQuery Mask Plugin.

There are two ways to use it. The most common is per field: on a content type's
**Manage form display** screen you open the widget settings for a supported text
or telephone field and enter a mask. The second is for developers building custom
forms, who can add a `#mask` property to a Form API element — that side is covered
in the [`agent/`](../agent/start.md) docs.

Out of the box, masking works on core's **Text field** widget
(`string_textfield`) and core's **Telephone** widget (`telephone_default`). Other
modules can register their own widgets, and you can extend the "mask alphabet"
of pattern symbols on the module's settings form.

One important caveat: a mask is **client-side convenience only**. It improves
data entry in the browser but does *not* validate the submitted value on the
server. Someone with JavaScript disabled, or posting directly, can still send an
unmasked value. If a format must be guaranteed, add real field validation as well.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — mask an individual field, plus the
   module-wide settings form (library source and the pattern-symbol table).

## Where it lives in the admin menu

Mask Field has two homes in the admin UI:

- **Per-field masks** live on each bundle's **Manage form display** screen — for
  example **Structure → Content types → Article → Manage form display**
  (`/admin/structure/types/manage/article/form-display`). Click the cog on a
  supported field row to find its **Mask settings**.
- **Module-wide settings** live at **Configuration → Content authoring → Mask
  Field settings** (`/admin/config/content/mask`), where you choose how the
  jQuery Mask library is loaded and manage the pattern symbols.
