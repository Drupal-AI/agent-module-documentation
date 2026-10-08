# Configuration

Epub Viewer works as soon as you apply its field formatter — this settings form is
about **how the in-browser reader looks**. If you never open it, the reader still
works with its default colours.

## Open the settings form

1. Log in as a user with the **Access administration pages** permission.
2. Go to **Configuration → EPUB → Epub settings**, or navigate directly to
   `/admin/config/epub/epubsettings`.

## The settings

The form controls the reader's colour scheme and one toggle. If you have the
**jQuery Colorpicker** module enabled, each colour field is a colour picker;
otherwise it's a plain text box where you type a colour value (for example a hex
code such as `#333333`).

- **Background colour** — the background colour of the reader surface behind the
  ebook page.
- **Icon colour** — the colour of the reader's control icons (navigation and
  toolbar).
- **Font colour** — the colour used for the reader's text and labels.
- **Download icon visibility** — a toggle for whether a download icon is shown in
  the reader, letting readers save the `.epub` from within the viewer. Turn it off
  if you want readers to view but not download from the reader UI.

## Save

Click **Save configuration**. Reload any page that opens the reader to see the new
appearance take effect.
