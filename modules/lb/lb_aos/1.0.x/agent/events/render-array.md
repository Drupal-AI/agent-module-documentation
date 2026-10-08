<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# lb_aos — emitting the AOS attributes at render (event subscriber)

`src/EventSubscriber/BlockComponentRenderArraySubscriber.php`, registered in `lb_aos.services.yml`
as `lb_aos.render_block_component_subscriber` with constructor args `@entity_type.manager` and
`@config.factory` (both injected, neither currently used by the class).

## Subscription
```php
$events[LayoutBuilderEvents::SECTION_COMPONENT_BUILD_RENDER_ARRAY] = ['onBuildRender', 50];
```
- Event id constant: `LayoutBuilderEvents::SECTION_COMPONENT_BUILD_RENDER_ARRAY`, value
  `'section_component.build.render_array'`.
- Priority `50` is deliberately higher than Layout Builder's own subscriber, so this runs **after**
  the base render array for the component already exists.

## Handler `onBuildRender(SectionComponentBuildRenderArrayEvent $event)`
```php
$build = $event->getBuild();
if (empty($build)) { return; }                 // LB should have built it already
$animation_type = $event->getComponent()->get('animation_type');
if ($animation_type) {                          // skip when '' / None
  $build['#animation_type'] = $animation_type;
  $build['#attributes']['data-aos'] = $animation_type;
  $build['#attached']['library'][] = 'aos/aos';
  $build['#cache']['tags'][] = 'config:lb_aos.animation_type.' . $animation_type;
  $event->setBuild($build);
}
```

Effect on the rendered block:
- `data-aos="<animation_type>"` on the block wrapper — the attribute AOS reads to trigger the
  animation. The value is a render-array attribute, so it is auto-escaped by the renderer.
- The `aos/aos` library is attached (defined by the `aos` module), which loads AOS's JS/CSS and its
  scroll observer. Nothing is attached when no animation is selected.
- `#animation_type` is set on the build too (informational; not consumed by a template here).
- A cache tag `config:lb_aos.animation_type.<type>` is appended. No config entity of that name
  exists, so this tag is never invalidated by real config changes — it is effectively inert. Removing
  it would not change behaviour; adding a matching cache context/tag would only matter if per-type
  invalidation were introduced.

`prefers-reduced-motion` handling and the actual animation belong to the AOS library, not this
module — verify accessibility behaviour on the `aos` side before shipping motion to a public site.
