<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SMS Devel is a submodule of SMS Framework that provides a developer form to simulate sending and receiving SMS through any configured gateway and inspect the result.

---

SMS Devel is a build-time and testing aid, not a production feature. It adds one form at `/admin/config/development/sms` where a developer enters a number and message, picks a gateway (or lets the framework route automatically), and either sends an outgoing message or simulates an inbound one. Options let you skip the queue and process immediately, flag the message as automated, schedule a send time, and show a verbose table of the returned result and delivery reports. Because it drives the parent SMS Framework's real send/receive path, it is the quickest way to confirm a newly added gateway works, to watch how a message flows through events and the queue, or — with the bundled "log" gateway — to see messages written to the Drupal log without contacting a real provider. Access is limited to the `sms_devel form` permission, which should be granted only to developers and administrators.

---

- Send a test SMS through a specific gateway.
- Simulate receiving an inbound SMS for testing.
- Verify a newly added gateway plugin works.
- Watch a message flow through the framework queue.
- Send a message immediately by skipping the queue.
- Inspect the result object and delivery reports.
- Test automatic gateway routing rules.
- Flag a test message as automated.
- Schedule a test message for a future time.
- Send to the log gateway to check log output.
- Debug delivery-report handling for a gateway.
- Reproduce an SMS flow while developing.
- Check credits/error fields returned by a gateway.
- Trigger an incoming-message event subscriber.
- Exercise the send path without a real provider.
