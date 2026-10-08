# Amazon Web Services (AWS) — manual setup guide

**Amazon Web Services** (`aws`) is credential-and-client plumbing for other
modules. It gives you one place to store your AWS credentials and regions — as
reusable **profiles** — and hands any other Drupal module a ready-configured
**AWS SDK for PHP** client for any AWS service (S3, SQS, SES, DynamoDB, and so
on). It makes no AWS calls of its own; it exists so that S3 filesystem modules,
queue workers, and custom integrations don't each have to bootstrap their own SDK
client.

You define one or more **AWS Profile** entries, each holding a region and either
static access keys or — better — an IAM **role ARN** to assume via STS, or nothing
at all (falling back to the environment or an EC2 instance profile). You mark one
profile as the default, and optionally override which profile a specific AWS
service uses. Consumer code then asks the module's client factory for, say, an
`S3Client`, and gets one built from the right profile.

A note on secrets: prefer **not** to paste long-lived access keys into a profile.
The safest options are an **IAM role** (the profile assumes it via STS and uses
temporary credentials) or leaving the keys blank so the SDK picks up credentials
from the environment or the instance profile. If you do store an access key/secret,
install the optional **Encrypt** module so the secret is encrypted at rest rather
than saved as plaintext in config. The module requires the `aws/aws-sdk-php`
library, adds an *Administer aws* permission, and ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the AWS SDK with
   Composer, then enable it.
2. [Configuration](configuration/index.md) — create profiles, set credentials
   safely, and assign profiles to services.

## Where it lives in the admin menu

Profiles and service overrides are managed at **Configuration → Web Services →
Amazon Web Services** (`/admin/config/services/aws`).
