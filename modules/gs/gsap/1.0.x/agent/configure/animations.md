# Animation config entities (`gsap`)

The `gsap` config entity (`src/Entity/Gsap.php`, `@ConfigEntityType`) lets a site builder
define an animation without code: a CSS selector, a `to`/`from` direction, a trigger event, and
a JSON payload of GSAP/CSS properties. `js/animations.js` applies them on the front end.

- Entity type id: `gsap`; config prefix `gsap.gsap.*`; admin permission `administer gsap`.
- Handlers: list builder `Drupal\gsap\GsapListBuilder`; forms `add`/`edit` =
  `Drupal\gsap\Form\GsapForm`, `delete` = core `EntityDeleteForm`.
- `config_export`: `id, label, description, event, scrolltrigger, selector, direction, json`
  (plus the standard `status`/`uuid` from `ConfigEntityBase`).

## CRUD routes (all require `administer gsap`)

| Route | Path |
|---|---|
| `entity.gsap.collection` | `/admin/structure/gsap` |
| `entity.gsap.add_form` | `/admin/structure/gsap/add` |
| `entity.gsap.edit_form` | `/admin/structure/gsap/{gsap}` |
| `entity.gsap.delete_form` | `/admin/structure/gsap/{gsap}/delete` |

## Fields (`GsapForm`)

| Field | Type | Notes |
|---|---|---|
| `label` | textfield | Required. |
| `id` | machine_name | Required, immutable after create. |
| `status` | checkbox | "Enabled" — only enabled entities are loaded at runtime. |
| `description` | textarea | Optional. |
| `event` | select | `click`, `hover`, or `scrollTrigger`. Required. |
| `scrolltrigger` | details (mapping) | Shown when `event = scrollTrigger`: `markers` (bool), `trigger`, `start`, `end`, `scrub`, `pin` (strings). |
| `selector` | textfield | Required. CSS selector for the animated element. |
| `direction` | select | `to` or `from` (calls `gsap.to()` / `gsap.from()`). Required. |
| `json` | textarea | Optional. Flow-style GSAP config, e.g. `{x: 100, y: 100, ease: "power1.inOut"}`. |

### JSON validation

`GsapForm::validateForm()` parses `json` with the YAML parser (so JSON-flow and YAML both
work) and rejects any top-level key not in the allowlist:

- GSAP props: `delay, duration, ease, id, yoyo, x, y, scale, scaleY, scaleX, rotation, skewX, skewY`
- CSS props: `backgroundColor, color, fontSize, height, left, margin, opacity, padding, right, top, transform, width`

An unknown key or unparseable value fails validation.

## Runtime (`js/animations.js` + `hook_page_attachments`)

Enabled entities are exposed via `drupalSettings.gsap.global` (id, event, scrolltrigger,
selector, direction, json) and applied by the `gsap/animations` library. Per entity:
`gsap[direction](selector, json)` builds a tween.
- `event = scrollTrigger`: a `scrollTrigger` object is assembled from the entity's
  `markers/trigger/start/end/scrub` settings.
- `event = click`: tween starts paused and plays on the element's `click`.
- `event = hover`: tween plays on `mouseenter`, reverses on `mouseleave`.

Because the entity loading lives inside the `include_gsap` branch, these animations only run
when **Include GSAP on every page** is enabled — see [settings.md](settings.md).

## Create one via PHP

```php
\Drupal::entityTypeManager()->getStorage('gsap')->create([
  'id' => 'hero_fade',
  'label' => 'Hero fade',
  'status' => TRUE,
  'event' => 'scrollTrigger',
  'selector' => '.hero-title',
  'direction' => 'from',
  'json' => '{opacity: 0, y: 50, duration: 1}',
  'scrolltrigger' => ['markers' => FALSE, 'start' => 'top 80%'],
])->save();
```

Config schema: `config/schema/gsap.schema.yml` → `gsap.gsap.*`.
