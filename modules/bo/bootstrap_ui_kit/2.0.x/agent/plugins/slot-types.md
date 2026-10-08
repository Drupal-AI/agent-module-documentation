# Slot-type handlers & story YAML format

This is the module's main extension point. It is **not a Drupal plugin type** (no plugin manager /
annotation); it is a **tagged-service pipeline**. `ContentInjectionManager` receives every service
tagged `bootstrap_ui_kit.slot_type` (in priority order via `!tagged_iterator`) and, for each slot
item, calls the first handler whose `applies()` returns TRUE and whose `build()` returns non-NULL.

## Interface

`Drupal\bootstrap_ui_kit\SlotType\SlotTypeHandlerInterface`:

```php
public function applies(array $item): bool;
public function build(array $item, callable $transformNested): ?array; // render array, or NULL to fall through
```

`$transformNested` re-runs `ContentInjectionManager::transformSlots()` on a nested slot collection
(used by the component handler for child slots). Returning `NULL` from `build()` lets a
lower-priority handler try.

## Built-in handlers (from `bootstrap_ui_kit.services.yml`)

| Priority | Service id | Class | Matches | Produces |
|---|---|---|---|---|
| 100 | `bootstrap_ui_kit.slot_type.component` | `ComponentSlotTypeHandler` | `component` set & `type` in {unset, `component`} | `#type => component` (nested `#props`, `#slots`) |
| 95 | `bootstrap_ui_kit.slot_type.image` | `ImageSlotTypeHandler` | `type`/`theme` == `image` with a `uri` | `data:` URIs → raw `#type html_tag` `<img>`; otherwise `#theme => image`. Whitelists img attributes. |
| 90 | `bootstrap_ui_kit.slot_type.html_tag` | `HtmlTagSlotTypeHandler` | `tag` set & `type` in {unset, `html_tag`} | `#type => html_tag`; supports numeric-keyed child markup / child `<img>` / child tags (all `htmlspecialchars`-escaped) |
| 80 | `bootstrap_ui_kit.slot_type.icon` | `IconSlotTypeHandler` | `type == icon` or (no `type` & `icon_id` set) | `inline_template` including `@bootstrap_ui_kit/ui-kit/iconography/icon.html.twig` |
| 10 | `bootstrap_ui_kit.slot_type.markup` | `MarkupSlotTypeHandler` | `type == markup`, or has `value`/`markup` and none of component/tag/icon_id | `#markup` fallback |

(The README's priority table predates the `image` handler; `services.yml` above is authoritative.)

## Registering a custom handler

```php
// my_theme.services.yml
services:
  my_theme.slot_type.media:
    class: Drupal\my_theme\SlotType\MediaSlotTypeHandler
    tags:
      - { name: bootstrap_ui_kit.slot_type, priority: 85 }
```

Implement `SlotTypeHandlerInterface`; a higher priority than a built-in (e.g. `> 80` for `icon`) lets
you override it — return `NULL` in `build()` to defer to the core handler. Keep `applies()` cheap.

## Story YAML format

A story file lives at `components/{machine}/stories/{machine}.<name>.story.yml` inside a custom
module/theme (see discovery paths in [../api/services.md](../api/services.md)). Keys consumed:

```yaml
name: 'Default'                 # REQUIRED for the file to be discovered
props:                          # merged into the component #props
  title: 'Example card'
  variant: primary
slots:                          # transformed via the handler pipeline below
  header:
    - type: html_tag
      tag: h3
      value: 'Card title'
      attributes: { class: ['card-title'] }
  body:
    - type: component           # nested SDC component
      component: 'my_theme:badge'
      props: { label: 'New' }
    - type: icon
      icon_id: 'star-fill'
      settings: { class: 'text-warning', size: '2rem' }
  media:
    - type: image
      uri: 'data:image/svg+xml;base64,…'
      alt: 'Placeholder'
library_wrapper: >             # optional visual wrapper around the demo
  <div class="p-3 bg-body-tertiary border rounded">{{ _story }}</div>
```

- A slot value that is a plain string becomes `['#markup' => string]`.
- A slot value that is a YAML list is transformed item-by-item; a single-item list is collapsed to a
  single render array.
- `library_wrapper` may instead be a template reference like
  `"@my_theme/ui-kit/wrappers/panel.html.twig"`; wrapper context vars are `_story`, `_props`,
  `_slots`, `_component_id`.

## SDC variants

Variants come from the component's own `.component.yml` `variants:` map (read via
`ComponentDefinitionRepository::getVariants()`), not from this module. Selecting a variant stores
`props.variant` on the component entry (see [../configure/glossary.md](../configure/glossary.md)).
