<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions Policy — configuration

## Admin form

- Route `permissionspolicy.settings` → `/admin/config/system/permissionspolicy`
  (form `PermissionsPolicySettingsForm`). Permission: `administer permissions policy configuration`.
- One collapsible row per feature. For each feature you tick **Enable**, choose a **Base**
  (Self / None / Any / empty) and optionally list extra **Sources** (origins).

## Config object

Everything lives in `permissionspolicy.settings`:

```yaml
enforce:
  enable: true                 # master switch for the "enforce" policy
  features:
    geolocation:
      base: 'none'             # 'self' | 'none' | 'any' | '' (empty)
    camera:
      base: 'self'
    fullscreen:
      base: 'self'
      sources:                 # extra allowed origins (only meaningful for self/empty base)
        - 'https://embed.example.com'
```

- `enforce.enable` — if false (or the whole policy absent), **no header is sent**.
- `enforce.features` is a map keyed by **feature name** (see the full list in
  [../api/mechanism.md](../api/mechanism.md)). Only enabled features appear here.
- Per feature:
  - `base`: `self` → your origin only; `none` → nobody; `any` → everyone (wildcard `*`);
    `''` (empty) → no base keyword, rely on `sources`.
  - `sources`: an array of origins added to the allowlist (the settings form accepts them
    space/newline/comma separated and stores an array). Ignored when `base` is `any` or
    `none` because those already resolve to `*` / empty.

> Schema note: the config schema file names the per-feature allowlist key `origins`, but the
> settings form and the response subscriber actually read/write **`sources`**. Use `sources`.

## Resulting header

The base + sources reduce to a structured-fields allowlist:

| base | sources | Header fragment |
|---|---|---|
| `self` | — | `geolocation=(self)` |
| `none` | — | `geolocation=()` |
| `any` | — | `geolocation=*` |
| `self` | `https://a.example` | `geolocation=(self "https://a.example")` |

Features are emitted alphabetically, joined into one `Permissions-Policy` header.

## Setting it with Drush (no UI)

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("permissionspolicy.settings");
  $c->set("enforce.enable", TRUE);
  $c->set("enforce.features.geolocation", ["base" => "none"]);
  $c->set("enforce.features.camera", ["base" => "self"]);
  $c->save();
'
drush cr
```

Baseline default (config/install) is `enforce: { enable: true, features: {} }` — enabled but
with no features, so it emits nothing until you add some.
