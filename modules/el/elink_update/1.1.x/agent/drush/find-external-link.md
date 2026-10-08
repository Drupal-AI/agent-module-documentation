<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Link Update — Drush & form

## Admin form
`/admin/config/elink-update` (`ExternalLinkUpdateForm`, `access administration pages`):
- `link_update_content_type` — checkboxes of content types to scan.
- `link_target_type` — `_blank` / `_self` / `_parent` / `_top`.
- `link_rel_attribute` — `nofollow` / `noreferrer` / `noopener`.
Submitting builds a Batch that runs `process_node()` per node.

## Drush
```
drush elink-update:find-external-link
```
Defined in `src/Commands/DrushExtLinkUpdateCommand.php` (`drush.services.yml`, tag `drush.command`). Builds the same batch and runs it via `drush_backend_batch_process()`.

## What it changes
For each selected node with a non-empty body, `_update_external_links()` parses the body HTML and adds the chosen `target` and `rel` attributes to external `<a>` tags, then resaves the node. Link destinations are not modified.
