# CspReportingHandler plugin type

CSP defines one plugin type for deciding where/whether violation reports are sent.

- Plugin dir: `Plugin/CspReportingHandler`
- Interface: `Drupal\csp\Plugin\ReportingHandlerInterface`
- Base class: `Drupal\csp\Plugin\ReportingHandlerBase`
- Annotation: `@CspReportingHandler` (`id`, `label`, `description`)
- Manager: `plugin.manager.csp_reporting_handler`
  (`Drupal\csp\ReportingHandlerPluginManager`)

Bundled handlers: `none` (no reporting), `uri` (post reports to a configured URI),
`report-uri-com` (the report-uri.com SaaS, configured by subdomain).

## Interface
```php
public function getForm(array $form): array;  // config sub-form for the handler
public function validateForm(array &$form, FormStateInterface $form_state): void;
public function alterPolicy(Csp $policy): void; // add report-uri/report-to to the policy
```

## Implementing one
```php
namespace Drupal\my_module\Plugin\CspReportingHandler;

use Drupal\csp\Csp;
use Drupal\csp\Plugin\ReportingHandlerBase;

/**
 * @CspReportingHandler(
 *   id = "my_endpoint",
 *   label = @Translation("My endpoint"),
 *   description = @Translation("Send reports to my collector."),
 * )
 */
class MyEndpoint extends ReportingHandlerBase {

  public function alterPolicy(Csp $policy): void {
    $policy->setDirective('report-uri', 'https://reports.example.com/csp');
  }
}
```
The handler is selected per policy in the settings form; its options are stored under the
policy's `reporting.options` and validated against
`csp_reporting_handler.<plugin id>` config schema.
