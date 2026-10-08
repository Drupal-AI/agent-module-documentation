# Augmentor — manual setup guide

**Augmentor** (`augmentor`) is an AI-integration framework that lets Drupal content
be *augmented* — summarised, translated, classified, extracted or generated — by
external AI services. It works through a plugin system of **augmentors**: each
augmentor is a configured operation backed by an AI provider, which other features
then invoke. On its own the base module is the framework and the plumbing; the
actual providers (AWS, Azure OpenAI, and others) come from separate provider
submodules you add alongside it.

Several submodules wire Augmentor into the rest of the site: **CKEditor 5**
(`augmentor_ckeditor5`) and **CKEditor 4** (`augmentor_ckeditor4`) add in-editor
augmentation, **ECA** (`augmentor_eca`) drives augmentation from events, **Search
API processors** (`augmentor_search_api_processors`) augment items as they are
indexed, and **Demo** (`augmentor_demo`) provides examples. It depends on the
**Key** module, which is where provider API keys belong.

Because Augmentor calls external AI providers, two things need care. Provider
**API keys are credentials** — keep them out of plain configuration by storing
them in an environment variable and referencing them through a **Key** entity.
And content sent to an AI provider **leaves your infrastructure**, which is a
data-governance decision for anything sensitive. Augmentation runs with whatever
access the invoking context has, and AI output should be treated as untrusted
input that still passes through Drupal's normal sanitisation.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   framework, add a provider, and pick the integration submodules.
2. [Configuration](configuration/index.md) — storing the API key, creating an
   augmentor, the `administer augmentors` permission, and the integrations.

## Where it lives in the admin menu

Augmentor adds an **Augmentors** management area under **Configuration**, where you
create and manage augmentor configurations. Access to it is gated by the
**Administer augmentors** permission (`administer augmentors`), which is
security-sensitive and should go only to trusted roles.
