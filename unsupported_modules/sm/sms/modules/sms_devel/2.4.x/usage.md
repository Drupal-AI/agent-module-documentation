SMS Devel is a developer/site-builder tool that provides an admin form for sending (and simulating) SMS messages while building with SMS Framework.

---

Enabling the module exposes the route `sms_devel.message` at `/admin/config/development/sms`, gated by the `sms_devel form` ("Send any message") permission. `SmsDevelMessageForm` lets a developer compose and dispatch a test SMS through the configured gateways (and, depending on the gateway, simulate incoming messages), which is handy for verifying gateway configuration, message routing, events, and delivery reports without wiring up an application flow. It is a development aid — not intended for production — with no configuration, schema, or Drush commands of its own.

---

- Send a test SMS from an admin form while developing.
- Verify a newly configured gateway actually delivers.
- Exercise the send/queue pipeline and events during development.
- Simulate message flows without building an application feature first.
- Debug message routing and gateway selection.
- Confirm the `log` gateway output during local testing.
- Check phone-number formatting and recipient handling.
- Reproduce a delivery scenario for troubleshooting.
- Test message content/token rendering quickly.
- Validate that a gateway module's plugin is discovered and usable.
- Provide QA a manual way to trigger SMS during acceptance testing.
- Smoke-test SMS after a configuration change.
- Iterate on event subscribers by sending sample messages.
- Confirm queued vs. immediate (skip_queue) behavior.
- Check that outgoing messages are stored as expected.
