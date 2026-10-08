# Flag Anonymous — agent index

Shows anonymous, permission-less users a "**@login or @register** to use this flag" message
(optionally in a modal) instead of a Flag link, then auto-flags after they authenticate.
Depends on **flag**. No configure route, no permissions, no plugins, no drush — its only
state is **third-party settings on each Flag config entity**.

Key facts:
- Settings live at `flag.flag.<flag_id>.third_party.flag_anon` (schema
  `flag.flag.*.third_party.flag_anon`). Turned on per flag via `enabled: 1`.
- The behavior only triggers when the user is **anonymous** AND lacks permission to
  flag/unflag (so remove the anonymous role's flag permission for that flag).
- Implemented by **decorating** the `flag.link_builder` service with
  `Drupal\flag_anon\FlagAnonLinkBuilder` (via `FlagAnonServiceProvider::alter()`).

- **Enable it on a flag / the settings keys / where stored** →
  [configure/anonymous-settings.md](configure/anonymous-settings.md)
- **How the link builder override + auto-flag-after-login mechanism works** →
  [api/link-builder.md](api/link-builder.md)
- **Add custom message placeholders** →
  [hooks/placeholders.md](hooks/placeholders.md)
