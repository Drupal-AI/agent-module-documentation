# Configure Diff Plus

Config object: `diff_plus.settings` (defaults in `config/install/diff_plus.settings.yml`). Two forms
edit the same key set; both extend `DiffPlusSettingsFormBase`.

| Form | Route | Path | Permission | Stored in |
|---|---|---|---|---|
| Site defaults | `diff_plus.default_settings` | `/admin/config/content/diff_plus/settings/default` | `administer site configuration` | `diff_plus.settings` config |
| Per-user | `diff_plus.user_settings` | `/admin/config/content/diff_plus/settings` | `personalize diff plus settings` | `user.data` (`diff_plus`/`<uid>`/`settings`) |

At render time the effective settings are the site config, and — **only if the current user has
`personalize diff plus settings`** — their `user.data` overrides merged on top
(`array_replace_recursive`). Users without that permission always get the site defaults.

## Settings keys (defaults)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enhance_diff_ui` | bool | `true` | Replace the stock diff header with the themed `diff_plus_ui` block (authors, status, prev/next, history). |
| `visual_html5_preserve_inline_styles` | bool | `true` | Keep inline `style` attributes through the HTML5 visual diff (stashed as `data-diff-plus-style` around `Xss::filter`, then restored). |
| `raw_html_render_anonymously` | bool | `true` | Render each revision as an anonymous user before diffing (avoids per-user markup false positives). Uses `account_switcher`. |
| `raw_html_strip_contextual_links` | bool | `true` | Remove elements with `data-contextual-id` before diffing. |
| `raw_html_strip_js_view_dom_id` | bool | `true` | Strip `js-view-dom-id-*` classes (Views) that cause spurious diffs. |
| `raw_html_strip_comments` | bool | `true` | Remove HTML comments before diffing. |
| `raw_html_indent_size` | int | `2` | js-beautify indent size. |
| `raw_html_wrap_line_length` | int | `0` | js-beautify wrap length (`0` = disabled). |
| `raw_html_preserve_newlines` | bool | `false` | js-beautify preserve newlines. |
| `raw_html_highlight_style` | string | `""` | highlight.js stylesheet name (empty = default). The form offers a very large bundled option list (e.g. `github.min.css`, `base16/dracula.min.css`, `atom-one-dark.min.css`, …). |

## How the two forms differ in submit

- Default form: writes the merged values into editable config `diff_plus.settings`.
- User form: writes them into `user.data` for the current uid; never touches site config.

Both use `array_intersect_key(getValues(), defaults)` so only known keys are persisted.

## Notes

- There is no dedicated Diff Plus enable step for the layouts — they are `diff` layout plugins,
  selected inside the Diff module's own settings (see [../plugins/layouts.md](../plugins/layouts.md)).
- Two theme negotiators (`RawHtmlThemeNegotiator`, `VisualInlineHtml5ThemeNegotiator`) force the site
  **default** theme on the `raw_html` / `visual_inline_html5` diff routes so the diff renders in the
  front-end theme rather than the admin theme.
