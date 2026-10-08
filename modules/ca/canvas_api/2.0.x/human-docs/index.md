# Canvas API — manual setup guide

**Canvas API** (`canvas_api`) integrates the **Canvas LMS** (Instructure's
learning‑management system) API with Drupal, giving developers a simple service to read and
sync course and user data between the two systems. This 2.x branch pares the module down to
a single flexible request interface: rather than wrapping every Canvas endpoint in its own
class, you hand it an HTTP method, a path, and parameters, and it makes the call.

For example, to fetch all the users in a course by its SIS ID:

```php
$users = \Drupal::service('canvas_api')
  ->setMethod('GET')
  ->setPath('courses/sis_course_id:3456/users')
  ->request();
```

The module also includes a tester page for trying API calls interactively. It is a
developer/integration building block — it has **no access‑control role** of its own — and it
depends on the **Canvas LMS** module and the **Key** module. Credentials (your Canvas API
token) are stored via **Key**, which is the right way to keep the secret out of exported
configuration, and calls go to Canvas over HTTPS.

This module does not have its own settings form: rather than a configuration page, you make
it work by providing the Canvas credentials through Key (and the Canvas LMS module) and then
calling the `canvas_api` service from code. Note also that Canvas course and student data can
be **educational PII / FERPA‑relevant** — this module makes outbound requests that can carry
such data, so handle and disclose it according to your policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module and its
   Canvas LMS / Key dependencies, and set up credentials.

There is **no dedicated configuration page** for this module — it exposes a code service, a
tester page, and stores its credentials through the Key module rather than a settings form of
its own.

## Where it lives in the admin menu

Canvas API does not add a standard settings page. It provides the `canvas_api` service for
your code, plus a **tester page** for trying API calls. Its Canvas credentials are managed
through the **Key** module (and the Canvas LMS module) rather than a form of its own.

## How to use it

1. Install and enable the module along with **Canvas LMS** and **Key**.
2. Store your Canvas API token as a **Key** entity (backed by an environment variable — see
   the installation guide) so the secret stays out of configuration.
3. Call the service from your own code with `setMethod()` / `setPath()` / `request()`, as in
   the example above, or use the included tester page to experiment with calls.
