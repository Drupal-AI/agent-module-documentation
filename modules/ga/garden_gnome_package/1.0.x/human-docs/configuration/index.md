# Configuration

Garden Gnome Package has a small site‑wide settings form for defaults, but most of
the setup happens where you add and display the package field.

## Site‑wide settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Media → Garden Gnome Package**, or navigate directly to
   `/admin/config/media/garden_gnome_package`.

Here you set module‑wide defaults such as the **preview icon** shown for a
package that is displayed preview‑only (the icon a visitor clicks to open the full
tour). Adjust it to match your theme, then **Save configuration**.

## Add and display a package field

The real work is on the content type:

1. **Add the field.** Go to **Structure → Content types → *(type)* → Manage
   fields → Add field** and choose the **Garden Gnome Package** field type. Save.
2. **Configure the display.** On the same type's **Manage display**, set the
   field's formatter to the Garden Gnome viewer and choose its display options —
   for example:
   - **Preview only** — show a preview image that opens the full tour on click.
   - **Autoplay** — start the panorama/object movie on page load.
   - **Play button** — show a play control.
   - **Start node/view** — the scene the tour opens on (useful for multi‑scene
     tours).
3. Save the display.

## Security — restrict package uploads

Because uploading a package causes the module to **extract a ZIP archive into the
public (web‑accessible) files directory**, the permission to create or edit package
field values is a sensitive one:

- Grant content‑creation access for entities carrying a package field only to
  **trusted editors**.
- Ensure your web server does **not** execute PHP from the public files directory,
  so an unexpected file inside an archive cannot be run.
- Treat every uploaded package as untrusted input, the same as any archive
  unpacked onto a public path.

## Save

Save both the settings form and the Manage display screen, then upload a test
package to confirm the viewer renders with the options you chose.
