<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Splide optionsets & module settings

## The `splide` optionset config entity

A slider preset is a `splide` config entity, stored as `splide.optionset.<id>`. It bundles the
Splide.js options plus Drupal wrapper metadata:

```yaml
# splide.optionset.<id>
id: my_carousel
name: my_carousel
label: 'My Carousel'
status: true
weight: 0
group: ''              # '', main, nav, thumbnail, overlay … (pairs sliders for asNavFor)
skin: default          # a @SplideSkin id: default | classic | fullwidth | seagreen | split | …
breakpoint: 0          # number of responsive breakpoints exposed in the UI
optimized: false       # strip default option values from saved config
options:
  settings:            # raw Splide.js options
    type: slide        # slide | loop | fade
    perPage: 1
    perMove: 0
    gap: '0'
    arrows: 'true'
    pagination: 'true'
    autoplay: false
    interval: 5000
    pauseOnHover: true
    drag: 'true'
    speed: 400
    # …see config/install/splide.optionset.default.yml for the full option list…
  breakpoints:         # per-breakpoint overrides
    - { breakpoint: 900, unsplide: false, settings: { perPage: 2 } }
    - { breakpoint: 480, settings: { perPage: 1 } }
```

The shipped `default` optionset (`config/install/splide.optionset.default.yml`) is the canonical
reference for every available `settings` key.

### Create / manage optionsets

- UI (requires the **splide_ui** submodule): *Configuration → Media → Splide*
  (`/admin/config/media/splide`) — list, **Add** (`/admin/config/media/splide/add`), edit,
  **Duplicate**, delete. Permission: `administer splide`.
- Config: import a `splide.optionset.<id>.yml`, or create the entity in code:

```php
\Drupal\splide\Entity\Splide::create([
  'id' => 'my_carousel', 'name' => 'my_carousel', 'label' => 'My Carousel',
  'skin' => 'default', 'group' => '',
  'options' => ['settings' => ['type' => 'loop', 'perPage' => 3, 'autoplay' => TRUE]],
])->save();
```

Read back: `drush cget splide.optionset.my_carousel`.

## Module settings — `splide.settings`

```yaml
module_css: true    # load the module's component CSS
splide_css: true    # load the Splide library's own CSS
sitewide: 0         # load Splide assets site-wide
```

Edited at `/admin/config/media/splide/ui` (route `splide.settings`, splide_ui submodule).

## Library requirement

Splide needs the Splide JS library (v4+, e.g. 4.1.4) under `/libraries/splide/` (or
`/libraries/splidejs--splide/` via composer). Optional Splide extensions (auto-scroll, intersection)
go in their own `/libraries/` folders. Without the library the sliders won't initialize.
