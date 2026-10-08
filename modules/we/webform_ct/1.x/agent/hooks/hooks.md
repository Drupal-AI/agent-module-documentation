<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks and mechanism (webform_ct)

The whole module is procedural — no `src/`, no services, no routes, no plugins, no drush. It is four
hook implementations plus one update hook, all in `webform_ct.module` / `webform_ct.install`.

## `webform_ct_help()` — `webform_ct.module:17`

Implements `hook_help()`. For route `help.page.webform_ct` it returns the module `README.md`. If the
`markdown` module is enabled it renders it through the `markdown` filter plugin
(`plugin.manager.filter`); otherwise it returns `'<pre>' . Html::escape($text) . '</pre>'`.

## `webform_ct_form_webform_settings_confirmation_form_alter()` — `webform_ct.module:43`

Implements `hook_form_FORM_ID_alter()` for form id `webform_settings_confirmation_form` (base form
`webform_form`; form object `WebformEntitySettingsConfirmationForm`). It:

- adds a warning message about the `page`/`inline`-only limitation;
- adds a `details` element `confirmation_custom_javascript` containing a `webform_codemirror`
  JavaScript field, `#access`-gated on
  `webform_ct.administer_webform_confirmation_javascript`, `#default_value` = the current
  third-party setting, `#states`-hidden unless the confirmation type is `page`/`inline`;
- appends `_webform_ct_form_validate` to `$form['#validate']`.

See [../configure/confirmation-javascript.md](../configure/confirmation-javascript.md).

## `_webform_ct_form_validate()` — `webform_ct.module:91`

Not a hook — the extra validate callback registered above. Reads
`$form_state->getValue('confirmation_custom_javascript')` and writes it to the webform third-party
setting `webform_ct.confirmation_custom_javascript`. Because the field is `#access`-gated, a user
without the permission cannot submit a value for it — Drupal's Form API falls back to the element
`#default_value` (the existing stored value) for inaccessible elements, so such a submit re-stores
the current value unchanged.

## `webform_ct_preprocess_webform_confirmation()` — `webform_ct.module:113`

Implements `hook_preprocess_HOOK()` for the `webform-confirmation.html.twig` template. When the
webform's `confirmation_custom_javascript` third-party setting is non-empty it:

1. ensures `$variables['message']['#markup']` is a string;
2. re-runs the existing message markup through `Xss::filter(..., $allowed_tags)` +
   `Html::normalize()`;
3. adds `'script'` to `$variables['message']['#allowed_tags']`;
4. appends the stored `confirmation_custom_javascript` string to `$variables['message']['#markup']`.

The result is that the stored script is emitted inside the confirmation message. Only the `page` and
`inline` confirmation types render this template, which is why the feature is limited to those types.

## `webform_ct_update_8001()` — `webform_ct.install:11`

Update hook. Iterates all webform entities and wraps each existing
`webform_ct.confirmation_custom_javascript` value in `<script>…</script>` (migration from an earlier
format where the stored value did not include the tags), then saves each webform.
