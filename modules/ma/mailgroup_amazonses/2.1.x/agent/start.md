<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mailgroup_amazonses — agent start

Amazon SES **receiving** connection plugin for Mail Group. SES → S3 (raw message) + SNS (notification);
this module consumes SNS, fetches from S3, parses, and creates a `mailgroup_message` in the recipient's
group. Depends on `aws` + `mailgroup`.

- Plugin `AmazonSes` (`@Connection` id `amazonses`): config `bucket` + `delete` flag; `testConnection()`
  lists S3 objects.
- Endpoint `POST /mailgroup/amazonses/receive` (`AmazonSesController::receive`) is `_access: 'TRUE'`
  (anonymous-reachable).

## Security — reviewed, sound
The anonymous route is **not** an unauthenticated-mutation hole: the body is parsed with
`SnsMessage::fromRawPostData()` and verified with the AWS SDK `MessageValidator::isValid()` **before** any
processing. Only signature-valid messages trigger S3 fetch / message creation / SubscribeURL GET. Because
`SubscribeURL` is part of the SNS-signed payload, the confirm GET is not an SSRF vector. No `verify=>false`
/ disabled TLS; AWS credentials handled by the `aws` module, not here.
