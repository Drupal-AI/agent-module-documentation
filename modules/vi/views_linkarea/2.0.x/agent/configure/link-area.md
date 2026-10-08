<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Link Area — configuring the Link area handler

## Adding it
Edit a View → in **Header**, **Footer**, or **No Results Behavior** click *Add* → choose
**Link** (Global category, description "Provide an internal or external link"). Options are
stored per-handler (schema `views.area.linkarea`).

## Options (defaults in `defineOptions()`)
| Option | Type | Purpose |
|---|---|---|
| `link_text` | textfield (required) | Link text. Tokenized. Rendered via `strip_tags(Html::decodeEntities())`. |
| `path` | textfield (maxlength 255) | Drupal path, URI (`entity:`, `route:`), or absolute URL; may include query + fragment. Tokenized. `<front>` supported. |
| `external` | checkbox | If set and path has no scheme and no leading `/`, prefixes `http://`. |
| `output_as_action` | checkbox | Render as a `menu_local_action` themed button wrapped in `<ul class="action-links">`. |
| `destination` | checkbox (default TRUE) | Append current `destination` query param so the link returns the user to the view. |
| `replace_spaces` | checkbox | Replace spaces with dashes in the path. |
| `path_case` | select | Transform case of the path value: none/upper/lower/ucfirst/ucwords (only for non-routed URLs). |
| `prefix` / `suffix` | textfield | Markup before/after the link. Tokenized. **Accepts HTML** (set as `#prefix`/`#suffix`). |
| `alt` | textfield | Sets `title` attribute (only if it differs from link text). Tokenized. |
| `rel` | textfield | `rel` attribute. Tokenized. |
| `link_class` | textfield | CSS class. Tokenized. |
| `target` | textfield | `target` attribute (`_blank`, iframe name, …). Tokenized. |
| `absolute` | checkbox (advanced) | Force absolute URL. |
| `rewrite_output` | textarea (advanced) | Template outputting arbitrary HTML with the `{{ views_linkarea }}` token (the built link) + global tokens. **Accepts HTML.** |
| `access_denied_text` | textarea (advanced) | Markup shown when the routed URL is access-denied. Tokenized. |
| `language` | radios (advanced) | Target language for URL generation (`**auto**` = current). |

## Tokens
The handler extends `TokenizeAreaPluginBase`; when the base "Use tokens" option is on,
values are token-replaced from the **first result row**. `link_text`, `path`, `alt`,
`rel`, `link_class`, `target`, `prefix`, `suffix`, `access_denied_text`, and
`rewrite_output` all pass through `tokenizeValue()` / `viewsTokenReplace()`.

## Access handling
`renderUrl()` → `checkUrlAccess()`: for **routed** URLs it calls
`access_manager->checkNamedRoute($routeName, $params)`. If access is denied, the handler
renders `access_denied_text` (through `sanitizeValue(... )`) instead of the link.
Non-routed (external) URLs are not access-checked (return TRUE).

## Output / rendering
- Normal case: returns a render array `['#type' => 'link', '#url' => $url, '#title' =>
  strip_tags(Html::decodeEntities($link_text))]`, plus `#prefix`/`#suffix`.
- With `rewrite_output`: returns `['#markup' => sanitizeValue(tokenized rewrite, 'xss_admin')]`
  — i.e. filtered through the **admin** XSS filter (permits a broad tag/attribute set).
- `path` is run through `strip_tags()` (no HTML in paths) and parsed with `UrlHelper::parse`;
  malformed/empty results fall back to returning `link_text` unlinked.

## XSS responsibility (by design — not a module vulnerability)
Several options (`prefix`, `suffix`, `rewrite_output`, and via `xss_admin` the rewrite
output) intentionally accept admin-authored HTML. `xss_admin` blocks scripts but allows
rich markup; `prefix`/`suffix` are placed directly as render-array `#prefix`/`#suffix`.
Whoever configures the View is responsible for the safety of the markup and any token
values they inject. Restrict "administer views" accordingly. This is standard admin-markup
behavior (comparable to core's rewrite-results and Global Text area), not an access-boundary
bug.
