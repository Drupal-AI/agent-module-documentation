# The SOAP client service

## `salesforce.soap_client`

`Drupal\salesforce_soap\Soap\SoapClient` — wraps the force.com PHP toolkit's partner SOAP
client. Constructor arg: `plugin.manager.salesforce.auth_providers`, so it authenticates with
the same authorization system as the REST client.

```php
/** @var \Drupal\salesforce_soap\Soap\SoapClient $soap */
$soap = \Drupal::service('salesforce.soap_client');
// use it for SOAP (Partner API) operations not covered by the REST client
```

Inject it in your own service:
```yaml
services:
  my_module.thing:
    class: Drupal\my_module\Thing
    arguments: ['@salesforce.soap_client']
```

## Auth

The SOAP client authenticates using the suite's default authorization
(`salesforce.settings.salesforce_auth_provider`) or a specific `salesforce_auth` entity —
OAuth or JWT — the same as REST. There is no SOAP-specific auth configuration.

## Requirements & notes

- Needs the PHP `ext-soap` extension.
- No config, permissions, plugins, or Drush are provided by this module.
- Real calls require a live Salesforce authorization; selecting which authorization the SOAP
  client uses is done through the suite's default-provider setting (local config).
