<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# synhelper — hook implementations

`synhelper.module` wires Drupal hooks to small classes in `src/Hook/` (each with a static `hook()`), plus a
few closures. All behavior below is driven by `synhelper.settings` config.

## SEO / no-index
- `hook_preprocess_html()` → `Hook\PreprocessHtml`: adds a `robots: none` meta tag on fixed paths
  (`/user/login`, `/user/password`, `/policy`, `/policy/ru`, `/policy/en`), when `no-index` is on, or when
  `no-index-1c` is on and the host starts with `1c.`. Also calls `attachYandexMetricCode()`.
- `hook_requirements()` → `Hook\Requirements`: runtime status-report row reflecting the indexing state
  (WARNING when indexed, ERROR when `no-index` is set), linking to the settings form.

## Yandex Metrica & Ecommerce
- `PreprocessHtml::attachYandexMetricCode()`: injects the Metrica `tag.js` snippet for counter `ya-counter`
  into `page_bottom`, only when no `synapse.settings:gtm-id` is set, the path is not under `/admin/`, and the
  user is not user 1. Optional ecommerce `dataLayer` init when `ya-ecommerce` is on.
- `hook_preprocess_page()` → `Hook\PreprocessPage`: exposes `drupalSettings.metrika` (ya-counter, gtm, ga4),
  sets `footer_policy` when `fz152` is on, and builds the cookie-agreement text/link (via
  `RelativeInternalUrl::fromConfigOrDefault`, default `/policy`).
- `hook_page_attachments()`: attaches the `synhelper/agreement` library when `enable-cookies` is on, and the
  `drupalSettings.synhelper.ecommerce` payload from `YandexEcommerceBuilder` when enabled.
- `hook_library_info_alter()` / `hook_syncart_variation_alter()`: add the `synhelper/yandex-ecommerce` library
  to `syncart` cart libraries and attach ecommerce data to cart variations when enabled.

## FZ-152 / GDPR consent
- `hook_form_alter()` → `Hook\FormAlter`: adds a required `fz152_agreement` checkbox to `user_register_form`
  when `fz152` is on, with a link built from `RelativeInternalUrl::fromConfigOrDefault($config->get('link'))`.
- `hook_contact_message_*` handling → `Hook\FormContactMessageFormAlter` (called from
  `hook_form_contact_message_*_alter` / form_alter for `contact_message*` forms): adds the consent checkbox and
  a `CustomContactFormValidate` validator that errors if the box is unchecked; rewires the contact AJAX submit
  callback to fire Yandex `reachGoal` for the matching `ya-goals` line (`goal|form_id`) and a `dataLayer.push`;
  optionally shows the form id as a status message when `show-ids` is on; pre-fills the order form's hidden
  "zakaz" field with the current node id + title.

## Contact / mail
- `hook_contact_message_presave()` → `Hook\ContactMessagePresave` → `ContactMessageNormalizer::normalize()`.
- `hook_contact_form_presave()` → `Hook\ContactFormPresave`; `hook_form_contact_mail_settings_alter` →
  `Hook\FormContactMailSettingsAlter`.
- `hook_phpmail_alter_from_alter()` → `Hook\PhpmailAlterFromAlter`: sets the PHP mail From header.

## Files & assets
- `hook_file_validate` handler → `Hook\FileValidate`: transliterates and re-slugs the upload destination via
  `\Drupal::transliteration()` and `FileSystem::createFilename()` (spaces → `_`, lowercased).
- `hook_css_alter()` → `Hook\CssAlter`: embeds CSS as `<link>` elements.

## Commerce & node display
- `hook_preprocess_commerce_product()` → `Hook\PreprocessCommerceProduct`.
- `hook_form_commerce_checkout_flow_multistep_default_alter` → `Hook\FormCommerceCheckoutFlowMultistepDefaultAlter`.
- `hook_node_presave()` → `Hook\NodePresave`; `hook_form_node_form_alter` → `Hook\FormNodeFormAlter`.

## Administrator guidance (intentional UX interference)
- `hook_modules_installed()` → `Hook\ModulesInstalled`.
- `hook_form_update_manager_install_form_alter` → `Hook\FormUpdateManagerInstallFormAlter` (warns/limits the
  UI module-update flow).
- `hook_form_field_ui_field_storage_add_form_alter`, `hook_form_node_type_add_form_alter`,
  `hook_form_field_config_edit_form_alter`, `hook_form_menu_edit_form_alter` → the corresponding `Hook\Form*`
  classes pre-fill defaults / adjust admin forms.

## Migrate
- `src/Utility/MigrationsSourceBase.php` (namespace `Drupal\migration`) is a `SourcePluginBase` subclass
  scaffold keyed by `uuid`; it fetches rows on construct and logs debug output when `devel` is present. Not a
  registered plugin type of this module.
