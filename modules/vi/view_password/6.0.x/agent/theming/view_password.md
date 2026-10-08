# Theming — libraries, JS toggle & icons

## Libraries (`view_password.libraries.yml`)

| Library | Assets | Used on |
|---|---|---|
| `view_password/pwd_lb` | `css/password.css`, `js/password.js`; deps `core/jquery`, `core/once`, `core/drupal`, `core/drupalSettings` | Attached by `hook_form_alter()` to each configured front-end form. |
| `view_password/pwd_lb_backend` | `css/password_backend.css` | Attached by the settings form (`PasswordSettingsForm::buildForm`) so the icon preview renders in admin. |

## The JS toggle (`js/password.js`)

`Drupal.behaviors.pwd` runs once (via `core/once`) per matching field:

1. Finds `.pwd-see [type=password]` (the `pwd-see` class is added only to configured forms)
   and inserts a `<button type="button" class="shwpd {span_classes} eye-close" aria-label="{showPasswordLabel}">` after each password input.
2. On click it `toggleClass('eye-close eye-open')`, then:
   - if now `eye-open`: sibling `:password` → `type="text"`, `aria-label` = **Hide password**,
     optional custom `icon_exposed` background image;
   - if now `eye-close`: sibling `:text` → `type="password"`, `aria-label` = **Show password**,
     optional custom `icon_hidden` background image.

`drupalSettings.view_password` carries `span_classes`, `icon_exposed`, `icon_hidden`,
`showPasswordLabel`, `hidePasswordLabel` from the config.

## CSS classes & icons

`css/password.css` styles `.eye-open` / `.eye-close` (16×24px, background SVG) and
`button.shwpd` (borderless, `margin-left: -2em` so it overlaps the field's right edge,
`cursor: pointer`). Default icons ship at `css/images/eye-open.svg` and
`css/images/eye-close.svg`. Override them per-site without touching CSS by setting the
`icon_exposed` / `icon_hidden` config paths (root-relative, leading `/`), which are applied
as inline `background-image` by the JS.

## Accessibility

The toggle is a real `<button type="button">` with an `aria-label` that flips between
"Show password" and "Hide password" as the state changes (both labels are translatable via
`t()` in `view_password_form_alter()`).

To restyle the button, add classes through the `span_classes` setting (they are appended to
the button's class list) rather than editing module CSS.
