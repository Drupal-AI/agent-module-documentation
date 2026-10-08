<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a display template

## Where
Structure → (entity type) → Manage Display for a bundle/view mode. The module adds a
**"Display Template options"** details section with:
- `enabled` (checkbox) — turn the custom template on for this view mode.
- `twig` (CodeMirror) — the inline Twig template.

Stored as third-party settings on the EntityViewDisplay config entity:
`entity_display_template.enabled`, `entity_display_template.twig`.

## Available Twig context (`entity_display_template_default_context()`)
`link`, `entity_id`, `active_theme`, `active_theme_directory`, `base_path`, `front_page`,
`is_front_page`, `current_language`, `user_is_admin`, `user_is_logged_in` — plus every enabled
field's render array by machine name (`{{ field_body }}`, `{{ field_image }}`, …) and `wrapper_context`.
A field must be **enabled** on the display to be printable.

## Example
```twig
<article class="card">
  <h2><a href="{{ link }}">{{ label }}</a></h2>
  {{ field_summary }}
  {% if user_is_logged_in %}{{ field_body }}{% endif %}
</article>
```

## Security
The template is rendered with `#type => 'inline_template'` (no Twig sandbox). Editing it is
equivalent to granting PHP execution — restrict the display-admin permission to trusted admins.
Do not enable this module on sites where semi-trusted users can reach Manage Display.
