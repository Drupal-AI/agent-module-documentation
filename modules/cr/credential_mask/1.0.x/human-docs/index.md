# Credential Mask — manual setup guide

**Credential Mask** (`credential_mask`) keeps credentials and secret keys out of
your **exported (config-sync) configuration**. Drupal best practice is to export
your site's configuration and commit it to source control — but that YAML often
carries API keys, passwords, and other secrets you never want landing in a Git
repository. Credential Mask integrates with the configuration management API so
that any configuration property you mark as "sensitive" is stripped out on export,
and on import the existing (unmasked) value is left in place rather than being
overwritten with the masked placeholder.

You tell the module *which* keys are sensitive — anything you have not listed is
still exported normally. The list is stored in the module's own
`credential_mask.sensitive_config` configuration and can be managed either from a
small admin page or from Drush commands (see [Configuration](configuration/index.md)).

Think of this as **defense-in-depth**, not a complete solution. It is one of the
most common ways secrets leak — exported config committed to a repo — and closing
that channel is genuinely valuable. But the stronger fix is to keep secrets out of
configuration entirely, using environment variables or the Key module. Credential
Mask has no access-control role; it only affects what gets written during config
export and import. It supports Drupal 8.8 through 11 and requires Drush 10 or newer
for the command-line tools.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — mark which configuration keys are
   sensitive, using the admin page or Drush.

## Where it lives in the admin menu

Sensitive keys are managed at **Configuration → Development → Configuration
synchronization → Credential mask**
(`/admin/config/development/configuration/credential_mask`), available to users
with the **Import configuration** permission. The same list can be edited from the
`credential_mask:*` Drush commands.
