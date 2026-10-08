# Transport plugin type

Defines the plugin type **SymfonyMailerLiteTransport** that produces Symfony Mailer transports.

- Manager: `plugin.manager.symfony_mailer_lite_transport`
  (`Drupal\symfony_mailer_lite\TransportManager`), dir `Plugin/SymfonyMailerLite/Transport`.
- Interface: `Drupal\symfony_mailer_lite\TransportPluginInterface` (base class `TransportBase`).
- Annotation: `@SymfonyMailerLiteTransport` (id, label, description, optional `warning`).
- Alter hook: `hook_symfony_mailer_lite_transport_info_alter()`.

Built-in plugins: `native`, `smtp`, `sendmail`, `null`, `dsn`
(`src/Plugin/SymfonyMailerLite/Transport/`).

## Add a transport type
```php
// src/Plugin/SymfonyMailerLite/Transport/MyTransport.php
namespace Drupal\my_module\Plugin\SymfonyMailerLite\Transport;

use Drupal\Core\Form\FormStateInterface;
use Drupal\symfony_mailer_lite\Plugin\SymfonyMailerLite\Transport\TransportBase;

/**
 * @SymfonyMailerLiteTransport(
 *   id = "my_transport",
 *   label = @Translation("My transport"),
 *   description = @Translation("Sends via my service."),
 * )
 */
class MyTransport extends TransportBase {
  public function defaultConfiguration() { return ['dsn' => '']; }
  public function buildConfigurationForm(array $form, FormStateInterface $form_state) {
    $form['dsn'] = ['#type' => 'textfield', '#title' => $this->t('DSN')];
    return $form;
  }
  public function submitConfigurationForm(array &$form, FormStateInterface $form_state) {}
}
```
Each configured transport is stored as a `symfony_mailer_lite_transport` config entity
(`src/Entity/Transport.php`). `TransportsFactory` builds the runtime
`Symfony\Component\Mailer\Transport\Transports`; the `symfony_mailer_lite.mailer` service exposes
`Symfony\Component\Mailer\MailerInterface`.
