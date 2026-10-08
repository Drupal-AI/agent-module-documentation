# Deconfig — manual setup guide

**Deconfig** (`deconfig`) is a developer/devops module for excluding — or
"de-configuring" — selected configuration from Drupal's configuration
export/import system. It lets you mark certain config entries as exempt from config
sync, so a site administrator can change those settings and they won't be
overwritten the next time configuration is imported.

Drupal's configuration management is excellent for keeping site configuration under
control in code, but sometimes you deliberately want to loosen the reins on a few
items — settings that should legitimately differ between environments (dev,
staging, production) or that a site owner should be free to change without a
deployment stomping on them. Deconfig's approach is to mark config as excluded
**directly in the YAML files**, so the exclusion is documented right where the
config lives and is obvious in code review. As a safeguard, the configuration
system will error on import/export if an excluded item somehow ends up in the YAML
anyway. There's also a "soft" deconfig option: you can provide a **default value**
that is only used if the site doesn't already have the config item, for cases where
something needs a fallback so it doesn't break.

Because it changes how config sync behaves, it comes with responsibilities.
**Be deliberate about what you exclude:** excluding security-relevant configuration
(permissions, access settings) from import means deployment will no longer enforce
or update it, which invites configuration drift. And never treat exclusions as a
place to hand-manage **secrets** in the database — keep secrets in environment
variables or the Key module. Deconfig has no content or access role of its own.

Setup is done in code (in your config YAML), not through an admin settings form, so
there is no configuration page to click through.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no admin configuration page** — you mark config as excluded in the YAML
files themselves. See the project's README for the exact syntax, and the notes
below for how to use it responsibly.

## How to use it

Deconfig is used by editing your configuration's YAML rather than clicking through
the admin UI:

1. In the config you want to exempt from sync, add the module's marker to the
   relevant key(s) to exclude them from export/import. (See the project's README
   for the precise keys and syntax.)
2. Optionally use a **soft** exclusion with a **default value**, which is applied
   only when the site doesn't already have that config item — useful when a value
   must exist to avoid breakage but shouldn't be managed by sync.
3. Review the exclusions in code review — because they live in the YAML, they're
   visible and self-documenting.

**Use it sparingly and deliberately.** Reserve exclusions for genuinely
environment-specific or owner-managed settings, keep security-relevant config under
normal sync to avoid drift, and store secrets in environment variables or the Key
module rather than here.
