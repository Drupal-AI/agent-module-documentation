<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Generic components (generic_components) — agent index
**Theme-agnostic Single Directory Components (SDC): HTML tag, HTML wrapper, spacer, conditional wrapper, field range, and Drupal comment/comment-links helpers.**

- **Version:** 1.1.x
- **Core:** `^11 || ^12` (info.yml `core_version_requirement`)
- **Package:** Custom. License GPL-2.0-or-later. No runtime module dependencies.
- **Provides:** seven SDCs under `components/` — `generic_html_tag`, `generic_html_wrapper`, `generic_spacer`, `conditional_wrapper`, `field_range`, `comment`, `comment_links`.
- **No** routes, permissions, services, hooks, config forms, config schema, plugin types, or Drush commands — it purely registers components.
- Composer `require-dev`: `drupal/ui_patterns ^2.0.16`, `drupal/ui_icons ^1.1`, `drupal/sdc_devel ^1.0.2`. **Caveat:** although `ui_patterns` is only a dev dependency and is not in `generic_components.info.yml`, the `comment_links` component's `link` prop uses `$ref: ui-patterns://url`, which makes `ui_patterns` an *effective runtime requirement* — with this module enabled but `ui_patterns` absent, SDC discovery throws `InvalidComponentException` on every request and the site fatals. Install `drupal/ui_patterns` (^2) alongside this module.

## Use
Reference a component from a theme/template, or select it in [Display Builder](https://git.drupalcode.org/project/display_builder):
```twig
{{ include('generic_components:generic_html_wrapper', { tag: 'section' }) }}
{% embed 'generic_components:conditional_wrapper' with { tag: 'aside' } %}
  {% block content %}{{ field_body }}{% endblock %}
{% endembed %}
```

## Solution docs
- [components/overview.md](components/overview.md) — every component with its props, slots, defaults, template behavior, and a usage snippet.

## Notes vs 1.0.x
- Added component: `conditional_wrapper` (optional wrapper tag with before/content/after slots, shown only when content is attached).
- `core_version_requirement` moved to `^11 || ^12` (was `^10 || ^11`).

## Security surface
No routes/permissions/endpoints. Component props are builder-supplied (not request input) and constrained by prop schemas (HTML tag pattern `^[a-zA-Z0-9-]+$`, spacer size/direction enums, integer minimums). Templates print props/slots through standard SDC/Twig auto-escaping — no `|raw`. The `comment`/`comment_links` JS talk only to core Drupal history endpoints and guard against anonymous users.
