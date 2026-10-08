# Smart Title — agent index

Makes a content entity's **label** a configurable extra field (`smart_title`) on the
*Manage display* form: hide it, drag it among fields, wrap it in a tag/classes, link it or
not — per entity type + bundle + view mode. No configure route on the core module
(`configure=null`; the **smart_title_ui** submodule adds the admin page). No plugins, no
Drush. Persistent state is a bundle list in `smart_title.settings` plus per-view-display
third-party settings.

- **Opt a bundle in, enable Smart Title on a view display, and set tag/classes/link (config
  keys + third-party settings)** → [configure/smart-title.md](configure/smart-title.md)

Key facts: eligible bundles are `entity_type:bundle` strings in
`smart_title.settings.smart_title`. Per view display, Smart Title is stored on
`core.entity_view_display.<entity>.<bundle>.<mode>` as
`third_party_settings.smart_title.enabled: true` plus a `smart_title` component (region), with
format settings under `third_party_settings.smart_title.settings`:
`smart_title__tag`, `smart_title__classes` (array), `smart_title__link` (bool).
