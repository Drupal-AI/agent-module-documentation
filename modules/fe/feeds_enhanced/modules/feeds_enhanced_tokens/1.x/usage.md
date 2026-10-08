Feeds Enhanced - Token Support automatically expands any Drupal token found in Feed and Feed Type text fields and plugin configurations during every feed import, with no configuration required.

---

This submodule of **Feeds Enhanced** wires Drupal's Token system into the Feeds import pipeline. An event subscriber (`TokenExpansionSubscriber`) listens to `FeedsEvents::INIT_IMPORT` at priority 1000 and, before any fetcher/parser/processor runs, walks every Feed entity field property and every plugin configuration array, replacing `[token]` strings via the `TokenExpander` service. Token context is built per import: `feed`, `feed-type`, `current-user` (the account running the import — a real user in the UI or the cron user for scheduled imports), `date` and `site`. Expansion is universal (source URLs, SFTP hosts/paths, labels, processor default values, mappings, custom fields) and needs no per-field configuration. Feed-level plugin config is intentionally **not** written back — the subscriber expands feed-type-level config in memory only, leaving stored tokens intact so they re-expand each run; plugins that need feed-level tokens (e.g. the SFTP fetcher's host) expand them at runtime. A `hook_form_alter()` adds an "Available Tokens" token-browser to Feed and Feed Type forms (excluding delete/confirm forms). Session-based caching (`expandedTokenCache`, cleared on `IMPORT_FINISHED`) avoids re-expanding the same token+context within one import. Requires `token`, `feeds` and `dx_toolkit`; provides no routes, permissions, or config.

---

- Expand any Drupal token in a Feed's source URL (`https://api.example.com/user-[current-user:uid]/feed.json`).
- Build date-based SFTP directories and filenames (`/exports/[date:custom:Y/m/d]`, `import-[date:custom:His].csv`).
- Inject a Pantheon Secure Integration tunnel port into a host (`127.0.0.1:[pantheon_si_tunnel:pantheon_soip_ldap]/data.ldif`) with the Pantheon SI Tokens module.
- Keep tokens literal in stored feed config and resolve them dynamically on each import.
- Set dynamic feed labels (`Daily Import [date:custom:Y-m-d]`).
- Use `[current-user:uid]` in a processor owner-ID expression so imported nodes are owned by the importing user.
- Switch behavior between dev/stage/prod using `[site:*]` tokens in feed configuration.
- Expand tokens inside fetcher, parser and processor configuration arrays (recursively, at any nesting level).
- Expand tokens in custom fields added to Feed entities, not just the built-in source/label.
- Set feed source tokens programmatically in code (`$feed->setSource('...[token]...')`) and let import expand them.
- Discover available tokens via the built-in token browser on Feed and Feed Type edit forms.
- Reference `[feed:*]` / `[feed-type:*]` values to make imports self-describing.
- Avoid custom code for environment-aware or user-specific feed sources.
- Benefit from session caching so repeated identical tokens in a large feed config expand only once per import.
- Leave malformed or unknown tokens in place (expansion uses `clear => FALSE`, so unmatched tokens are not stripped).
- Combine with Feeds Enhanced's SFTP fetcher for dynamic, credential-safe scheduled transfers.
- Solve Feeds issues #3131079 and #3282260 (token support for HTTP fetcher source URL) without patching Feeds.
- Enable with `drush en feeds_enhanced_tokens -y`; no further setup.
