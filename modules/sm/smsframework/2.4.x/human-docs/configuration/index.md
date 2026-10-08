# Configuration

SMS Framework is the shared layer; the main setup task is adding a **gateway** for
your SMS provider and setting it as the default, then deciding who may administer
the framework and verify phone numbers.

## Add a gateway

1. Log in as a user with the **administer smsframework** permission.
2. Go to **Configuration → SMS & messaging → Gateways**
   (`/admin/config/smsframework/gateways`).
3. Add a gateway and choose your provider's plugin.

Which gateways are available depends on what you have installed. Many providers
are offered as separate `sms_*` gateway modules (Twilio and others) that plug into
this framework — install the one for your provider, then it appears here as a
choice. Enter the account credentials the provider requires.

## Set the default gateway

After adding a gateway, set it as the site **default** so that all outbound SMS
routes through it (you can also route specific numbers to specific gateways). Send
a test message to confirm the credentials and routing work before relying on it.

## Protect gateway credentials

Your gateway credentials — for example a Twilio auth token — authorise messages
that cost real money and reach real phones. Keep them in **secure configuration**
(an environment variable or a Key entity where the gateway supports one), not in
plain config that gets exported into git. Restrict the **administer smsframework**
permission to trusted administrators.

## Phone‑number verification

The framework provides the flow for binding a phone number to a user (or any
entity) and **verifying** it with a random code, plus the page where the user
enters that code. This is what features like SMS‑based two‑factor authentication
build on. Because it's identity‑adjacent, treat it carefully:

- The **`sms verify phone number`** permission governs who can run verification —
  grant it deliberately.
- Only send messages to numbers that have been **verified**, so you don't text the
  wrong person.
- Treat inbound and verification flows as the identity surface they are, and
  restrict who can trigger sends so the ability to message real phones isn't
  abused.

## Queueing and asynchronous sends

Message dispatch and recipient‑to‑user mapping are handled by Drupal's Notifier;
with Messenger you can send messages asynchronously (via queues, outside the web
request) rather than during page requests. This is useful for bulk sends (see the
**SMS Blast** submodule) and for keeping the site responsive under load.

## Delivery reports

Where the gateway supports them, delivery reports flow back through the framework
so you can see the outcome of a send.
