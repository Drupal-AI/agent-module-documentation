# TFA Migration — manual setup guide

**TFA Migration** (`tfa_migration`) provides a migration path for moving users'
Two-Factor Authentication settings and secrets from **Drupal 7** into the TFA
module on **Drupal 9 and above**. When you upgrade a site whose users already have
two-factor authentication configured, this module carries their TFA data — most
importantly their TOTP seeds — across so that users do not have to re-enrol their
authenticator apps after the move.

It depends on the **TFA** module (the destination for the migrated settings),
core's **Migrate** framework (which runs the migration), and the **Encrypt** module
(which keeps the sensitive secrets encrypted at rest). It sits in the Migration
package and is a developer/operator tool rather than something with a day-to-day
user interface: you configure the Drupal 7 private key, then run the migration.

Because it handles **credential material**, treat this migration with the same care
as passwords. A TOTP seed is the secret behind a user's second factor — if it
leaks, that user's two-factor protection is defeated. So the secrets must be
handled through the Encrypt module (encrypted at rest), never logged or exported in
plaintext, and the migration should be run by a trusted operator over a secure
channel. The module has no access-control role of its own. It is covered by
Drupal's security advisory policy.

This guide is written for a **human** performing the migration. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies, and enable it.
2. [Configuration](configuration/index.md) — supply the Drupal 7 private key and
   run the migration.

## Where it lives in the admin menu

After installation, the settings screen where you provide the Drupal 7 TFA private
key is at `/admin/config/system/tfa-migration-settings`.
