# Mail Group Amazon SES — manual setup guide

**Mail Group Amazon SES** (`mailgroup_amazonses`) adds an **"Amazon SES"
connection plugin** to [Mail Group](https://www.drupal.org/project/mailgroup) for
**receiving** email. It's the piece that lets a mail group take delivery of inbound
messages through Amazon's cloud rather than a mailbox you poll over IMAP.

The flow it plugs into works like this: Amazon **SES** receives mail for your
group's address and drops the raw message into an **S3** bucket, then publishes an
**SNS** notification. This module exposes an endpoint that receives those SNS
notifications, fetches the message from S3, parses it, and files it as a message in
the Mail Group whose address matches the recipient. It can optionally delete the
message from S3 once retrieved.

Security-wise, the receiving endpoint is designed to be safe even though it's
reachable without a Drupal login: every incoming SNS notification is
**cryptographically verified** against Amazon's signature before anything happens,
so only genuine SNS messages trigger any action. AWS credentials aren't handled by
this module directly — it uses the [AWS](https://www.drupal.org/project/aws)
module's client for S3 access. It depends on the **AWS** module and **Mail Group**,
and supports Drupal 9 and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its AWS / Mail
   Group dependencies with Composer.
2. [Configuration](configuration/index.md) — set up SES, S3, and SNS on the AWS
   side, wire up the AWS module credentials, and select the SES backend on your
   group.

## Where it lives in the admin menu

There's no standalone settings page. The SES connection is selected and configured
as the **connection backend on a Mail Group** (see Mail Group's own docs), and AWS
credentials live in the **AWS** module at **Configuration → Web services → Amazon
Web Services**. The inbound endpoint is a fixed route,
`/mailgroup/amazonses/receive`. See [Configuration](configuration/index.md).
