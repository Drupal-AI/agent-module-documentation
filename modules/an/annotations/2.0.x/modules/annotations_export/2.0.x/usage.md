<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Annotations Export writes a site's assembled annotation context to disk as markdown or an Obsidian vault via Drush.

---

Annotations Export is a CLI-only companion to annotations_context. The `annotations:export` command (alias `ann:ex`) assembles the site's annotation context and writes it either as a single markdown document (to a file or stdout) or as an Obsidian vault — one `.md` file per annotation target, each with YAML frontmatter (target/entity_type/bundle/aliases/tags) and a Relationships section of `[[wikilink]]` references built from entity-reference traversal. It reuses `ContextAssembler`/`ContextRenderer` and, being a privileged Drush caller, includes all annotation types by default regardless of consume permissions; `--annotation-types` narrows the output. Options mirror the context assembler: `--target`, `--entity-type`, `--ref-depth`, `--inc-meta`, `--inc-refs`, plus `--format`, `--output`, and `--strip-headings`. There are no web routes. Requires `annotations` and `annotations_context`.

---

- Export all annotation context as markdown to stdout.
- Write the markdown export to a file (`--output`).
- Export as an Obsidian vault (one file per target).
- Emit YAML frontmatter per Obsidian note (target, entity type, bundle, aliases, tags).
- Build `[[wikilink]]` relationships from entity-reference traversal.
- Limit export to a single target (`--target=node__article`).
- Limit export to all targets of an entity type (`--entity-type=node`).
- Restrict output to chosen annotation types (`--annotation-types=editorial,rules`).
- Traverse entity references to a chosen depth (`--ref-depth`).
- Include field metadata (`--inc-meta`) and incoming references (`--inc-refs`).
- Strip markdown heading markers for plain-text terminals (`--strip-headings`).
- Include all annotation types by default (privileged CLI caller).
- Create the Obsidian vault directory if it does not exist.
- Produce onboarding/handover documentation bundles from annotations.
- Feed an external knowledge base or note system from Drupal.
- Run entirely from Drush with no web exposure.
