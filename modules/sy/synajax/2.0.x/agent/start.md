<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SynAjax (synajax) — agent index

**AJAX-only submission requirement** for core Contact forms — appends a validate handler that rejects any
contact POST lacking Drupal's `_drupal_ajax` flag, blocking naive bots that post without running JS. Version
**2.0.x**, core `^11 || ^12`. Package: Spam control. No dependencies (soft-targets `contact`), no permissions
of its own, no services/plugins/Drush.

- **Hook:** `synajax_form_contact_message_form_alter()` (`synajax.module`) → `FormContactMessageFormAlter::hook()`
  (`src/Hook/FormContactMessageFormAlter.php`). Adds `::formValidate` to `$form['#validate']` only when the
  form's submit action already has `#ajax` and the configured mode enables it. `formValidate` sets a form error
  if `\Drupal::request()->request->get('_drupal_ajax')` is empty.
- **Settings form:** `synajax.config` route → `Drupal\synajax\Form\SynajaxSettingsController` (extends
  `ConfigFormBase`), path `/admin/config/content/synajax`, permission `administer site configuration`. Menu
  link in `synajax.links.menu.yml` under `system.admin_config_content`.
- **Config object:** `synajax.settings` (default in `config/install/synajax.settings.yml`:
  `contact_message-mode: all`). Keys `contact_message-mode` (`disable`|`all`|`custom`) and
  `contact_message-bundles` (checkbox map for `custom`). No config/schema shipped.

Details: [config/settings.md](config/settings.md).

Caveats: stops naive non-JS bots only, not headless/determined spammers; requiring JS has no-JS/accessibility
impact — pair with CAPTCHA/honeypot/flood control. No access-control role.
