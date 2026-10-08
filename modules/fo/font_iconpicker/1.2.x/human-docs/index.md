# Font Icon Picker — manual setup guide

**Font Icon Picker** (`font_iconpicker`) adds a new field type and form widget
that lets editors **pick an icon visually** from an icon font — but unlike most
icon modules, it does not lock you to Font Awesome or any other bundled set.
Instead you point it at **your own (or any custom) icon font**, and it builds the
picker from that font. It integrates the
[jQuery fontIconPicker](https://fonticonpicker.github.io/) library with Drupal.

The advantage of the bring-your-own-font approach is that content editors choose
from exactly the icons your design system uses, presented as a visual grid rather
than as a hand-typed CSS class (which avoids typos). You configure the module with
the path to your icon font's stylesheet and its icon class prefix, and it does the
rest. The trade-off is that the labels and grouping editors see are only as good as
the font project's own metadata — a font with an incomplete manifest yields a
plainer picker.

Once installed and configured, a new **Font Icon Picker** field type becomes
available to add to any fieldable entity, and the chosen icon renders through a
Twig template you can override. The library provides several themes, which you can
select in the settings form to match your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the
   fontIconPicker JavaScript library.
2. [Configuration](configuration/index.md) — point the module at your icon font's
   stylesheet and prefix, and pick a theme.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Font Icon Picker**
(`/admin/config/user-interface/font-iconpicker`), gated by the *Administer site
configuration* permission. Fields using the new field type are added the usual way
on each content type's **Manage fields**.

## How to use it

1. Install the fontIconPicker library and enable the module (see Installation).
2. On the settings form, enter the path to your icon font's stylesheet and its
   icon class prefix, and pick a picker theme (see Configuration).
3. Go to a content type's **Manage fields**, add a field of type **Font Icon
   Picker**, and save.
4. When editing content, the field shows a visual icon picker driven by your font.
   The chosen icon renders through the module's Twig template on display.
