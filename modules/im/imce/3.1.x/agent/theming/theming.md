# Theming

`hook_theme()` (in `imce.module`) registers two theme hooks; templates live in
`templates/`.

| Theme hook | Template | Variables |
|---|---|---|
| `imce_page` | `imce-page.html.twig` | `page` (render element) — the file-manager shell |
| `imce_help` | `imce-help.html.twig` | `videos`, `markup` — the help screen |

- Override by copying the template into your theme and adjusting markup.
- `imce.settings` `admin_theme: true` renders `/imce/*` pages in the site's admin theme.
- Front-end behavior/assets are JS libraries in `imce.libraries.yml`
  (`imce/drupal.imce`, `.upload`, `.resize`, `.delete`, `.newfolder`, editor/field
  integrations); attach or extend these rather than re-theming the JS UI.
- Icons use a bundled webfont (`css/fonts/imce-icons.*`) via `css/imce.icons.css`.
