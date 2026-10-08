# profile theming

## Theme hook
`hook_theme()` registers **`profile`** with `render element: elements`.
Default template: **`profile.html.twig`** (in the module's `templates/`).

## Template variables (`template_preprocess_profile`)
- `profile` — the `ProfileInterface` entity.
- `content` — render array of the profile's rendered fields (loop or print individually).
- `view_mode` — active view mode.
- `url` — the profile's canonical URL (or `FALSE` if unsaved).
- `attributes` — HTML attributes for the wrapper.

## Template suggestions
`profile_theme_suggestions_profile()` adds suggestions so you can target by type and view mode,
e.g.:
- `profile--<profile_type>.html.twig`
- `profile--<profile_type>--<view_mode>.html.twig`
- `profile--<view_mode>.html.twig`

## View modes
Profiles are fieldable entities; configure their display per view mode under the profile type's
**Manage display** (and form display for edit forms). Render a profile with the entity view
builder / `entity_view` as usual.
