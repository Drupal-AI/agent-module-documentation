# Configuration

Nothing is exposed until you create at least one SOAP endpoint. SOAP Manager is
managed from two places under **Configuration → Web services**: the endpoint list
(**SOAP Endpoints**) and the module‑wide options (**SOAP Endpoint Settings**).

## Create a SOAP endpoint

1. Go to **Administration → Configuration → Web services → SOAP Endpoints** to
   view and manage your endpoints.
2. Click **Add SOAP endpoint** to create a new one.
3. Configure the endpoint with a **name**, a **path**, and a **description**. The
   path is where the service will live — for example `/soap/my-service`.
4. **Enable the SOAP resources** you want to expose through this endpoint. These
   are the operations available at the endpoint; the list includes any custom
   resource plugins that developers have added (see below).
5. Configure **authentication settings** if the endpoint should be secured with
   Drupal authentication rather than left open.
6. **Save** the endpoint.

Your endpoint is then available at the path you specified (e.g.
`/soap/my-service`), and its WSDL document is served at that path with `?wsdl`
appended (`/soap/my-service?wsdl`). If you prefer, you can supply your own custom
WSDL file instead of the auto‑generated one.

## Global settings

Visit **Administration → Configuration → Web services → SOAP Endpoint Settings**
for module‑wide options. This is where you tune the security‑oriented settings
described in the module's documentation — **request timeouts**, **rate limiting**,
and **maximum request sizes** — which apply across your endpoints. Set these
sensibly before exposing an endpoint publicly, since they are your first line of
defence against oversized or abusive requests.

## Logging

SOAP Manager logs SOAP requests, responses, and errors in detail, so you can
review traffic and troubleshoot integration problems after your endpoints go
live.

## For developers: custom SOAP resources

The endpoint "resources" you enable are plugins. To add your own operations,
implement a plugin class with the `@SoapResource` annotation and a
`processRequest()` method, and place it in your module's
`src/Plugin/SoapResource` directory. It then appears as an enable‑able resource
when you configure an endpoint. See the module's README for the full example.
