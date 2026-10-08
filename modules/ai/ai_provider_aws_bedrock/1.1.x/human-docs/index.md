# AWS Bedrock Provider — manual setup guide

**AWS Bedrock Provider** (`ai_provider_aws_bedrock`) makes **Amazon Bedrock**
available to Drupal's [AI module](https://www.drupal.org/project/ai). Bedrock is
Amazon's managed service for foundation models — it hosts Anthropic's Claude
models, Amazon's own Titan/Nova models, and several others behind a single AWS
API. With this provider enabled, any AI feature written against the AI module can
run on a Bedrock-hosted model, and you can switch which model without touching the
feature.

Authentication is **AWS IAM**, not a simple API key. The module talks to Bedrock
through the official `aws/aws-sdk-php` library, so it uses an AWS region plus AWS
credentials (an access key ID and secret access key, or an assumed IAM role).
Those credentials are held through Drupal's **Key** module so they can come from an
environment variable or file rather than being written into exported
configuration.

For organisations already on AWS this is often the most *approvable* way to add
AI. Because Bedrock runs inside your own AWS account, model usage falls under the
same IAM policies, billing and data-residency arrangements as everything else in
that account — prompts do not leave your cloud tenancy the way they do with a
public API endpoint.

> **Note:** at the time of writing the release is **1.1.0-beta4** — a beta. Weigh
> that for production use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   AWS SDK) and enable the module.
2. [Configuration](configuration/index.md) — set the region and supply AWS
   credentials via environment variables and the Key module.

## Where it lives in the admin menu

The provider's settings form is at **Configuration → AI → Providers → AWS
Bedrock** (`/admin/config/ai/providers/aws_bedrock`), gated by the **administer ai
providers** permission.

## How to use it

Create an IAM identity that is allowed to invoke Bedrock models, put its
credentials in environment variables, wrap them in Key entities, then set the
region and select those keys on the provider settings form. After that, choose
**AWS Bedrock** and a model wherever the AI module offers a provider choice.
