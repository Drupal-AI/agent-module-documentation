# Theming — how the restyle works

The module is a styling layer only. It ships CSS and attaches it to the existing toolbar; it
renders no new markup and defines no Twig templates or theme hooks.

## Libraries (`adminimal_admin_toolbar.libraries.yml`)

| Library | CSS files | Notes |
|---|---|---|
| `adminimal_admin_toolbar/adminimal-admin-toolbar` | `css/adminimal_admin_toolbar.css`, `css/toolbar.override.css` (weight 50) | Main dark restyle plus overrides that strip core toolbar borders/shadows. |
| `adminimal_admin_toolbar/google-fonts` | `css/font.css` | `@font-face` for the Open Sans webfont, loaded from Google's CDN. |

## Attachment logic (`adminimal_admin_toolbar.module`)

- `hook_page_attachments_alter()` — attaches `adminimal-admin-toolbar` globally; also attaches
  `google-fonts` unless `adminimal_admin_toolbar.settings:avoid_custom_font` is TRUE. Both only
  when the current user has the `access toolbar` permission.
- `hook_preprocess_html()` — adds the `adminimal-admin-toolbar` **body class** (again gated on
  `access toolbar`). All of the module's selectors are scoped under this class, so nothing
  leaks to users/pages without the toolbar.
- `hook_toolbar_alter()` — sets `class => ['user-toolbar-tab']` on the toolbar `user` item's
  wrapper attributes so CSS can push the account tab to the right.

The gate is the private helper `_adminimal_admin_toolbar_is_access()`, which returns TRUE when
`\Drupal::currentUser()->hasPermission('access toolbar')`.

## Customizing the look

Because everything is plain CSS scoped under `.adminimal-admin-toolbar`, override or extend it
from your own theme/module by loading CSS after these libraries (or by depending on and
overriding the library). There are no PHP/render-element extension points.
