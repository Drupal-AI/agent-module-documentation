<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the trusted-host allowlist

## Where
- UI: **Configuration > Search and metadata > Trusted redirect**
  (`/admin/config/search/trusted_redirect`, route `trusted_redirect.admin_form`).
- Permission required: **`admininister trusted redirect configuration`** — note the misspelling
  (three `in`s). Use that exact string in role YAML / `user.role.*` config.
- Config object: `trusted_redirect.settings`, single key `trusted_hosts` (a `sequence` of strings,
  per `config/schema/trusted_redirect.schema.yml`). Default install value is empty `{}` — until a
  host is added the module does nothing.

## What a "host" is
The form is a textarea, **one host per line**. On submit `ConfigForm::extractTrustedHosts()`
trims each line, drops blanks and duplicates, and stores the raw strings. At match time
`isTrustedUrl()` compares against `parse_url($url)['host']`, so each entry must be a **bare
hostname** — e.g. `payments.example.com` — with:
- **no scheme** (`https://…`), **no path**, **no port**, **no wildcard**;
- exact match only: `example.com` does **not** cover `www.example.com` or any subdomain, and
  `sub.example.com` must be listed separately;
- matching is case-sensitive (`parse_url` does not normalise case), so list the host as it will
  actually appear in redirect URLs.

## Deploying via config
Export `trusted_redirect.settings` like any config:

```yaml
# config/sync/trusted_redirect.settings.yml
trusted_hosts:
  - payments.example.com
  - id.partner.example
```

Grant the permission in the owning role's config, minding the spelling:

```yaml
# user.role.some_admin.yml (permissions:)
- 'admininister trusted redirect configuration'
```

## Operational guidance
- Add the **minimum** set of hosts; each trusted host is a host you also trust not to host
  attacker-controlled links (open redirects on their side chain through yours).
- Once configured, the external redirect via `?destination=<trusted-url>` is available to
  **anonymous** visitors — this is by design, not a bug.
- Drush is read/writable via generic config commands (`drush cget trusted_redirect.settings`,
  `drush cset …`); the module ships **no** custom Drush commands.
