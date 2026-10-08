<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Stretched Link" pseudo-field

Everything is in `entity_stretched_link.module` (procedural; no classes). Two hooks.

## 1. Registration — `entity_stretched_link_entity_extra_field_info()`

Implements `hook_entity_extra_field_info()`. Loops over **all** entity types
(`\Drupal::entityTypeManager()->getDefinitions()`) and, for each, all bundles
(`\Drupal::service('entity_type.bundle.info')->getBundleInfo($entity_type_id)`), then declares a
**display** extra field:

```
$extra[$entity_type_id][$bundle_id]['display']['stretched_link'] = [
  'label'       => t('Stretched Link'),
  'description' => t('Display a link to the entity that is rendered all the entity rendered'),
  'weight'      => 99,
  'visible'     => FALSE,   // hidden/disabled by default
];
```

Effect: a **Stretched Link** component appears in *Manage Display* for every bundle, initially in
the *Disabled* region. There is no field type, no widget, no formatter plugin, and no per-component
settings — it is a pure display pseudo-field.

## 2. Rendering — `entity_stretched_link_entity_view()`

Implements `hook_entity_view()`. Runs on every entity render; acts **only** when the component is
enabled on the active view-display:

```
if ($display->getComponent('stretched_link')) { ... }
```

When enabled it builds:

```
$title_stripped = strip_tags($entity->label());
$title = t('Read more<span class="visually-hidden"> about @title</span>', ['@title' => $title_stripped]);
$build['stretched_link'] = [
  '#type'       => 'link',
  '#title'      => '',                 // empty visible text — overlay only
  '#url'        => $entity->toUrl(),   // entity canonical URL (Url object)
  '#language'   => $entity->language(),
  '#attributes' => [
    'rel'   => 'tag',
    'title' => $title,
    'class' => ['stretched-link'],
  ],
];
```

Notes for agents:
- The href is produced from `$entity->toUrl()` (a core `Url` object rendered by the link element),
  not from any field or config string — it always resolves to the entity's current canonical route
  in the entity's own language.
- `#title` is empty; the anchor has no visible text. The clickability comes entirely from the CSS
  overlay (below). The `title` attribute + visually-hidden span provide the accessible name.
- `hook_entity_view()` fires only for an entity the current user is already viewing, so no extra
  access logic is added or needed.

## 3. Required theme CSS (not shipped)

The module includes **no** CSS/library. For the whole rendered area to become clickable, the
containing element needs `position: relative` and the theme must define:

```
.stretched-link::after {
  position: absolute;
  top: 0; right: 0; bottom: 0; left: 0;
  z-index: 1;
  content: "";
}
```

This is the standard Bootstrap "stretched link" rule; Bootstrap-based themes already provide it.

## Operating checklist

1. Enable: `drush en entity_stretched_link -y` (depends on core `field`).
2. In *Manage Display* for the target bundle + view-mode (e.g. Teaser), drag **Stretched Link** out
   of the *Disabled* region. Save.
3. Confirm the rendered wrapper is `position: relative` and `.stretched-link::after` exists in the
   theme.
4. Beware overlap: any other real link/button inside the same card needs a higher `z-index` than
   the overlay (`z-index: 1`) to stay independently clickable.
