# UIkit render elements

UIkit Components defines render elements (`Drupal\Core\Render\Element\RenderElement`
subclasses in `src/Element/`) so you can emit UIkit component markup from any render
array — a controller, a preprocess hook, a block, a field formatter, etc. Each element
has a `#pre_render` callback that adds the base UIkit CSS classes / `data-uk-*`
attributes, and a `#theme_wrappers` entry pointing at a default Twig template in
`templates/components/`.

## How registration works
- `uikit_components_theme()` (`includes/theme.inc`) loops over
  `UIkitComponents::getRenderElementList()` and registers a theme hook `uikit_<name>`
  (`render element => 'element'`) for **every** name in that list (36 names). Only the
  11 elements below actually ship an `src/Element/` class, a
  `template_preprocess_uikit_*()` in `includes/preprocess.inc`, and a template; the
  other names in the list have no class/template in this release.
- Preprocess functions live in `includes/preprocess.inc`; templates in
  `templates/components/*.html.twig`.

## The 11 usable elements

| `#type` | Class | Template | Key properties (defaults) |
|---------|-------|----------|---------------------------|
| `uikit_accordion` | `UIkitAccordion` | `uikit-accordion.html.twig` | `#items` (each: `title`, `content`), `#component_options` |
| `uikit_alert` | `UIkitAlert` | `uikit-alert.html.twig` | `#message`, `#style` (`primary`\|`success`\|`warning`\|`danger`, def `primary`), `#close_button` (FALSE) |
| `uikit_article` | `UIkitArticle` | `uikit-article.html.twig` | `#title`, `#meta`, `#lead`, `#content` |
| `uikit_badge` | `UIkitBadge` | `uikit-badge.html.twig` | `#value` |
| `uikit_breadcrumb` | `UIkitBreadcrumb` | `uikit-breadcrumb.html.twig` | `#items` (each: `text`, optional `url`, optional `disabled`) |
| `uikit_button` | `UIkitButton` | `uikit-button.html.twig` | `#text`, `#url` (→ `<a>` else `<button>`), `#style` (def `default`), `#size`, `#full_width` (FALSE), `#disabled` (FALSE) |
| `uikit_card` | `UIkitCard` | `uikit-card.html.twig` | `#content`, `#title`, `#style` (def `default`), `#hover` (FALSE), `#size`, `#badge`, `#header`, `#footer`, `#media` (`alignment` top\|bottom, `image_url`) |
| `uikit_comment` | `UIkitComment` | `uikit-comment.html.twig` | `#avatar` (`style_name`,`uri`,`height`,`width`,`alt`,`title`), `#title`, `#meta`, `#comment`, `#primary` (FALSE) |
| `uikit_countdown` | `UIkitCountdown` | `uikit-countdown.html.twig` | `#expire_date` (ISO-8601), `#separators` (`days_hours`,`hours_minutes`,`minutes_seconds`), `#labels` (`days`,`hours`,`minutes`,`seconds`) |
| `uikit_description_list` | `UIkitDescriptionList` | `uikit-description-list.html.twig` | `#items` (assoc `term`/`description`, or string), `#divider` (FALSE) |
| `uikit_video` | `UIkitVideo` | `uikit-video.html.twig` | `#embed_iframe` (full iframe HTML) **or** `#video_sources` (array of URLs), `#display_controls` (FALSE), `#component_options` |

Every element also carries `#attributes` (a `Drupal\Core\Template\Attribute` object) so
callers can add extra classes/attributes.

## Usage examples

```php
// Alert.
$build['alert'] = [
  '#type' => 'uikit_alert',
  '#message' => $this->t('Saved.'),
  '#style' => 'success',
  '#close_button' => TRUE,
];

// Card with a title and rendered content.
$build['card'] = [
  '#type' => 'uikit_card',
  '#title' => $this->t('Title'),
  '#content' => \Drupal\Core\Render\Markup::create($html),
  '#hover' => TRUE,
  '#size' => 'large',
];

// Accordion.
$build['accordion'] = [
  '#type' => 'uikit_accordion',
  '#items' => [
    ['title' => $this->t('Item 1'), 'content' => $this->t('…')],
    ['title' => $this->t('Item 2'), 'content' => $this->t('…')],
  ],
  '#component_options' => ['multiple: true'],
];
```

`#component_options` (accordion, video) are passed to UIkit's JS as `data-uk-*`
options and must be strings in `option: value` form.

## Escaping / output model
Templates render values through **normal Drupal/Twig autoescaping** — e.g.
`<p>{{ message }}</p>`, `{{ content }}`, `{{ item.text }}`. There is no `|raw` filter
anywhere in the templates. A caller that needs to output HTML (e.g. `#content`,
`#meta`, `#footer`) must wrap it in `Markup::create()` / a render array itself; plain
strings are escaped. These property values come from the render array the themer/
developer builds, so they are trusted input by design.

`uikit_video` with `#video_sources`: the preprocess fetches each source URL's MIME type
server-side via `MimeStreamWrapper` + `finfo` (see [api/helpers.md](../api/helpers.md)).
`#embed_iframe`: the preprocess parses the supplied iframe HTML with `DOMDocument` and
copies its attributes onto the output; the template emits `<iframe{{ attributes }}>`
(attributes escaped by the `Attribute` object).

## Overriding templates
Because these are standard theme hooks, a theme can override any
`uikit-<component>.html.twig` (copy it into the theme and adjust markup), or implement
`hook_preprocess_uikit_<component>()` to alter variables. Template suggestions follow
the usual `uikit_<component>__*` pattern for elements that add them.
