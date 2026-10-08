<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LMS Messages integrates with the Message module to notify users on LMS events.

---

LMS Messages integrates the **LMS** (learning management) module with **Message** and **Message Notify** —
creating Message entities to notify users about LMS events (enrolment, completion, etc.), delivered via Message
Notify. It depends on lms, message, message_notify and token, in the LMS package.

Use it to send LMS event notifications. It is an integration/notifications feature (reviewed CLEAN): it only
**creates** Message entities addressed to a specific recipient `uid` in response to LMS hooks — the only route
it declares is its settings form (gated by `administer lms`); reading/displaying those private messages is
handled by **Message / Message Notify** and their entity access, so there is no unguarded route that returns
message content. It has no access-control role of its own. Configure the LMS message notifications.

---

- Notify users of LMS events.
- Create Message entities.
- Deliver via Message Notify.
- Depend on lms/message/message_notify/token.
- Address messages to a recipient uid.
- Serve LMS notifications.
- Only create messages (no display route).
- Delegate reading to Message/Message Notify access.
- Gate the settings form by administer lms.
- Have no access-control role of its own.
- Configure the notifications.
- Handle LMS messages.
- Send notifications.
- Configure the events.
- Notify learners.
- Handle the integration.
- Create notifications.
- Send LMS alerts.
- Configure LMS.
- Provide LMS notifications.
