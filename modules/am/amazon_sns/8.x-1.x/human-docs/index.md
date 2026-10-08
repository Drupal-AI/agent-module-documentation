# Amazon SNS — manual setup guide

**Amazon SNS** (`amazon_sns`) lets your Drupal site receive notifications from
**AWS Simple Notification Service**. SNS is Amazon's publish/subscribe messaging
service: when something happens in AWS (a file lands in S3, a CloudWatch alarm
fires, and so on), AWS can POST a notification to a subscribed endpoint. This
module exposes that endpoint and turns each incoming notification into a Drupal
event that your own code can react to.

The endpoint lives at `/_amazon-sns/notify`. Because AWS posts to it without
logging in, the route is necessarily open to anonymous requests — there is no
Drupal user behind an SNS delivery. The security therefore comes from the
**message signature** rather than from access control, and this module handles
that correctly: every incoming message is validated with the AWS SDK's
`MessageValidator`, and a message with an invalid or forged signature is
rejected before it is ever processed. The validator also checks that the signing
certificate URL is a genuine AWS host before fetching it.

In practice you use this module as a bridge: point an SNS subscription at your
site's endpoint, and write code that responds to the Drupal events the module
dispatches. It is a developer-facing integration — it has no admin UI of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. In the **AWS console**, create or choose an SNS topic and add a subscription
   whose endpoint is your site's `/_amazon-sns/notify` URL. AWS will send a
   subscription-confirmation message, which the module validates and handles.
3. Write code (an event subscriber) that reacts to the Drupal events the module
   dispatches for each notification — for example to process an S3 or CloudWatch
   message.
4. Keep the **AWS SDK current**, since the signature validation relies on it.
