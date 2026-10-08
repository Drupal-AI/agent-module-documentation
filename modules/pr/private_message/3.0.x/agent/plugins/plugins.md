<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Message — plugins

## Plugin type it defines: `private_message_config_form`

The module owns one plugin type, used to build the settings page at
`/admin/config/private-message/config` in sections. Other modules can add their own section.

- Manager service: `private_message.private_message_config_form_manager`
  (`PrivateMessageConfigFormManager`, extends `DefaultPluginManager`).
- Discovery directory: `Plugin/PrivateMessageConfigForm`.
- Annotation: `@PrivateMessageConfigForm` (`Drupal\private_message\Annotation\PrivateMessageConfigForm`)
  with keys `id` and `name` (translatable).
- Interface: `Plugin\PrivateMessageConfigForm\PrivateMessageConfigFormPluginInterface`
  (extends `PluginInspectionInterface`, `ContainerFactoryPluginInterface`).
- Base class: `Plugin\PrivateMessageConfigForm\PrivateMessageConfigFormBase`.
- Alter hook: `hook_private_message_config_form_info_alter()`. Cache key `private_message_config_form`.

Required methods: `getName()`, `getId()`, `buildForm(FormStateInterface $formState): array`,
`validateForm(array &$form, FormStateInterface $formState): void`,
`submitForm(array $values)`.

### Implement one
```php
// src/Plugin/PrivateMessageConfigForm/MyPmSection.php
namespace Drupal\my_module\Plugin\PrivateMessageConfigForm;

use Drupal\private_message\Plugin\PrivateMessageConfigForm\PrivateMessageConfigFormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * @PrivateMessageConfigForm(
 *   id = "my_pm_section",
 *   name = @Translation("My section"),
 * )
 */
class MyPmSection extends PrivateMessageConfigFormBase {
  public function buildForm(FormStateInterface $formState) {
    return ['my_setting' => ['#type' => 'textfield', '#title' => $this->t('My setting')]];
  }
  public function submitForm(array $values) { /* persist $values['my_setting'] */ }
}
```
The section is auto-discovered and rendered on the config page; no routing needed.

## Plugins it provides for other subsystems

- **Blocks** (`Plugin/Block/`): `private_message_inbox_block`,
  `private_message_notification_block`, `private_message_actions_block` (see configure doc).
- **Rules action** (`Plugin/RulesAction/SendPrivateMessage`, id `private_message_send_message`)
  — send a private message from a Rules reaction (requires the `rules` module).
- **EntityReferenceSelection** (`Plugin/EntityReferenceSelection/NotBlockedUserSelection`,
  extends core user selection) — excludes users who have banned the current user from
  recipient autocomplete.
- **Field formatters / widget** (`Plugin/Field/…`) — thread message + member formatters and
  the member autocomplete widget (see configure doc).
- **Views plugins** (`Plugin/views/…`): filters `PrivateMessageThreadIsUnread`,
  `PrivateMessageThreadCleanHistory`; fields `PrivateMessageThreadNewMessagesCount`,
  `PrivateMessageThreadHasNewMessage`, `PrivateMessageThreadMessagesCount`.
- **Validation constraints**: `UniqueBanConstraint`, `PrivateMessageThreadMemberConstraint`.
- **Menu plugin**: `Plugin/Menu/PrivateMessageTab`.

Only `private_message_config_form` is a *module-defined plugin type*; the rest implement core
plugin types.
