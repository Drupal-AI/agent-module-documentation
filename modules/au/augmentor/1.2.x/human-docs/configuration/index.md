# Configuration

Setting up Augmentor is three steps: store the provider **API key** securely,
create an **augmentor**, and grant the **permission**. Then wire it into wherever
you want to use it.

## 1. Store the provider API key securely

Augmentor depends on the **Key** module precisely so that provider credentials do
not end up in plain configuration. Keep the key as a real secret in an environment
variable and expose it through a Key entity:

- With DDEV, save the value into the container's environment, for example
  `ddev dotenv set .ddev/.env --openai-api-key=<value>` (keep `.ddev/.env` out of
  version control), then `ddev restart`.
- Create a **Key** entity that reads that environment variable (the Key module's
  built-in *env* provider). You will select this Key when you configure the
  augmentor.

Never paste the raw key into the augmentor form or into exported config.

> **Provider without a key field.** Some providers do not take a key in Drupal at
> all. The AWS provider, for instance, uses the AWS SDK's own credential chain
> (environment variables or an instance role) and removes the key field entirely.
> Follow the provider submodule's own guide.

## 2. Create an augmentor

1. Go to the **Augmentors** area under **Configuration** (requires the
   *Administer augmentors* permission).
2. Add an augmentor and choose the **provider plugin** supplied by one of your
   installed provider submodules.
3. Configure the operation (summarise, translate, classify, generate, …) and, for
   key-based providers, select the **Key** entity you created above.
4. Save.

## 3. Grant the permission — to trusted roles only

Augmentor provides the **Administer augmentors** permission
(`administer augmentors`). Because an augmentor can send content to an external AI
service (with cost and data-egress implications), this permission is
security-sensitive — grant it on **People → Permissions** only to trusted roles.

## 4. Use the augmentor

Depending on the integration submodules you enabled, invoke augmentation from:

- **CKEditor 4/5** — augment text directly in the editor.
- **ECA** — run augmentors in response to events.
- **Search API processors** — augment items as they are indexed.

## Governance and safety

- Content sent to an augmentor **leaves your infrastructure** — decide what is
  acceptable to send before enabling it on sensitive content.
- Treat AI output as **untrusted input**; it still passes through Drupal's normal
  sanitisation, and you should not bypass that.
