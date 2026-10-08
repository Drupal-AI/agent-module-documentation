<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Izi Message (izi_message) — agent index

Restyles Drupal's core status/warning/error messages as iziToast pop-up toasts.
It overrides the `status_messages` render element so every message the messenger
holds is popped as a toast instead of printed in the page's message region.
No module dependencies; core `^9.3 || ^10 || ^11`, package `User interface`.

Requires the third-party **iziToast** JS library (v1.4.0) unpacked at
`/libraries/iziToast/` — `hook_requirements` marks the module in error until
`libraries/iziToast/dist/js/iziToast.min.js` exists.

Configure at `/admin/config/development/izi_message/settings`
(route `izi_message.settings`, permission `administer site configuration`).
No permissions of its own, no drush, no plugin types. Ships a config schema.

- **Change toast position, timeout, theme, animations, close behaviour** → [configure/settings.md](configure/settings.md)
- **Understand / override how messages become toasts (theme hook + JS)** → [theme/messages.md](theme/messages.md)

Key facts:
- Config object: `izi_message.settings` (schema in `config/schema/izi_massage.schema.yml` — note the misspelled filename; the config key itself is correct).
- Route / configure: `izi_message.settings` → `\Drupal\izi_message\Form\IziMessageSettingsForm`.
- Render override: `hook_element_info_alter` sets `status_messages['#pre_render']` to `\Drupal\izi_message\IziMessage::generatePlaceholder`; the lazy builder is `\Drupal\izi_message\IziMessage::renderMessages`.
- Theme hook: `izi_message` (template `templates/izi-message.html.twig`, vars `children`, `message_list`).
- Library: `izi_message/izi_message` (depends on `izi_message/iziToast`); behavior `Drupal.behaviors.iziMessage` in `js/izi_message.js`.
- `hook_preprocess_page` exposes settings as `drupalSettings.iziMessage`.
- Help page uses the `markdown` filter if the `markdown` module is present, else `src/Utility/HelpTemplate.php`.
