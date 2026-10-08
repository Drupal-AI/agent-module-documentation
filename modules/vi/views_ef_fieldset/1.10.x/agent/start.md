# Views Exposed Form Fieldset — agent index

A Views **display-extender** plugin (`views_ef_fieldset`) that groups a view's exposed filters,
sorts and buttons into nested fieldsets / containers / vertical tabs. No admin settings page
(`configure: null`), no Drush, no permissions. All config is per view, stored in the view entity.

- **Where the config lives, the `options.sort` tree structure, enabling per view** →
  [configure/grouping.md](configure/grouping.md)
- **How it renders (display extender + exposed-form alter + tree→FAPI rebuild)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Enabled globally in `views.settings` `display_extenders: [views_ef_fieldset]` by the install hook;
  per-view it is toggled by `...display_extenders.views_ef_fieldset.views_ef_fieldset.enabled`.
- Config path in a view: `display.<display_id>.display_options.display_extenders.views_ef_fieldset.views_ef_fieldset`
  → `{ enabled: bool, options: { sort: { <item_id>: {id, pid, weight, depth, type, container_type?, title?, description?, open?} } } }`.
- Item `type` is one of `container` | `filter` | `sort` | `buttons`; containers carry `container_type`
  of `container` | `details` (Fieldset) | `vertical_tabs`; `pid` is the parent id (`root` is the top container).
- The UI is exposed on the view's **Exposed form** settings section only.
