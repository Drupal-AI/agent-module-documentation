<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming the media section

## Theme hook & library

`bp_media.module` → `hook_theme()`: `'paragraph__bp_media' => ['base hook' => 'paragraph']`.
Template: `templates/paragraph--bp-media.html.twig`. Override by copying it into your theme.

**This submodule ships no CSS and no `*.libraries.yml`.** The template attaches the parent's
library only:

```twig
{{ attach_library('bootstrap_paragraphs/bootstrap-paragraphs') }}
```

## Markup it emits

```html
<div class="paragraph paragraph--type--bp-media paragraph--view-mode--default
            paragraph--id--{pid} {bp_width} {background} {bp_margin} {bp_padding}">
  <div class="paragraph__column">
    <h2>{{ bp_header }}</h2>                     {# only if bp_header set #}
    <a href="{{ bp_link.0['#url'] }}">           {# only if bp_link set #}
      {{ content|without('bp_background','bp_header','bp_link','bp_width','bp_margin','bp_padding') }}
    </a>
  </div>
</div>
```

Notes that matter when debugging output:

- Unlike `paragraph--bp-callout.html.twig`, this template does **not** whitelist values — it
  interpolates the stored strings straight into the class list
  (`content.bp_width['#items'].getString()`, `content.bp_margin[0]['#markup']`, …). Any value
  you add to a list storage therefore appears as a class with no template change.
- The class list also references `bs.background_color`, a variable supplied by the parent
  `bootstrap_paragraphs` preprocessing; the raw `bp_background` value reaches the markup
  through that path.
- `paragraph--id--{{ paragraph.id.value }}` is a **class**, not an `id` attribute (`bp_callout`
  and `bp_card` use `id` instead).
- `bp_media` is not in the `without()` list, so the referenced media entity renders inside the
  anchor — that is what makes an image or video poster clickable.
- The link's title is disabled at field level (`title: 0`), so only the URL is used.

## Changing how the media itself renders

The media is rendered with `entity_reference_entity_view` in the `default` view mode. To use a
different media view mode, edit the view display rather than the template:

```bash
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("paragraph.bp_media.default");
  $c = $vd->getComponent("bp_media");
  $c["settings"]["view_mode"] = "teaser";
  $vd->setComponent("bp_media", $c)->save();'
```
