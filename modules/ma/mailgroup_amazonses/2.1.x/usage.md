<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mail Group Amazon SES adds an "Amazon SES" connection plugin to [Mail Group](https://www.drupal.org/project/mailgroup)
for **receiving** email. Amazon SES stores inbound messages in an S3 bucket and publishes an SNS
notification; this module exposes an endpoint that consumes those SNS notifications, fetches the raw
message from S3, parses it, and creates a Mail Group Message in the group whose address matches the
recipient. Depends on the [AWS](https://www.drupal.org/project/aws) module and `mailgroup`.

---

The connection plugin (`AmazonSes`, `@Connection` id `amazonses`) provides config fields for the S3
`bucket` and a "delete after retrieval" flag, and a `testConnection()` that lists S3 objects. The
inbound endpoint is `POST /mailgroup/amazonses/receive`
(`AmazonSesController::receive`, route requirement `_access: 'TRUE'` — i.e. reachable anonymously). Inside
`receive()`, the payload is parsed with `SnsMessage::fromRawPostData()` and **cryptographically verified**
with the AWS SDK's `MessageValidator::isValid($message)` before any action is taken. Only after signature
validation does it handle `Notification` messages (load recipient groups, pull the message body from S3
by `messageId`, parse it with `zbateson/mail-mime-parser`, skip `MAILER-DAEMON@amazonses.com`, and create
a `mailgroup_message` owned by the sending member) and `SubscriptionConfirmation` messages (GET the
`SubscribeURL`). Because the SubscribeURL and payload are part of the SNS-signed message, the outbound
GET is authenticated by the signature rather than attacker-controlled. AWS S3 access uses the AWS
module's client factory. No TLS options are disabled; no credentials are handled directly by this module.

---

- Receive inbound email for a mail group via Amazon SES + SNS + S3.
- File incoming messages into the group matching the recipient address.
- Confirm an SNS subscription automatically on first delivery.
- Verify every inbound SNS notification's signature before processing.
- Pull raw messages from a configured S3 bucket by message ID.
- Optionally delete messages from S3 after they are retrieved.
- Skip bounce notifications from the SES mailer daemon.
- Attribute a received message to the sending member's account.
- Test S3 connectivity for a group from the connection settings.
- Integrate SES receiving into an existing Mail Group setup.
- Use the AWS module's client factory for S3 credentials/config.
- Add SES as a selectable connection backend on a mail group.
- Parse MIME bodies into a stored Mail Group Message.
- Run a group inbox backed by SES receiving rules.
- Keep the S3 bucket tidy with the delete-after-retrieval option.
- Avoid handling AWS secrets in this module (delegated to the AWS module).
