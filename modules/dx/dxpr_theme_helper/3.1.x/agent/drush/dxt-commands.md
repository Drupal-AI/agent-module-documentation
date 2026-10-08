<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `dxt:*` Drush command suite

All commands live under the `dxt:` namespace (Drush attribute commands). State-changing
commands support `--dry-run` and `--theme=<name>`. Settings introspection is driven by the
bundled `data/settings-schema.json` (sections: block-design, colors, custom-css, fonts, header,
layout, page-title, typography).

> **Targeting a theme:** `dxt:config:*` and `dxt:palette:*` read/write a **DXPR Theme's**
> settings config (`<theme>.settings`), so a DXPR Theme (or subtheme) must be installed — else
> they error "No DXPR theme found. Specify one with --theme." `dxt:config:list` still works
> without one (it reads the bundled schema).

## Config commands (`DxprThemeConfigCommands`)

| Command | Alias | Key args/options |
|---|---|---|
| `dxt:config:get <key>` | `dxt-cg` | `--theme`. Prints a setting value with schema metadata. |
| `dxt:config:set <key> <value>` | `dxt-cs` | `--theme`, `--dry-run`, `--append`. Validates against schema, rebuilds CSS. |
| `dxt:config:list` | `dxt-cl` | `--section`, `--detail`, `--keys-only`, `--sections-only`, `--theme`. |
| `dxt:config:export` | `dxt-ce` | `--file`, `--section`, `--theme`. Import-compatible YAML. |
| `dxt:config:import <file>` | `dxt-ci` | `--theme`, `--dry-run`. Validates all values first. |
| `dxt:config:reset` | `dxt-cr` | `--section`, `--theme`, `--dry-run`. Reset to schema defaults. |
| `dxt:palette:get` | `dxt-pg-colors` | `--theme`. Palette + Bootstrap variable/class mapping. |
| `dxt:palette:set <colors…>` | `dxt-ps-colors` | key=#hex pairs, `--theme`, `--dry-run`. |

Introspect valid values before setting:

```bash
drush dxt:config:list --sections-only
drush dxt:config:list --section=header --detail    # types, options, ranges, defaults
drush dxt:config:set header_top_layout centered
drush dxt:palette:set base=#6C3CE1 basetext=#ffffff accent1=#00D4FF
```

## Page (node layout) commands (`DxprThemePageCommands`)

| Command | Alias | Options |
|---|---|---|
| `dxt:page:get <nid>` | `dxt-pg` | Read a node's DXPR layout fields. |
| `dxt:page:set <nid>` | `dxt-ps` | `--layout` (fullwidth\|boxed), `--hide-regions` (csv), `--content-width` (full\|1-3\|1-2\|2-3\|5-6), `--dry-run`. |

These operate on the `field_dth_*` fields (which must be attached to the node's content type —
see [../configure/blocks-and-fields.md](../configure/blocks-and-fields.md)).

## AI generation commands (`DxprThemeAiCommands`)

| Command | Alias | Options |
|---|---|---|
| `dxt:generate:palette "<prompt>"` | `dxt-gp` | `--apply`, `--dry-run`, `--theme`. |
| `dxt:generate:fonts "<prompt>"` | `dxt-gf` | `--apply`, `--dry-run`, `--theme`. |

Require the optional `drupal/ai` module configured with a chat provider — see
[../api/ai-generators.md](../api/ai-generators.md).

## Other commands

- `dxt:subtheme:create [name]` (`dxt-sc`) — create a DXPR Theme subtheme from the starterkit.
- `dxt:setup-ai` (`dxt-sa`) — install AI-assistant skill files (`--host=claude|agents`) to the
  project root so tools discover the `dxt:*` commands. `hook_requirements()` warns when the
  installed skill files are outdated.
