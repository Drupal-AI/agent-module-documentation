# Configure Choices.js

Settings form: `\Drupal\choices\Form\ConfigForm` at `/admin/config/user-interface/choices`
(route `choices.admin`, permission `administer site configuration`). Config object: `choices.settings`.

## Settings keys (config object `choices.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enable_globally` | bool | `false` | Master switch for the global (selector-based) mode. |
| `css_selector` | string | `select[multiple]` | Newline/whitespace-separated CSS selectors Choices attaches to globally. Collapsed to a comma list at render (`preg_replace('/\s\s+/', ',', …)`). Required when the form is submitted. |
| `include` | int | `2` | Where global mode runs: `2` everywhere, `0` admin routes only, `1` front-end only. Decided by `router.admin_context` at render. |
| `configuration_options` | string | `''` | JSON object of [Choices options](https://github.com/Choices-js/Choices#configuration-options), merged with defaults. Applied to BOTH global and widget instances. |
| `use_cdn` | bool | `false` | Load the library from jsDelivr CDN instead of local `/libraries/choices.js/`. |

Defaults ship in `config/install/choices.settings.yml`. `css_selector`, `include` and
`configuration_options` are only visible/active when `enable_globally` is checked (form `#states`).

## JSON options validation

`configuration_options` is validated with `justinrainbow/json-schema` against `{"type":"object"}` only —
any syntactically valid JSON **object** is accepted; individual Choices keys are NOT validated. Empty
string is allowed (uses defaults). Same validation runs on the field-widget setting.

## Library loading: local vs CDN

- Library `choices/library` (in `choices.libraries.yml`) references local assets:
  `/libraries/choices.js/public/assets/scripts/choices.min.js` + `.../styles/choices.min.css`.
- `hook_library_info_alter()` (`choices_library_info_alter`) — when `use_cdn` is TRUE — unsets the local
  entries and adds external jsDelivr URLs (`https://cdn.jsdelivr.net/npm/choices.js/...`).
- On save, the form invalidates the `library_info` cache tag so the swap takes effect.
- Self-host by installing `bower-asset/choices.js` (Composer, needs asset-packagist) or dropping the
  library at `/libraries/choices.js/`.

## Set config with Drush

```bash
ddev drush cset choices.settings enable_globally 1 -y
ddev drush cset choices.settings css_selector 'select[multiple], .choices-select' -y
ddev drush cset choices.settings include 2 -y
ddev drush cset choices.settings use_cdn 1 -y
```
