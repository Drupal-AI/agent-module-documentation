# Configuration

Configuring this module is mostly work on the **AWS side** (SES, S3, and SNS),
plus pointing the Drupal **AWS module** at credentials and selecting the SES
backend on your mail group. Do the AWS setup first, then wire it up in Drupal.

## Step 1 — the AWS setup

Following Amazon's console, set up the receiving pipeline:

1. **Create an SNS topic** that will be notified when new mail is received. You'll
   reference this topic when you create the SES rule set.
2. **Add a subscription to the SNS topic** so it notifies your site. Use the
   **HTTP** or **HTTPS** protocol, with the **endpoint** set to your site's receive
   route:

   ```
   https://example.com/mailgroup/amazonses/receive
   ```

   (Replace `example.com` with your site's domain.) On first delivery, the module
   automatically confirms the subscription.
3. **Prepare an S3 bucket** — either use an existing one or create a new one when
   defining the rule set below. If you reuse an existing bucket, make sure **SES
   has permission to write to it**.
4. **Create an SES rule set** to handle incoming mail. Add a rule whose
   **recipient** is your group's email address, give it the **S3 action** (pointing
   at the bucket), and select the **SNS topic** you created so a notification fires
   for each message.

## Step 2 — configure the AWS module

In Drupal, configure the **AWS** module at **Configuration → Web services → Amazon
Web Services**. Create a **profile** using AWS credentials that can **read from and
delete objects in** the S3 bucket. This is where AWS credentials live — this SES
module doesn't handle them itself.

> **Keep AWS credentials as secrets.** Provide them via the AWS module using
> environment variables / a Key entity rather than pasting long-lived secrets into
> configuration that gets exported. Grant the IAM identity only the S3 permissions
> it needs (read and delete on the specific bucket).

## Step 3 — select the SES backend on your group

Back in **Mail Group**, edit the group that should receive via SES and choose the
**Amazon SES** connection backend. Its settings are:

- **Bucket** — the S3 bucket where SES stores incoming raw messages.
- **Delete after retrieval** — when enabled, the module removes each message from
  S3 once it has been fetched and filed, keeping the bucket tidy.

The backend offers a **test connection** action (it lists objects in the bucket) so
you can confirm the S3 side is reachable with the configured credentials.

## How receiving works (and why the open endpoint is safe)

Once everything is wired up: SES stores each incoming message in S3 and SNS posts a
notification to `/mailgroup/amazonses/receive`. The module then verifies the
notification's **Amazon signature** before doing anything — only signature-valid
messages cause it to fetch the body from S3, parse it, and create a Mail Group
Message owned by the sending member (bounce notifications from the SES mailer
daemon are skipped). The receive route is reachable without a Drupal login by
design, but because every payload must carry a valid Amazon signature, that isn't
an open door — unsigned or forged requests are rejected.

## Permissions and notes

This module doesn't add its own permissions; group and membership access is
governed by **Mail Group**'s permission set. Make sure your SES receiving is
verified for the domain you use, and that the endpoint URL you gave SNS exactly
matches your site's public HTTPS address.
