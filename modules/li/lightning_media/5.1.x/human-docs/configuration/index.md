# Configuration

Lightning Media works well out of the box. Its dedicated settings form is small —
just two checkboxes — and most of the day‑to‑day "configuration" is really the
per‑item *Show in media library* switch and the standard core media type, view mode
and display settings.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Media → Lightning Media**, or navigate directly to
   `/admin/config/system/lightning/media`.

You'll find two checkboxes.

### Show revision UI on media forms

When ticked, media add/edit forms gain core's revision controls (a *Create new
revision* checkbox and a revision log). Turn this on for compliance‑driven or
editorial workflows where you need a history of media changes. (Because this toggle
changes the media entity type definition, the form clears cached definitions for
you when you save; if you ever change it from code, run `drush cr` afterwards.)

### Allow users to choose how to display embedded media

This applies when you embed media in rich‑text (CKEditor) via Entity Embed. When
**on**, editors get to choose a display for the media they embed. When **off**, the
"choose a display" step is skipped and the media source's preferred display is used
automatically — handy if you want a consistent look and fewer decisions for editors.

Save with **Save configuration**.

You can also read or set these from Drush:

```bash
drush config:get lightning_media.settings
drush config:set lightning_media.settings revision_ui true -y
drush config:set lightning_media.settings entity_embed.choose_display true -y
```

## The "Show in media library" switch

Every media type created while Lightning Media is enabled gets a boolean field,
**Show in media library** (`field_media_in_library`), with a checkbox on the media
form. It defaults to **on**. Untick it on a given item to keep a working file out of
the media library grid while still keeping the media entity around.

To hide an item programmatically:

```bash
drush php:eval '
  $m = \Drupal\media\Entity\Media::load(12);
  $m->set("field_media_in_library", FALSE)->save();
'
```

## Image widget options

If you use image fields, Lightning Media adds two extra options to the standard core
image widget, configured on the field's **Manage form display** (via the widget's
settings gear):

- **Show links to uploaded files** — whether the widget links to the uploaded file.
- **Show Remove button** — whether the widget shows its *Remove* button.

Both default to on.

## What else the module configures for you

Enabling the base module (and its submodules) installs a range of standard config
you manage in the usual core places:

- Two extra media **view modes**, *Embedded* and *Thumbnail*, used for in‑body
  embeds and library grids (under *Structure → Display modes → View modes*).
- Optionally, a `rich_text` text format and editor (when CKEditor is present), a
  Pathauto pattern `media/<bundle>/<id>` (when Pathauto is present), and the
  *Media creator* / *Media manager* roles (when Lightning Roles is present).

The exact list of shipped config, the two Entity Browser widgets, and how to check
what actually landed on your site are documented in the
[`agent/`](../agent/start.md) reference.
