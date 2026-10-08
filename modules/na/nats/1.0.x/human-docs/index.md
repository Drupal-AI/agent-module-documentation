# NATS Integration — manual setup guide

**NATS Integration** (`nats`) connects Drupal to a [NATS](https://nats.io)
messaging server so your code can publish and subscribe to NATS subjects. NATS is
a high‑performance messaging and streaming system, and this module gives Drupal a
clean, service‑based way to talk to it — useful for event‑driven architectures,
pub/sub patterns, message queues, and integrating Drupal with other services or
microservices.

This is a **foundation / developer** module rather than an end‑user feature. It
does not add any pages, blocks, or content of its own; instead it provides a
service you call from custom code, and it is designed to be the base that more
specific NATS‑based modules build on. Its standout capability is support for
**multiple named client configurations**, so a single site can talk to several
NATS servers or use several connection profiles, each retrieved by name through
the service.

It wraps the `basis-company/nats.php` PHP library and works on Drupal 10.3+ and
11. Configuration is done in `settings.php` (not through an admin form), and the
NATS server URL and credentials should be kept out of code — store them in
environment variables. See [Configuration](configuration/index.md) for the
details.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls in
   the NATS PHP library) and enable the module.
2. [Configuration](configuration/index.md) — define named client connections in
   `settings.php` and keep the server credentials secure.

## How to use it

Once installed and configured, you retrieve a NATS client from the service
container in your custom code and use it to publish to or subscribe from subjects.
The module manages the named client configurations for you, so your code just asks
for a client by its configured name. The connection details themselves come from
`settings.php`, described in [Configuration](configuration/index.md).
