# Configuration

Font Icon Picker's settings tell the module **which icon font to build the picker
from**. This is the step that makes the bring-your-own-font approach work — you
supply the font's stylesheet and class prefix, and the picker is generated from
them.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Font Icon Picker**, or navigate
   directly to `/admin/config/user-interface/font-iconpicker`.

## The settings

- **Stylesheet path** — the path to your icon font's CSS file. This is the
  stylesheet that defines the icon classes (and pulls in the font files). The
  module reads it to discover the available icons and present them in the picker.
- **Icon class prefix** — the common prefix your font's icon classes share (for
  example the prefix that precedes each individual icon name). The module uses
  this to identify which classes in the stylesheet are icons.
- **Theme** — the fontIconPicker library ships several visual themes for the
  picker widget. Pick the one that best matches your site so the picker looks at
  home in the admin UI.

## Save

Click **Save configuration**. The picker is now driven by your font.

## Next: add a field

With the font configured, add the icon field where you need it:

1. Go to a content type's **Manage fields** (**Structure → Content types →
   *(type)* → Manage fields**).
2. Add a new field of type **Font Icon Picker**.
3. On **Manage form display**, the field uses the visual icon picker widget; on
   **Manage display**, the chosen icon renders through the module's Twig template
   (`font-icon.html.twig`), which you can override in your theme.

> **Tip:** The quality of the picker — its icon labels and grouping — depends on
> your font project's metadata. If icons appear without good names or grouping,
> improving the font's manifest is what fixes it.
