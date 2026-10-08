# Helper API

The module exposes plain static helper classes (no registered services except a no-op
route subscriber). Namespace: `Drupal\uikit_components`.

## `UIkitComponents` (`src/UIkitComponents.php`)
Static utility methods used by the module's own preprocess/forms; also usable from theme
or module code.

| Method | Returns | Purpose |
|--------|---------|---------|
| `getUIkitLibraryVersion()` | string\|FALSE | Reads the installed `uikit` theme's `uikit.libraries.yml` version; sets an error message if the theme isn't installed. |
| `getRenderElementList()` | array | The list of UIkit component short-names registered as `uikit_<name>` theme hooks (36 names; 11 have shipped element classes/templates). |
| `getComponentURL($component)` | string\|FALSE | Builds `https://getuikit.com/docs/<component>`. |
| `loadIncludeFile($type, $project, $project_type='module', $name=NULL, $sub_directory='')` | string\|FALSE | `module_load_include()`-style loader that also targets theme include files in a sub-directory. |
| `getMenuStyle($menu)` / `setMenuStyle($menu,$value)` | mixed / void | Read/write state key `<menu>_menu_style`. |
| `getLargeList($menu)` / `setLargeList($menu,$value)` | mixed / void | State key `<menu>_menu_style_list_large`. |
| `getNavStyleModifier($menu)` / `setNavStyleModifier($menu,$value)` | mixed / void | State key `<menu>_menu_style_nav_style_modifiers`. |
| `getNavCenterModifier($menu)` / `setNavCenterModifier($menu,$value)` | mixed / void | State key `<menu>_menu_style_nav_center_modifier`. |
| `getNavWidthClasses($menu)` / `setNavWidthClasses($menu,$value)` | mixed / void | State key `<menu>_menu_style_wrapper_widths`. |

The `get*` menu helpers return `0` when the state value is empty. All menu styling is
stored in **Drupal state** (`\Drupal::state()`), not config.

```php
use Drupal\uikit_components\UIkitComponents;

$style = UIkitComponents::getMenuStyle('main');       // e.g. 'uk-nav' or 0
UIkitComponents::setMenuStyle('main', 'uk-subnav-pill');
```

## `ImageStyleRenderer` (`src/ImageStyleRenderer.php`)
Helpers that build `#theme => 'image_style'` render arrays.

- `ImageStyleRenderer::loadImageManagedFile($build)` — expects `$build['uri']` and
  `$build['style_name']`; queries the `file` entity (access-checked) for a managed file
  at that URI, resolves width/height via the `image.factory` service, adds the file as a
  cacheable dependency, and returns a render array. Returns `[]` if no file matches.
- `ImageStyleRenderer::loadImageFile($build)` — returns a bare
  `#theme => 'image_style'` array for an arbitrary `uri` + `style_name` (no managed-file
  lookup).

## `MimeStreamWrapper` (`src/MimeStreamWrapper.php`)
A minimal PHP stream wrapper (`mime://`) used by `template_preprocess_uikit_video()` to
determine a video source's MIME type without cURL. `setPath($url)` opens the source
(`fopen`, or `get_headers()` for size), `getStreamPath()` rewrites `http(s)://`/`ftp://`
to `mime://`, and `getContext()` registers the wrapper and returns a stream context so
`finfo` can read the MIME type from a local or remote source. It only reads bytes to
sniff the MIME type of URLs the themer put in a `uikit_video` element's
`#video_sources`.

## `RouteSubscriber` (`src/Routing/RouteSubscriber.php`)
Service `uikit_components.route_subscriber` (tagged `event_subscriber`). Its
`alterRoutes()` is currently empty — a placeholder, no routes are modified.

## Hooks this module implements (for integrators)
Defined across the `.module` file and `includes/*.inc`:
- `hook_help()`, `hook_theme()`
- `hook_theme_suggestions_menu_alter()`, `hook_entity_type_alter()`
- `hook_form_BASE_FORM_ID_alter()` for `menu_link_content_form` and `block_form`

See [theme/menu-styles.md](../theme/menu-styles.md) for what each alter hook does and the
storage keys involved.
