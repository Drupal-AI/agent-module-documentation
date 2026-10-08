# Amazon Image ID Scan — manual setup guide

**Amazon Image ID Scan** (`amazon_image_id_scan`) lets a Drupal site load images
that live in **Amazon S3** by referencing them with an image identifier. If your
media is stored in an S3 bucket rather than on the Drupal server, this module
gives you a way to pull those images into Drupal by ID instead of by full URL.

It is aimed at sites whose image storage sits in the cloud. Loading an image from
S3 is gated by the module's own `amazon_image_id_scan load_s3` permission, so you
control which roles are allowed to fetch from the bucket. Beyond that permission
it has no content model or access role of its own.

Because it talks to S3, it needs AWS credentials. Those credentials should be
kept out of exported configuration and stored securely — provide them through
environment variables rather than committing them anywhere.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and connect your S3 credentials.

## How to use it

After enabling the module, provide your AWS/S3 credentials through environment
variables (never hard-code or commit them). Grant the
`amazon_image_id_scan load_s3` permission to the roles that should be allowed to
load images from S3. Images can then be referenced by their S3 identifier and
served through Drupal.
