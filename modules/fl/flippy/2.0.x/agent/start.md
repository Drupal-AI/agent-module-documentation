# Flippy — agent index

Per-content-type Previous/Next (+First/Last/Random) node pager. Configured on the **node-type
edit form**, not a central settings page (**no `configure` route**). All state lives in the
`flippy.settings` config object as per-type keys. No permissions, no Drush, no config schema.

- **Enable/configure the pager for a content type; every `flippy.settings` key** →
  [configure/pager.md](configure/pager.md)
- **Call the pager programmatically (`flippy.pager` service) and place the block** →
  [api/service.md](api/service.md)
- **Alter which nodes are next/previous (`buildFlippyQuery` event)** →
  [extend/query-event.md](extend/query-event.md)
- **Template, theme hook, and template suggestions** → [theming/templates.md](theming/templates.md)

Key facts:
- Settings key pattern: `flippy_<type>` (on/off), `flippy_head_<type>`, `flippy_show_empty_<type>`,
  `flippy_prev_label_<type>`, `flippy_next_label_<type>`, `flippy_first_last_<type>`,
  `flippy_first_label_<type>`, `flippy_last_label_<type>`, `flippy_loop_<type>`,
  `flippy_random_<type>`, `flippy_random_label_<type>`, `flippy_truncate_<type>`,
  `flippy_ellipse_<type>`, `flippy_press_swipe_<type>`, `flippy_custom_sorting_<type>`,
  `flippy_sort_<type>`, `flippy_order_<type>` (all in `flippy.settings`).
- Enabling a type exposes a `flippy_pager` pseudo-field on that bundle's *Manage display*.
- Service `flippy.pager` (`Drupal\flippy\FlippyPager`): `flippy_build_list($node)`,
  `flippy_use_pager($node)`, `flippy_generate_link($nid, $label)`.
- Block plugin id `flippy_block`. Theme hook `flippy` (template `flippy.html.twig`).
- Optional integrations: `token` (label tokens + browser), `hammerjs` (keyboard/swipe).
