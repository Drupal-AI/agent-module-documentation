# Libraries & front-end behavior

Defined in `clientside_validation_jquery.libraries.yml`.

| Library | JS | Notes |
|---|---|---|
| `jquery.validate` | `/libraries/jquery-validation/dist/jquery.validate.min.js` | The vendor engine; path rewritten by `hook_library_info_alter()` (local → module → CDN). Depends on `core/drupal`, `core/once`, `core/drupalSettings`, `core/jquery`. |
| `jquery.validate.additional` | `additional-methods.min.js` | Extra vendor methods. |
| `cv.jquery.validate` | `js/cv.jquery.validate.js` | Drupal glue that binds jQuery Validate to forms; attached to **every** validator via the info-alter hook. |
| `cv.pattern.method` | `js/cv.pattern.method.js` | Registers the `pattern` method; attached by the `pattern` validator. |
| `cv.jquery.ckeditor` | `js/cv.jquery.ckeditor.js` | CKEditor integration; added when `ckeditor` is enabled. |
| `cv.jquery.ife` | `js/cv.jquery.ife.js` | Inline Form Errors integration; added when `inline_form_errors` is enabled. |

## How the engine attaches itself

`clientside_validation_jquery_clientside_validation_validator_info_alter()` appends
`cv.jquery.validate` (and, conditionally, `cv.jquery.ckeditor` / `cv.jquery.ife`) to **every**
`CvValidator` plugin's `attachments.library`. So any element that gets a validation rule also pulls
in the engine — no per-form theming needed.

## Front-end knobs (classes & drupalSettings)

- Add class **`cv-validate-before-ajax`** to an AJAX form to have it validated before its AJAX
  submit (respects the `validate_all_ajax_forms` setting).
- Submit buttons with an empty `#limit_validation_errors` receive the **`cancel`** class (added by
  the base module) so jQuery Validate skips them.
- `drupalSettings.clientside_validation_jquery` carries `validate_all_ajax_forms`,
  `force_validate_on_blur`, `force_html5_validation`, and default translated `messages`
  (required, email, url, number, digits, equalTo, maxlength, minlength, range, max, min, step, …).
- `hook_js_alter()` bumps the CKEditor-integration JS weight so it loads just after `ckeditor.js`.
