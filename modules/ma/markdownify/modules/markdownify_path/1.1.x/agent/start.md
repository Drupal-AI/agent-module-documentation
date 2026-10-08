# Markdownify Path Alias — agent index

Submodule of **markdownify**. Adds one thing: `.md` works on **path aliases**
(`/blog/my-post.md`), not just canonical paths. Requires `markdownify` + core `path`.

- **Service:** `markdownify.alias_path_processor` (`MarkdownifyAliasPathProcessor`),
  tagged `path_processor_inbound` priority **101**. On an inbound `*.md` path it strips
  `.md`, resolves the alias via `path_alias.manager`, and rewrites to the Markdownify
  system path. Extends the parent's `MarkdownifyPathProcessor`.
- **No config, no schema, no permissions, no UI, no Drush.** Enabling it is the setup:
  `drush en markdownify_path -y`.
- Once enabled, the parent stops force-aliasing the canonical `.md` head link.

See the parent for how Markdown is actually generated and the other five access methods:
[../../../../1.1.x/agent/configure/settings.md](../../../../1.1.x/agent/configure/settings.md).
