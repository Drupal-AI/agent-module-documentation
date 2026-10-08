# The `sms_gateway` plugin type (add a gateway)

SMS transport is a plugin. Real providers (Twilio, Vonage, Clickatell, …) ship as their own modules;
this project bundles only a `log` gateway for testing.

- **Manager service:** `plugin.manager.sms_gateway` (`Drupal\sms\Plugin\SmsGatewayPluginManager`)
- **Discovery:** annotated classes in any module's `src/Plugin/SmsGateway/`
- **Annotation:** `@SmsGateway` (`Drupal\sms\Annotation\SmsGateway`)
- **Interface:** `Drupal\sms\Plugin\SmsGatewayPluginInterface`
- **Base class:** `Drupal\sms\Plugin\SmsGatewayPluginBase` (extend this)
- **Alter hook:** `hook_sms_gateway_info_alter(&$gateways)`

A gateway *instance* is the `sms_gateway` config entity (`Drupal\sms\Entity\SmsGateway`, config
prefix `sms.gateway.`), created at `/admin/config/smsframework/gateways/add`. The entity holds the
chosen `plugin` id and its `settings` (a plugin collection). See
[configure/settings.md](../configure/settings.md) for the config entity fields.

## Annotation keys (capabilities)

| Key | Meaning |
|---|---|
| `id`, `label` | Plugin id / label. |
| `outgoing_message_max_recipients` | Max recipients per outgoing message (`-1` = unlimited). |
| `incoming` | Gateway can receive messages. |
| `incoming_route` | Auto-create a route to receive pushed inbound messages. |
| `schedule_aware` | Gateway can delay send until a message's `getSendTime()`. |
| `reports_pull` | Gateway can pull delivery reports (`getDeliveryReports()`). |
| `reports_push` | Gateway accepts delivery reports pushed to a site path. |
| `credit_balance_available` | Gateway supports `getCreditsBalance()` queries. |

`SmsGateway` entity helpers read these: `supportsIncoming()`, `autoCreateIncomingRoute()`,
`isScheduleAware()`, `supportsReportsPull()`, `supportsReportsPush()`, `supportsCreditBalanceQuery()`,
`getMaxRecipientsOutgoing()`.

## Interface methods to implement

```php
public function send(SmsMessageInterface $sms);                        // required — returns SmsMessageResultInterface
public function getCreditsBalance();                                    // optional (base returns NULL)
public function parseDeliveryReports(Request $request, Response $response); // optional (base returns [])
public function getDeliveryReports(?array $message_ids = NULL);         // optional (base returns [])
```

Plus `PluginFormInterface`/`ConfigurableInterface` (`defaultConfiguration()`,
`buildConfigurationForm()`, `validateConfigurationForm()`, `submitConfigurationForm()`,
`getConfiguration()`/`setConfiguration()`) for credential/settings fields, and
`calculateDependencies()`. To receive inbound messages, implement a `processIncoming(Request $request)`
returning an `Drupal\sms\SmsProcessingResponse` (its `setMessages()`/`setResponse()`); to react to
incoming after queueing, implement `Drupal\sms\Plugin\SmsGateway\SmsIncomingEventProcessorInterface`.

## Minimal example

```php
namespace Drupal\my_gw\Plugin\SmsGateway;

use Drupal\sms\Message\SmsMessageInterface;
use Drupal\sms\Message\SmsMessageResult;
use Drupal\sms\Message\SmsDeliveryReport;
use Drupal\sms\Message\SmsMessageReportStatus;
use Drupal\sms\Plugin\SmsGatewayPluginBase;

/**
 * @SmsGateway(
 *   id = "my_gw",
 *   label = @Translation("My Gateway"),
 *   outgoing_message_max_recipients = 1,
 *   reports_push = TRUE,
 * )
 */
class MyGateway extends SmsGatewayPluginBase {
  public function send(SmsMessageInterface $sms) {
    $result = new SmsMessageResult();
    foreach ($sms->getRecipients() as $number) {
      // ... call the provider API here ...
      $result->addReport((new SmsDeliveryReport())
        ->setRecipient($number)
        ->setStatus(SmsMessageReportStatus::QUEUED));
    }
    return $result;
  }
}
```

## Bundled `log` gateway

`Drupal\sms\Plugin\SmsGateway\LogGateway` (id `log`, `outgoing_message_max_recipients = -1`) writes
each message to the Drupal log and returns a DELIVERED result. It is installed by default
(`config/install/sms.gateway.log.yml`) and is the default `fallback_gateway`. It is a debug/testing
gateway, not a real transport.

## Inbound & report paths

When a gateway supports `incoming_route` / `reports_push`, a `RouteSubscriber` auto-registers routes
at the gateway's `incoming_push_path` / `reports_push_path`. Both paths are generated per gateway as
a random 128-bit value (`Crypt::randomBytesBase64(16)`) under `/sms/incoming/receive/…` and
`/sms/delivery-report/receive/…` when the gateway is created (`SmsGateway::preCreate()`), and can be
edited on the gateway form. The incoming controller passes the raw request to your plugin's
`processIncoming()`; the report controller passes it to `parseDeliveryReports()`. Give these URLs to
the provider as their webhook/callback target.
