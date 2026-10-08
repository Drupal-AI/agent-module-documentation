# Drush commands

Defined in `ContentFirstCommands` (`drush.services.yml`, tag `drush.command`).

## `content-first:export` (alias `cf:export`)

Export nodes and/or menus as Markdown files (one file per entity/translation).

| Option | Default | Meaning |
|---|---|---|
| `--entity` | `all` | `node`, `menu`, or `all` (both). |
| `--bundles` | *(all)* | Comma-separated content types (nodes) or menu machine names. |
| `--status` | *(all)* | `1` published/enabled, `0` unpublished/disabled. |
| `--language` | *(all)* | Comma-separated langcodes. |
| `--folder` | `private://content_first/` | Output folder. |
| `--rewrite-links` | off | Rewrite internal page links to local filenames (Obsidian); strips query/fragment, `/en/about` → `en_about`. External links, images and document files untouched. |
| `--assets-base-url` | `''` | Prepend a base URL to relative image/document links (e.g. `https://example.com`). |
| `--flatten-properties` | off | Flatten nested front-matter keys with a dash (`meta: {title}` → `meta-title`). |

```bash
ddev drush cf:export --entity=node --bundles=article,page --status=1 --language=en,es
ddev drush cf:export --rewrite-links --assets-base-url=https://example.com   # full Obsidian import
ddev drush cf:export --entity=menu --bundles=main,footer
```

Menu files are named `menu-{langcode}-{name}.md`.

## `content-first:export-architecture` (alias `cf:architecture`)

Export entity **field architecture** as YAML files (via `EntityArchitectureExporter`).

| Option | Default | Meaning |
|---|---|---|
| `--entity-types` | `node` | Comma-separated fieldable entity type ids (node, paragraph, taxonomy_term, user, media, …). |
| `--bundles` | *(all)* | Comma-separated bundle machine names (applies to explicitly requested types). |
| `--folder` | `private://content_first/` | Output folder. |
| `--follow-references` | off | Also export entity types referenced by the exported types. |

```bash
ddev drush cf:architecture --entity-types=node --follow-references
ddev drush cf:architecture --entity-types=node,paragraph,taxonomy_term,user,media --folder=/tmp/arch
```
