# Enable the right submodule (there is no config UI)

The base `hook_event_dispatcher` module has **no settings form, no permissions, no config**.
"Configuration" here means: enable the base module plus the per-subsystem submodule that owns
the hook you want to subscribe to. Events do not exist until their submodule is enabled.

## Per-subsystem submodule split

Enabling the base module alone gives you the dispatch machinery but **zero events**. Each of
the ~10 submodules registers events for one Drupal subsystem and depends on
`hook_event_dispatcher`:

| Submodule | Enables events for |
|---|---|
| `core_event_dispatcher` | entity, form, theme, block, file, menu, token, language, page, options, and general core hooks |
| `field_event_dispatcher` | field widget/formatter/info hooks |
| `media_event_dispatcher` | media hooks |
| `path_event_dispatcher` | path / alias hooks |
| `preprocess_event_dispatcher` | `template_preprocess_*` / preprocess hooks |
| `user_event_dispatcher` | user hooks |
| `views_event_dispatcher` | Views hooks |
| `toolbar_event_dispatcher` | toolbar hooks |
| `jsonapi_event_dispatcher` | JSON:API hooks |
| `webform_event_dispatcher` | Webform hooks (needs the contrib Webform module) |

Enable only what you use. Most sites want just `core_event_dispatcher`:

```bash
drush en core_event_dispatcher -y   # pulls in hook_event_dispatcher automatically
```

Add others as needed, e.g. `drush en views_event_dispatcher user_event_dispatcher -y`.

## Scaffold a subscriber with Drush

The base module ships a Drush code generator (service `hook_event_dispatcher.generator`,
tagged `drush.generator.v2`) that stubs an event subscriber:

```bash
drush generate                       # pick the hook-event subscriber generator
```

## Notes

- `configure` route: none (`data.json` `configure` is `null`).
- No permissions are defined by the base module.
- `hook_event_dispatcher.module` only implements `hook_help()` (renders the README); it
  dispatches nothing itself.
