# AWS AI Augmentor — manual setup guide

**AWS AI Augmentor** (`augmentor_aws`) is a provider submodule for the
[Augmentor](https://www.drupal.org/project/augmentor) framework. It exposes Amazon
AI services as Augmentor plugins, so the Augmentor framework can enrich content by
calling AWS APIs. Today it ships one plugin — **AWS Rekognition Detect Faces** —
which takes an image path, reads the raw bytes, calls Rekognition's `DetectFaces`
(requesting all attributes) and returns the per-face detail as the augmentor's
output.

Its configuration is deliberately small. The plugin's form asks only for the AWS
SDK service **version** (default `latest`) and the **region code** (default
`ap-southeast-2`); it removes Augmentor's generic "key" field on purpose, because
**AWS credentials are not entered in Drupal**. Instead they are supplied to the
AWS SDK for PHP through the standard AWS credential chain — environment variables
or an EC2/ECS instance role — so no secret is stored in module configuration. It
depends on `augmentor` and pulls in the `aws/aws-sdk-php` library via Composer.

Because the plugin runs through Augmentor, it inherits Augmentor's access model:
configuring and running augmentors is gated by the **Administer augmentors**
permission, which is security-sensitive and for trusted roles only. There are no
custom routes or anonymous endpoints. Note that each execution makes a **billable
Rekognition API call**, so the cost surface is bounded by who can create and run
augmentors — keep that permission tight.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs (which
include a [plugin reference](../agent/plugins/rekognition.md)).

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   supply AWS credentials via the environment.

## How to use it

1. In the **Augmentors** area (under Configuration, gated by *Administer
   augmentors*), add an augmentor and choose the **AWS Rekognition Detect Faces**
   plugin.
2. Set the **region code** (and, if needed, the SDK **version**) to match your AWS
   setup. There is no key field — see credentials below.
3. Run the augmentor from wherever Augmentor is wired in (an entity field or an
   Augmentor action pipeline); it returns per-face attributes for the supplied
   image.

### Credentials — supplied outside Drupal

The plugin uses the AWS SDK's standard credential chain, so provide credentials to
the environment, not to Drupal config:

- **Environment variables** — `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.
  With DDEV, set them in the container's environment, e.g.
  `ddev dotenv set .ddev/.env --aws-access-key-id=<value>` and
  `--aws-secret-access-key=<value>` (keep `.ddev/.env` out of version control),
  then `ddev restart`.
- **Instance role** — on EC2/ECS, attach an IAM role and let the SDK pick it up;
  no keys are stored at all.

Nothing is persisted in module configuration, which is the safest arrangement.
