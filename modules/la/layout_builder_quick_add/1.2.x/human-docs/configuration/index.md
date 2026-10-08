# Configuration

Layout Builder Quick Add works as soon as it is enabled — the direct block picker
replaces the sidebar straight away. The settings form is **optional tuning** for how
that picker presents block types.

## Open the settings form

1. Log in as a user who holds the **Administer Layout Builder Quick Add
   configuration** permission. This permission is *restrict access* and carries a
   security warning, because choosing which blocks are offered is close to choosing
   what can be placed — grant it only to trusted roles.
2. Go to **Configuration → Content authoring → Layout Builder Quick Add**, or
   navigate directly to `/admin/config/content/layout_builder_quick_add`.

## Settings

The form controls how the quick‑add block chooser looks and behaves:

- **Show block descriptions** — display or hide each block type's description text
  when the picker lists the available block types. Showing descriptions helps
  editors who are less familiar with the block catalogue; hiding them makes the
  chooser more compact.
- **Show a message for block types with multiple view modes** — when a block type
  has more than one view mode enabled, the chooser can surface a message so editors
  are aware they will need to make a further choice.

The module also ships theming support for the default admin theme as well as
**Claro** and **Gin**, so the chooser fits your admin theme without extra setup.

## Save

Click **Save configuration**. Your changes take effect immediately — open any
Layout Builder layout, click **Add block**, and the picker reflects your settings.
