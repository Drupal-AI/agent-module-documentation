<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ept_hero` paragraph type

Machine name `ept_hero`, label "EPT Hero". Installed from
`config/install/paragraphs.paragraphs_type.ept_hero.yml` with no behavior plugins.

## Fields (installed on the bundle)

| Field | Type | Notes |
|-------|------|-------|
| `field_ept_hero_column_image` | entity_reference → `media` | Handler restricted to `target_bundles: {image: image}`; media-library widget. Rendered in `hero-col-1`. |
| `field_ept_hero_title_prefix` | text_long | "Title prefix" (eyebrow above the title); `text_textarea` widget, `text_default` formatter. |
| `field_ept_title` | text_long (shared from ept_core) | Main heading. Rendered as the field emits — **no fixed heading level**. |
| `field_ept_text` | text_long (shared from ept_core) | Body / supporting text. |
| `field_ept_hero_link` | link | Primary CTA. `title: 1` (title enabled), `link_type: 17` (internal + external). |
| `field_ept_hero_second_link` | link | Secondary CTA, same settings. |
| `field_ept_settings` | ept_settings (from ept_core) | Holds all per-paragraph style/layout settings; edited by the `ept_settings_hero` widget. |

`field_ept_title`, `field_ept_text` and `field_ept_settings` come from **ept_core**'s field
storages; the `field_ept_hero_*` fields have their own storages in this module.

## Form: `ept_settings_hero` widget

`src/Plugin/Field/FieldWidget/EptSettingsHeroWidget.php` extends
`\Drupal\ept_basic_button\Plugin\Field\FieldWidget\EptSettingsBasicButtonWidget` (which itself
extends the ept_core default widget). On top of the inherited **Design options** (CSS box —
margin/border/padding, background color/image/media, edge-to-edge, container width) and the first
**Link options**, the hero widget adds:

- **Styles** (radios): `two_columns` (default) or `one_column`. The chosen value attaches
  `ept_hero/two_columns` or `ept_hero/one_column` and becomes a `hero-style-*` / bare class on the
  wrapper.
- **Add overlay** (checkbox) + **Overlay Color** (textfield, default `#000000`) + **Overlay
  opacity** (number, 0–1, default 0.6).
- **Image position** (radios left/right) — desktop column order in the two-column layout.
- **Image position on mobile** (radios image_first / image_last / hide_image).
- **Mobile breakpoint** (textfield, default from `ept_core.settings:ept_core_mobile_breakpoint`
  or 480) — px width at which two columns collapse to one.
- **Second Link options** (`link_options2`): a full copy of the first link-options group for the
  second button.
- **Elements additional classes** (details): `bg_inner_classes`, `ept_container_classes`,
  `ept_hero_container_classes`, `hero_col_1_classes`, `hero_col_2_classes`,
  `buttons_wrapper_classes`, `button_1_wrapper_classes`, `button_2_wrapper_classes` — each
  validated by `EptGenericValidator::validateClassElement` (regex `^[a-zA-Z][a-zA-Z0-9_-]*$` per
  space-separated token).

`massageFormValues()` flattens the first `link_options` group up into `ept_settings` so the
first button's options sit at the top level (the template reads them from
`ept_settings.0.ept_settings.*`), while the second button reads from `ept_settings.link_options2.*`.

## View render path

`core.entity_view_display.paragraph.ept_hero.default.yml` hides all labels and renders through
`templates/paragraph--ept-hero--default.html.twig`:

```
<div class="paragraph … ept-hero ept-basic-button paragraph-id-N …">
  <div class="bg-inner {bg_inner_classes}"></div>
  <div class="ept-container {ept_container_classes}">
    <div class="ept-hero-container {ept_hero_container_classes}">
      <div class="hero-col-1 {hero_col_1_classes}">{{ field_ept_hero_column_image }}</div>
      <div class="hero-col-2 {hero_col_2_classes}">
        {{ field_ept_hero_title_prefix }}{{ field_ept_title }}{{ field_ept_text }}
        <div class="buttons {buttons_wrapper_classes}">
          … <a href="{{ link.0['#url'] }}" class="ept-basic-button …">{{ link.0['#title'] }}</a> …
        </div>
      </div>
    </div>
  </div>
</div>
{{ styles|raw }}{{ button_styles|raw }}{{ hero_styles|raw }}
```

The `nofollow` / `target="_blank"` attributes on each button are toggled from the link-options
`add_nofollow` / `open_in_new_tab` booleans (printed via `|raw`, but their values are hardcoded
attribute strings, not user text).

Note: the template calls `attach_library('ept_hero/ept_hero')`, but `ept_hero.libraries.yml` only
defines `common`, `one_column`, `two_columns` — there is no `ept_hero` library (a harmless missing
attach; the effective styling comes from `common` + the selected style library).
