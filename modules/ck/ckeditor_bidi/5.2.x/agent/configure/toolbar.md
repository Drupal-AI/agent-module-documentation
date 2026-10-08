<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure CKEditor BiDi Buttons

There is **no module settings page**. All configuration is per text format, on the CKEditor 5
editor form.

## Add the direction button (via the UI)

1. Go to *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`).
2. Configure a format whose text editor is **CKEditor 5**.
3. In "Toolbar configuration", drag the **Direction** button from Available into Active.
4. Save.

## Where it is stored

The button and its setting live on the format's `editor` config entity
(`editor.editor.<format>`):

```yaml
# editor.editor.full_html
settings:
  toolbar:
    items:
      - bold
      - direction          # <-- the BiDi button
  plugins:
    ckeditor_bidi_ckeditor5:
      switch_only: false    # the only setting
```

## The `switch_only` setting

Schema: `ckeditor5.plugin.ckeditor_bidi_ckeditor5` → `switch_only` (boolean, default `false`).
Label: **"Never remove direction, only switch"**. It appears as a checkbox under the plugin's
settings once the Direction button is in the toolbar.

- **off (default):** clicking a direction button that matches the editor's own default
  direction *removes* the `dir` attribute (cleaner HTML, but you cannot force an explicit
  direction — content may inherit the wrong direction when shown in a different-direction
  context).
- **on:** the buttons always set an explicit `dir="ltr"`/`dir="rtl"` and never strip it —
  use this when content is viewed across mixed LTR/RTL contexts (e.g. an English quote that
  must stay LTR on an Arabic page, or email clients that default to LTR).

## Set it with drush / config

```bash
# Add the button + enable switch_only on the full_html format
drush php:eval '
  use Drupal\editor\Entity\Editor;
  $ed = Editor::load("full_html");
  $s = $ed->getSettings();
  if (!in_array("direction", $s["toolbar"]["items"], TRUE)) { $s["toolbar"]["items"][] = "direction"; }
  $s["plugins"]["ckeditor_bidi_ckeditor5"]["switch_only"] = TRUE;
  $ed->setSettings($s)->save();'

# Read it back
drush config:get editor.editor.full_html settings
```

Note the plugin only takes effect when the format's editor is `ckeditor5` and the `direction`
item is present in the toolbar; the `switch_only` value is inert without the button.
