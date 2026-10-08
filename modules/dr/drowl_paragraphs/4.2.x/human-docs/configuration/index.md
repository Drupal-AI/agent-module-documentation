# Configuration

DROWL Paragraphs has one site‑wide settings form. It mainly stores **default
options for slideshow paragraphs** so you set them once centrally instead of
repeating them on every slideshow. Individual paragraphs can still override these
defaults through the per‑paragraph settings field (see "Per‑paragraph settings"
below).

## Open the settings form

1. Log in as a user with the **access drowl_paragraphs settings** permission. This
   permission is flagged as *restrict access*, so grant it only to trusted roles
   (**People → Permissions**).
2. Go to **Configuration → System → DROWL Paragraphs**, or navigate directly to
   `/admin/config/system/drowl-paragraphs`.

The settings are saved into the `drowl_paragraphs.settings` configuration object.

## Slideshow defaults

These control how slideshow / carousel paragraphs behave and look by default:

- **Layout section width** — the default width of the slideshow's layout section.
- **Autoplay** — whether slides advance automatically.
- **Auto height** — whether the slideshow adjusts its height to the current slide.
- **Navigation arrows** — show or hide the previous/next arrows.
- **Navigation dots** — show or hide the pager dots.
- **Infinite** — whether the slideshow loops back to the start after the last
  slide.
- **Center mode** — whether the active slide is centred (with neighbours peeking
  in).
- **Controls outside** — whether the arrows/dots sit outside the slideshow rather
  than overlaid on it.
- **Visible elements per breakpoint** — how many slides are visible at once at each
  responsive size: **small** (`visible_elements_sm`), **medium**
  (`visible_elements_md`), and **large** (`visible_elements_lg`).

Set these to the values that suit most of your slideshows; you can still deviate on
a case‑by‑case basis with the per‑paragraph settings field.

## Per‑paragraph settings

The base module also provides a field type, **DROWL Paragraph Settings**
(`DrowlParagraphsSettingsItem`), with its own widget and formatter. Add this field
to a paragraph type under **Structure → Paragraphs types → *(type)* → Manage
fields**, and each paragraph instance can then carry its own display settings that
supplement or override the global defaults above.

## Save

Click **Save configuration** at the bottom of the form. New slideshow paragraphs
will pick up the updated defaults.
