Symfony HTTP Client for Drupal registers Symfony's HTTP client in the service container so code can autowire `HttpClientInterface` instead of using Guzzle.

---

Drupal has shipped Guzzle as the `http_client` service for over a decade, but the wider PHP ecosystem has largely moved to Symfony's client — it is what Symfony's own components (including the Notifier channels that motivated this project) expect, it supports HTTP/2, streaming and concurrent requests natively, and many modern SDKs type-hint `Symfony\Contracts\HttpClient\HttpClientInterface` rather than a Guzzle client. This module makes that available. It is pure infrastructure: no UI, no permissions, no routes, no configuration and no config schema. Its whole implementation is a `ServiceProviderInterface` (`SymfonyHttpClientServiceProvider`) that registers a single compiler pass (`SymfonyHttpClientCompilerPass`), which aliases `HttpClientInterface` to a private, factory-built `HttpClient::create()` definition. The `symfony_http_client.services.yml` only turns on `autowire`/`autoconfigure` defaults so consumers can inject the interface. It is version **1.0.0**, core `^10.3 || ^11.0`, and note the **`php: 8.3`** floor in the info.yml — higher than core itself requires. The module usually arrives as a transitive dependency (for example alongside the `ai` module family) rather than as a deliberate install. One thing worth knowing before coding against it: the client is created by a bare `HttpClient::create()` with no Drupal-supplied options, so it does **not** inherit the proxy settings, timeouts or middleware that core layers onto `http_client` via `http_client_factory` — on a site behind an outbound proxy, requests made through this client bypass it.

---

- Autowire a Symfony HTTP client into a service or controller.
- Use an SDK or library that type-hints `HttpClientInterface`.
- Call an external API over HTTP/2.
- Stream a large HTTP response instead of buffering it.
- Make concurrent/async outbound requests.
- Satisfy a contrib module's dependency on Symfony's client.
- Use Symfony components (e.g. Notifier channels) that require a client.
- Avoid writing a Guzzle-to-Symfony adapter shim.
- Call an AI provider's REST API from a module.
- Consume a REST or JSON service from custom code.
- Kick off async requests from a queue worker.
- Share one Symfony client across multiple modules.
- Modernise a module's outbound HTTP layer.
- Avoid each module bundling its own HTTP client.
- Inject the client into a tagged/event-subscriber service.
- Call a webhook or callback endpoint.
- Fetch a remote RSS/Atom feed.
- Integrate a third-party PHP library that expects the Symfony contract.
- Run parallel API calls and read responses as they complete.
- Provide the HTTP transport for a Symfony Notifier channel.
