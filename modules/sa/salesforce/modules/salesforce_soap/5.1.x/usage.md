Salesforce Soap exposes a `salesforce.soap_client` service that wraps the Salesforce SOAP (Partner) API, for the cases the REST client does not cover, reusing the suite's auth providers.

---

The module adds one service, `salesforce.soap_client` (`Drupal\salesforce_soap\Soap\SoapClient`), which wraps the force.com PHP toolkit's partner SOAP client and authenticates using the suite's auth-provider plugin manager (`plugin.manager.salesforce.auth_providers`) — the same `salesforce_auth` authorization (and default `salesforce.settings.salesforce_auth_provider`) used by REST. It has **no configuration, permissions, plugins, or Drush of its own**; it is purely a service for code that needs SOAP-only operations (certain metadata/bulk/describe calls not available or convenient over REST). Actual calls require the `ext-soap` PHP extension and a live Salesforce authorization; which authorization is used is the suite's default-provider config. Depends on `salesforce`.

---

- Call the Salesforce SOAP (Partner) API from Drupal code.
- Use SOAP-only operations not exposed by the REST client.
- Reuse the same Salesforce authorization for SOAP as for REST.
- Inject `salesforce.soap_client` into a custom service.
- Authenticate SOAP calls via the suite's default auth provider.
- Perform partner-API describe/metadata calls over SOAP.
- Bridge legacy SOAP-based integrations into the suite.
- Keep SOAP and REST auth unified under one authorization.
- Add SOAP capability without extra configuration.
- Depend on ext-soap for SOAP transport.
- Use SOAP for operations requiring the partner WSDL.
- Switch the SOAP client's org by changing the default auth provider.
- Combine SOAP calls with mapping/push/pull where needed.
- Access the force.com toolkit's SoapClient via a Drupal service.
- Fall back to SOAP for edge-case API needs.
- Build custom bulk/metadata tooling on SOAP.
- Authenticate SOAP with OAuth or JWT authorizations.
- Keep the SOAP client stateless and auth-provider driven.
- Provide SOAP support for modules that require it.
- Use one service to reach the Salesforce SOAP endpoint.
