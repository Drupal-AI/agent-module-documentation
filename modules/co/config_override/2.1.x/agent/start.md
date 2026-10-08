<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Override (config_override) — agent index

Structured configuration overrides from a site file, a module, or **environment variables**
(`symfony/dotenv`). Core requirement `^10 || ^11`. **No routes, permissions, forms or UI** — it
is developer infrastructure configured by files and env vars, not by clicking.

Three core `ConfigFactoryOverrideInterface` services (tag `config.factory.override`), registered
by `ConfigOverrideServiceProvider`:

| Class | Source | Where |
|---|---|---|
| `SiteConfigOverrides` | site-level YAML | `sites/default/config/override/*.yml` |
| `ModuleConfigOverrides` | YAML shipped by a module | `{module}/config/override/*.yml` |
| `EnvironmentConfigOverride` | environment variables | `sites/default/.env` / `.environment` |

## Capabilities

- **Set up any of the three override sources** (file naming, the exact env-var encoding, caching,
  how to verify) → [configure/config_override.md](configure/config_override.md)

## Key facts (read before using)

- **Overrides are runtime-only.** The overridden value is what the site *uses*, but `drush cex`
  still exports the stored value — keeps environment differences out of exports, and regularly
  confuses people who expect the export to match the site.
- **Overridden values are not editable in admin forms** — core shows/saves the stored value. By
  design, surprising to site builders.
- The env-var source suits twelve-factor / container deployment (per-environment endpoints).
  **Secrets are still better in a Key entity** than an override — overrides are readable by
  anything that can read config.
- Not `config_ignore` / `config_split` (those decide what is *exported*); this decides what is
  *used at runtime*.
