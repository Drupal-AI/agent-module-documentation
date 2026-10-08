# Salesforce Soap — agent index

Exposes one service, **`salesforce.soap_client`** (`SoapClient`), wrapping the Salesforce SOAP
(Partner) API for operations the REST client does not cover. It authenticates with the same
auth-provider system as REST. **No config, permissions, plugins, or Drush of its own** — it is
a pure service shim. Depends on `salesforce`; needs the `ext-soap` PHP extension.

- **The SOAP client service** →
  [api/soap.md](api/soap.md)

Key facts:
- Service `salesforce.soap_client` → `Drupal\salesforce_soap\Soap\SoapClient`, constructed with
  `plugin.manager.salesforce.auth_providers`.
- Uses the suite's default authorization (`salesforce.settings.salesforce_auth_provider`) /
  a `salesforce_auth` entity, exactly like the REST client.
- Because it has no config of its own, the only local, verifiable state relevant to it is the
  default auth provider the SOAP client will authenticate with — that is what the eval cases
  exercise.
- Real SOAP calls need `ext-soap` and a live Salesforce authorization.
