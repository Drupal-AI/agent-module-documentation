# Configuration

All of this module's screens live under **Reports** and are governed by their own
permissions — grant them carefully, as the settings permission is restricted.

## Open the settings form

1. Log in as a user with the **AWS CloudWatch Logs administer settings**
   permission.
2. Go to `/admin/reports/aws-cloudwatchlogs/settings`.

## Settings

On the settings form you connect Drupal to CloudWatch:

- Select the **Key** entity that holds your AWS credentials (see
  [Installation](../installation/index.md#store-your-aws-credentials-as-a-secret) —
  the credentials come from an environment variable via the Key module, never from
  plain config).
- Provide the AWS **region** and the **log group / stream** details the module
  should write to.

Once configured, the module writes every Drupal log message to CloudWatch
automatically — you do not need to change any code, because it is registered as a
standard Drupal logger.

## The other screens

Each of these is gated by its own permission:

- **Create a log group** — set up a CloudWatch log group from the UI rather than
  in the AWS console.
- **Generate a test log entry** — write a sample message so you can confirm logs
  are actually arriving in CloudWatch.
- **Filter** — filter the log output.

## Before you rely on it — two cost/security points

- **CloudWatch is billed per ingested byte.** A verbose site is a recurring cost.
  Consider reducing log verbosity so you are not paying to ship noise.
- **Logs leave Drupal's access controls once shipped.** Anyone who can read the
  CloudWatch log group can read whatever ends up in a log message. Review what your
  site logs before sending it off‑site.
