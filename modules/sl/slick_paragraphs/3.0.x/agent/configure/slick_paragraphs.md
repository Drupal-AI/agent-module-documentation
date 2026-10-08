# Render a Paragraphs field as a Slick carousel

Slick Paragraphs has **no admin settings form** (`configure` is null). All setup is done in
**Field UI → Manage display** by choosing one of its formatters on a multi-value Paragraphs
field. Optionsets are created separately in the Slick module.

## The two formatters

Both target the `entity_reference_revisions` field type (Paragraphs) and disable Quick Edit.

| Formatter id | Label | Base class | Where it applies | Notes |
|---|---|---|---|---|
| `slick_paragraphs_vanilla` | Slick Paragraphs Vanilla | `SlickEntityFormatterBase` (slick) | Top-level **and** child Paragraphs fields | Renders each paragraph as-is via its view mode; requires Blazy |
| `slick_paragraphs_media` | Slick Paragraphs Media | `SlickMediaFormatter` (slick) | **Child (second-level) Paragraphs fields only** | Rich slides with a main image/stage plus overlays |

### Applicability (`isApplicable()`)

- **Vanilla:** the field must be multi-value and its `target_type` setting = `paragraph`.
- **Media:** the same, **plus** the host field's target entity type must itself be
  `paragraph` — this excludes the outer host field so the formatter only appears on a
  paragraph-inside-paragraph (child) field, avoiding nested-paragraph complications.

Legacy id `slick_paragraphs` still has a config-schema entry (`@todo remove at 3.x`); use
`slick_paragraphs_vanilla` / `slick_paragraphs_media` on 3.x.

## Slide field mapping (Media formatter)

`getPluginScopes()` builds the option lists the formatter offers:

- **images** (the slide stage / main image): the paragraph's `image` and
  `entity_reference` fields.
- **overlays**: the same stage fields **plus** `entity_reference` fields pointing at
  `media` entities — used to overlay media/image/nested references on the slide.

You pick, in the formatter settings, which paragraph field is the slide stage and which is
the overlay, along with the standard Slick options (optionset, skin, arrows/dots, caption,
responsive, etc.).

## Typical structure

```
Node (or any fieldable entity: User, ECK…)
 └─ Paragraphs field  → Slideshow bundle
     └─ "Slides" child Paragraphs field  ← format this with Slick Paragraphs
         └─ Slide bundle (image, title, caption, link, layout… non-paragraph fields)
```

Steps (from README):
1. Create a **Slide** paragraph bundle with the slide's fields (image/media, title, caption, link, optional layout list).
2. Create a **Slideshow** paragraph bundle with a multi-value (Unlimited) Paragraph field **Slides** referencing only the Slide bundle.
3. On the Slideshow bundle's **Manage display**, set the **Slides** field's format to a Slick Paragraphs formatter and configure its options (including the optionset).
4. Add a Paragraphs field on the host entity that allows the **Slideshow** bundle.

## Optionsets

Created in the Slick module, not here: **Admin → Config → Media → Slick**
(`/admin/config/media/slick`). The formatter references an optionset by name.

## Config schema

`config/schema/slick_paragraphs.schema.yml` defines the formatter settings types
(`slick_paragraphs` extends Slick's `slick_base`); the module has no `config/install`
defaults. Display config exports normally with `drush config:export`.

## Known limitation

The formatters only work in **Field UI Manage display**, not in **Views UI** (Views UI does
not respect `isApplicable()`).
