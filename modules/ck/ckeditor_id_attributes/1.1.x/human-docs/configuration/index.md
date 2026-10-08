# Configuration

There is no standalone settings page. You enable and configure ID Attributes **per
text format**, on any format that uses CKEditor 5.

## Add the button to a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and click **Configure** on a format that uses
   **CKEditor 5**.
2. In the **Toolbar configuration**, drag the **ID Attributes** button from
   *Available buttons* into the *Active toolbar*.
3. A plugin settings section titled **ID Attributes** now appears below the
   toolbar.
4. **Save** the format.

Editors using this format will now see the ID Attributes button and can set an
`id` on the selected element.

## The "Show element IDs in the editor" option

In the **ID Attributes** settings section there is one checkbox:

- **Show element IDs in the editor** (off by default) — when ticked, each element's
  id is displayed as a small label above it **in the editing view only**. It's an
  authoring aid to help editors see and verify their anchors while writing; it does
  **not** alter the saved markup in any way. Leave it off if you'd rather keep the
  editing canvas clean.

## Important: allow the `id` attribute in HTML filtering

The button doesn't just add a UI control — it also **grants the `id` attribute** on
the elements the format already permits. What that means depends on the format:

- On a **restricted format** (e.g. "Limited HTML" with *"Limit allowed HTML tags"*
  enabled), adding this button extends the allowed-tags list to permit `id` on those
  tags. Check the format's filter settings to confirm `id` is allowed on the
  elements where editors will use it.
- On a **Full HTML**-style format with no tag restriction, `id` is already
  unrestricted, so there's nothing extra to do.

If in doubt, save the format and test: add an id to a heading in a piece of content
and confirm it survives in the saved output.
