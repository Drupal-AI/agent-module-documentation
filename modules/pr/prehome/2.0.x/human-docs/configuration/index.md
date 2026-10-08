# Configuration

Setting up Prehome has three parts: shaping the prehome entity, creating the
content that fills it, and telling the module when to display it. You need the
module's administrative permissions (or the *Administer site configuration*
permission) to work through these.

## 1. Shape the prehome entity

Go to **Structure → Prehome → Settings**
(`/admin/structure/prehome/settings`). The prehome is a full Drupal entity, so
this is where you:

- **Add fields** — out of the box the prehome has a single WYSIWYG (formatted
  text) field. Add whatever else your splash needs: an image or media field, a
  plain-text heading, a call-to-action link, and so on.
- **Arrange the form** — order the fields on the editing form so authoring a
  prehome is comfortable.
- **Configure the display** — decide how those fields render when the prehome is
  shown.

## 2. Author a prehome

Go to **Content → Prehome** (`/admin/structure/prehome`) and create at least one
prehome item, filling in the fields you defined above. This is the actual splash
content your visitors will see.

## 3. Configure when it shows

Go to **Configuration → Prehome** (`/admin/config/prehome/settings`). This is the
`prehome.settings_form` — the display settings that govern the pre-home behaviour:
which pages trigger it and how often a visitor sees it before being allowed
through to the homepage. The frequency is tracked with the
`prehome_display_count` cookie, so remember to allow that cookie in any consent
module you run (see [Installation](../installation/index.md)).

## Theming the prehome (optional)

If you want to change how the prehome renders beyond the display settings, you can
override its template. Drupal looks for, in order of specificity:

- `prehome--[entity_id]--[view_mode].html.twig`
- `prehome--[view_mode].html.twig`
- `prehome.html.twig`

You can also implement `hook_preprocess_prehome()` in a theme or module to adjust
the variables passed to those templates.

## Save

Save each form as you go, and clear caches (`drush cr`) if a change to fields or
templates does not appear immediately.
