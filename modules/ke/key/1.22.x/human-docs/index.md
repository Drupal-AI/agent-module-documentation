# Key — manual setup guide

**Key** (`key`) gives your site one central place to define and manage sensitive
values — API keys, passwords, and encryption keys — and keeps the secret itself
**separate** from the configuration that references it. Instead of hard-coding a
credential in `settings.php` or scattering it across module settings, you create a
**Key** entity once and let other modules (encryption, mail, AI providers, and so
on) reference it by name.

The important part is *where* the value is stored. Each key uses a **provider**,
and providers like **Environment variable** or **File** keep the secret **outside**
Drupal's configuration entirely — so it never lands in your config export or your
Git repository. You reference the key; the secret stays where it belongs. This
guide is written for a **human** clicking through the admin UI, from installing the
module to adding your first key. If you want terse, token-cheap references for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The Keys listing under Configuration → System → Keys](images/list.png)

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → System → Keys**
(`/admin/config/system/keys`). That page lists every key on the site and has an
**+ Add Key** button for creating new ones.

## Contents

1. [Installation](installation/index.md) — install Key with Composer and enable it.
2. [Configuration](configuration/index.md) — the Keys listing and the difference
   between a key's **type** and its **provider**.
3. [Adding a key](adding-a-key/index.md) — a step-by-step walkthrough of the Add key
   form, including how to store a secret in an environment variable so it stays out
   of config.
