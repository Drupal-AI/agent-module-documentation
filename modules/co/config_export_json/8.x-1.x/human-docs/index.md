# Config Export JSON — manual setup guide

**Config Export JSON** (`config_export_json`) exposes **selected** Drupal
configuration as JSON so other applications and frameworks can read it. You list
the specific config objects (or individual keys) you want to share on an admin
form, and the module serves them two ways: from a REST resource at
`/api/config.json`, and as a static public file written to
`sites/default/files/config/config.json`. Saving the settings form regenerates
that static file.

The typical use is feeding chosen configuration to a **decoupled/headless front
end** or an external system as JSON. It's an opt-in allow-list, not a full-site
config dump — only what you explicitly list is exposed. Developers can also merge
configuration in programmatically through the module's service
(`\Drupal::service('config_export_json.api')->add($config)`).

> **Security — read this before exposing anything.** The exposed data is
> effectively **public**. The REST endpoint is only gated by the *access content*
> permission, which anonymous users have by default, and the generated
> `config.json` sits in the public files directory where it is web-readable with
> **no permission check at all**. Treat every value you expose as visible to
> anyone. **Never list a config object that contains secrets, API keys, tokens,
> passwords, or credentials**, and review the exposed list before every deploy —
> config objects can quietly gain sensitive keys over time.

It requires core's **Configuration** (`config`) and **REST** (`rest`) modules and
supports Drupal 8.8 through 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it and
   its REST dependency.
2. [Configuration](configuration/index.md) — list the configs to expose and
   understand the security implications.

## Where it lives in the admin menu

Its settings form is at **Configuration → Services → Config Export JSON**
(`/admin/config/services/config-export-json`), gated by the *administer site
configuration* permission. The exposed data is then served from the REST resource
at `/api/config.json` and from the static file at
`sites/default/files/config/config.json`.
