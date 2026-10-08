# Configure Parallax elements

Managed at *Structure → Parallax elements* (`/admin/structure/parallax_element`, route
`entity.parallax_element.collection` — the module's `configure` link), gated by the
`administer parallax elements` permission. Each **Parallax element** is a `parallax_element` config
entity.

## The `parallax_element` config entity

`@ConfigEntityType(id = "parallax_element", config_prefix = "parallax_element",
admin_permission = "administer parallax elements")` (`src/Entity/ParallaxElement.php`). Add/edit form
(`ParallaxElementForm`) fields:

| Field | Form element | Values / notes |
|---|---|---|
| `label` | textfield "Valid jQuery selector" (required, max 255) | The CSS/jQuery selector of the element whose background gets the effect, e.g. `#top-content`, `body.front #banner`. Stored as the entity **label**. |
| `id` | machine_name | Entity id. |
| `description` | textarea | Free-text note. |
| `position` | select | `0` = Left, `50%` = Center (default), `100%` = Right (background horizontal position). |
| `speed` | select | `0`–`3` in `0.1` steps (default `0.1`) — relative scroll speed. |
| `status` | checkbox "Published" | Only enabled (`status()` true) elements are emitted to the front end. |

Exported config keys: `id`, `label`, `description`, `position`, `speed`, `uuid`
(schema `parallax_bg.parallax_element.*`).

## How settings reach the browser

`parallax_bg_page_attachments()` (in `parallax_bg.module`) runs on every page:

1. Loads all `parallax_element` entities; for each with `status()` true, builds
   `['selector' => $entity->label(), 'description' => ..., 'position' => ..., 'speed' => ...]`.
2. Runs the array through `hook_parallax_bg_settings_alter()` (see [../hooks/alter.md](../hooks/alter.md)).
3. If non-empty, attaches library `parallax_bg/parallax_bg` and sets
   `drupalSettings.parallax_bg = <settings array>`.
4. Adds cache tag `config:parallax_element_list` so edits invalidate the page cache.

`js/parallax_bg.js` reads `drupalSettings.parallax_bg` and applies the bundled jQuery parallax plugin to
each `selector`. The `label`/selector is authored by an admin (permission-gated) and used as a jQuery
selector client-side, so only trusted roles should hold `administer parallax elements`.

## Create an element with Drush (example)

```php
// drush php:eval — add a parallax effect on #hero
\Drupal::entityTypeManager()->getStorage('parallax_element')->create([
  'id' => 'hero',
  'label' => '#hero',           // jQuery selector
  'description' => 'Front page hero background',
  'position' => '50%',
  'speed' => '0.3',
  'status' => TRUE,
])->save();
```
