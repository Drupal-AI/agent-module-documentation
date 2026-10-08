# Theming — override generated markup

Icons and wrappers are rendered client-side by `Drupal.theme.extlink_*` functions, so there
are no Twig templates. Override a function from a theme/module JS file to change the markup:

```js
(function (Drupal) {
  Drupal.theme.extlink_fa_mailto = function (options) {
    return '<span class="fa fa-envelope custom-mailto"></span>';
  };
})(Drupal);
```

Overridable functions:
`extlink_extlink`, `extlink_mailto`, `extlink_tel` (image/label markup) and
`extlink_fa_extlink`, `extlink_fa_mailto`, `extlink_fa_tel` (Font Awesome markup).

CSS lives in `css/extlink.css`. To move it into your theme, add
`stylesheets-remove: [ extlink.css ]` to your theme `.info.yml` and copy the rules across.
