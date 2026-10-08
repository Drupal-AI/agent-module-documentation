XML-RPC restores the XML-RPC client and server that Drupal core removed in Drupal 8, letting the site both call remote XML-RPC methods and expose its own methods to external clients over the classic XML-RPC protocol.

---

The module ships a procedural library (`xmlrpc.inc`) plus a small server controller. As a **client**, code calls `xmlrpc($url, ['method.name' => [$args]])` to POST a `methodCall` to a remote endpoint and get the decoded return value; passing more than one method triggers a `system.multicall`. As a **server**, the module registers a single unauthenticated route `/xmlrpc` (`_access: 'TRUE'`, POST only) that dispatches incoming `methodCall` requests. Out of the box the server only answers the built-in introspection methods (`system.listMethods`, `system.methodSignature`, `system.methodHelp`, `system.getCapabilities`, `system.multicall`); real application methods are contributed by other modules through `hook_xmlrpc()` (with `hook_xmlrpc_alter()` to modify them). Requests are parsed with PHP's expat SAX parser (`xml_parser_create()`/`xml_parse()`), which does not resolve external entities, and the dispatcher only calls callbacks that were explicitly registered — an incoming `methodName` cannot invoke an arbitrary PHP function. The module has no admin UI, no permissions, no config, and no Drush commands; a bundled `xmlrpc_example` submodule demonstrates building a client and a server. Values are represented as typed objects (`xmlrpc_value`, `xmlrpc_date`, `xmlrpc_base64`) and serialized to the XML-RPC wire types (int, double, boolean, string, array, struct, date, base64).

---

- Call a remote XML-RPC endpoint from Drupal and get the decoded response (`xmlrpc()`).
- Perform several remote calls in one round trip via `system.multicall`.
- Consume a legacy XML-RPC web service (blog ping, pingback, MetaWeblog-style APIs, etc.).
- Expose custom server-side methods to external clients by implementing `hook_xmlrpc()`.
- Register a method with a full signature (return type + parameter types) so the server type-checks arguments.
- Add a help string for a method, surfaced through `system.methodHelp`.
- Let clients discover available methods with `system.listMethods` and `system.getCapabilities`.
- Alter or replace another module's registered XML-RPC methods with `hook_xmlrpc_alter()`.
- Migrate a Drupal 7 site that relied on core XML-RPC to Drupal 10/11 without rewriting integrations.
- Build a machine-to-machine RPC bridge between a Drupal site and non-Drupal systems.
- Encode binary payloads for transport using the `base64` XML-RPC type.
- Send date/time values as `dateTime.iso8601` using `xmlrpc_date()`.
- Pass custom HTTP headers (e.g. auth tokens) along with an outbound XML-RPC request.
- Inspect client-side transport/protocol errors via `xmlrpc_errno()` and `xmlrpc_error_msg()`.
- Return structured data (nested structs and arrays) from a server method.
- Provide an interoperability endpoint for clients that only speak XML-RPC rather than REST/JSON.
- Stand up a quick RPC test server for integration tests (see the `xmlrpc_example` submodule).
- Ping an external aggregator/directory when content is published.
- Wrap an internal service in an XML-RPC facade for a third-party partner.
- Validate incoming request types automatically through per-method signatures.
