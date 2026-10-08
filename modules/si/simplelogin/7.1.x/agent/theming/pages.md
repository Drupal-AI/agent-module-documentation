# Themed pages, template & path hook

## Which pages are affected

Only **anonymous** users, and only on these paths (`_simplelogin_is_path_supported()`):

```
/user
/user/login
/user/password
/user/register
```

On a match the module adds the `simplelogin` body class, chooses the
`page__simplelogin` theme suggestion, injects the background CSS, and rewrites the login/register/
password forms (placeholders, optional hidden labels, "Login to Account" button).

## Extend the path list — `hook_simplelogin_paths_alter()`

```php
/**
 * Implements hook_simplelogin_paths_alter().
 */
function mymodule_simplelogin_paths_alter(array &$paths) {
  $paths[] = '/user/sso';   // also style a custom SSO login path
}
```

## Page template

`templates/page--simplelogin.html.twig` renders the styled page. It receives extra variables
from `simplelogin_preprocess_simplelogin()`:

- `logo`, `site_name`, `site_slogan`
- `background_class` (`active`/''), `background_opacity`, `button_background`
- `wrapper_width`, `path`, `base_path`, `site_register`

**Override in a theme:** place your own `templates/page--simplelogin.html.twig` in the active
theme; `simplelogin_theme_registry_alter()` detects it and uses the theme's copy instead of the
module's.

## CSS

- Library `simplelogin/simplelogin-library` (`css/simplelogin.css`) is attached to the styled
  pages.
- Inline `<style>` (`simplelogin_background`) sets the background image/color and, when
  `button_background` is on, button/link colors.
- `simplelogin_css_alter()` removes stylesheets named in `unset_css`, and (if `unset_active_css`)
  strips the active theme's CSS from these pages.

## Form changes (`simplelogin_form_alter` / `simplelogin_element_info_alter`)

- `user_login_form`: submit button text becomes "Login to Account".
- `user_register_form`, `user_pass`: text/email/password/textarea fields get a `placeholder` from
  their title, descriptions are cleared, and labels are hidden when `visually_hidden_labels` is on.
- `password_confirm` elements also get placeholders and optional hidden labels.
