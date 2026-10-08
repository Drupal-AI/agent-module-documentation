# Configuration

Layout Builder Modal works the moment you enable it — this settings form is purely
for tuning the size and appearance of the dialog. There is nothing to configure
per block or per layout.

## Open the settings form

1. Log in as a user with the **Administer layout builder modal** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Layout Builder Modal**, or navigate
   directly to `/admin/config/user-interface/layout-builder-modal`.

## Settings, field by field

- **Modal width** — the width of the dialog, given as a pixel value (for example
  `800`). Widen it if your block forms feel cramped.
- **Modal height** — the height of the dialog. Use a pixel value for a fixed
  height, or `auto` to let it size to its content.
- **Auto‑resize** — when enabled, the dialog resizes to fit its content rather than
  staying a fixed size. Handy when block forms vary a lot in length.
- **Theme** — which theme renders the block form *inside* the modal: the active
  **front‑end theme** (so you preview your theme's styles while editing) or the
  **admin theme** (for a consistent administrative look).

## Save

Click **Save configuration**. The new dialog dimensions apply the next time an
editor opens an add‑ or configure‑block form in Layout Builder. Because these are
stored as configuration, they export and deploy between environments like any
other config.
