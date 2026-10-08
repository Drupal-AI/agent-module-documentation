# SMS Framework — the `sms_gateway` plugin type

The one plugin type this module defines. A gateway plugin talks to a specific SMS provider.

- **Annotation:** `Drupal\sms\Annotation\SmsGateway` (`@SmsGateway`).
- **Manager:** `plugin.manager.sms_gateway` (`SmsGatewayPluginManager`), discovers
  `src/Plugin/SmsGateway/*`.
- **Base class:** `Drupal\sms\Plugin\SmsGatewayPluginBase` (implements
  `SmsGatewayPluginInterface`, which extends `ConfigurableInterface`, `PluginFormInterface`,
  `DependentPluginInterface`, `PluginInspectionInterface`).
- **Bundled example:** `LogGateway` (id `log`) — logs the message and returns a DELIVERED
  result for every recipient.

## Annotation keys (`SmsGateway`)

| Key | Meaning |
|---|---|
| `id`, `label` | Machine id / human label. |
| `outgoing_message_max_recipients` | Max recipients per outgoing message (`-1` = unlimited). |
| `incoming` | Gateway can receive messages. |
| `incoming_route` | Auto-create a route to receive incoming messages (uses gateway's `incoming_push_path`). |
| `schedule_aware` | Gateway can delay messages to a send time (reads `SmsMessage::getSendTime()`). |
| `reports_pull` | Supports pulling delivery reports. |
| `reports_push` | Can handle delivery reports pushed to the site (enables the report route + access check). |
| `credit_balance_available` | Supports credit-balance queries. |

## Interface methods to implement

- `send(SmsMessageInterface $sms): SmsMessageResultInterface` — **required**; actually transmit
  and return per-recipient reports.
- `getCreditsBalance()` — return float balance or NULL (base returns NULL).
- `parseDeliveryReports(Request $request, Response $response)` — turn a pushed report request
  into `SmsDeliveryReportInterface[]` (base returns `[]`).
- `getDeliveryReports(?array $message_ids = NULL)` — pull reports (base returns `[]`).
- Config form: `defaultConfiguration()`, `buildConfigurationForm()`, `validateConfigurationForm()`,
  `submitConfigurationForm()` — where the provider's API key/endpoint fields live.
- Optional incoming handling: implement `processIncoming(Request $request, Response $response):
  SmsProcessingResponse` (invoked by `SmsIncomingController` on the incoming route).

## Minimal skeleton

```php
namespace Drupal\my_gateway\Plugin\SmsGateway;

use Drupal\sms\Message\SmsMessageInterface;
use Drupal\sms\Message\SmsMessageResult;
use Drupal\sms\Message\SmsDeliveryReport;
use Drupal\sms\Message\SmsMessageReportStatus;
use Drupal\sms\Plugin\SmsGatewayPluginBase;

/**
 * @SmsGateway(
 *   id = "my_provider",
 *   label = @Translation("My Provider"),
 *   outgoing_message_max_recipients = 100,
 *   reports_push = TRUE,
 * )
 */
class MyProviderGateway extends SmsGatewayPluginBase {
  public function send(SmsMessageInterface $sms) {
    $result = new SmsMessageResult();
    foreach ($sms->getRecipients() as $number) {
      // ...call provider API with $this->configuration['api_key'] etc...
      $result->addReport((new SmsDeliveryReport())
        ->setRecipient($number)
        ->setStatus(SmsMessageReportStatus::QUEUED));
    }
    return $result;
  }
}
```

Then create a `sms_gateway` config entity selecting this plugin (see
[../configure/gateways-and-settings.md](../configure/gateways-and-settings.md)).

## Security responsibility (incoming / report webhooks)

If your gateway sets `incoming_route`/`reports_push`, `RouteSubscriber` creates a **public**
POST route at the gateway's configured path (`_access: TRUE` for incoming). SMS Framework does
NOT authenticate these callbacks — your `processIncoming()` / `parseDeliveryReports()` MUST
validate the provider's signature/shared-secret before trusting the payload, or an attacker can
forge inbound messages / reports. See [../permissions/permissions.md](../permissions/permissions.md).
