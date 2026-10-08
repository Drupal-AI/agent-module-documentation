<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Term Glossary (term_glossary) — agent index

Turns a taxonomy vocabulary into a glossary. It auto-scans configured text fields at render
time and wraps any occurrence of a glossary term (or its synonyms) in a tag; clicking the tag
shows the term definition in a jQuery UI dialog, a Tippy.js tooltip, a plain link, or your own
JS. Also ships an A–Z "Glossary alphabetical" block backed by three JSON search endpoints.
Highlighting runs in a `preprocess_field` hook, not a text-format filter.

- Dependencies: `drupal:taxonomy`, `drupal:text`, `jquery_ui_dialog:jquery_ui_dialog` (composer `drupal/jquery_ui_dialog:^2`). Core `^10.3 || ^11`.
- Configure route: `term_glossary.glossary_config_form` → `/admin/config/glossary` (`administer site configuration`).
- Defines a plugin type (`TermGlossaryHandler`), config schema, and 4 alter hooks. No permissions of its own, no drush commands.
- Submodules: `term_glossary_abbr` (adds an `abbr` handler), `term_glossary_tippy` (adds a `tippy` handler + libraries), `term_glossary_per_node` (per-node opt in/out, its own permission).

## What you'd do
- **Set the glossary vocabulary + global matching options + presentation handler** → [configure/settings.md](configure/settings.md)
- **Turn on auto-highlighting for a specific field (and optional per-field vocab)** → [configure/field-integration.md](configure/field-integration.md)
- **Place the A–Z search block / call the JSON endpoints** → [blocks/alphabetical-block.md](blocks/alphabetical-block.md)
- **Add a new presentation handler plugin** → [plugins/handlers.md](plugins/handlers.md)
- **Call the manager service or alter results/term data/match markup** → [api/services.md](api/services.md)

## Key facts
- Config objects: `term_glossary.glossaryconfig` (main), `term_glossary.glossaryconfig.jqueryui` (dialog options).
- Main keys: `vocab` (comma-joined vocabulary machine names), `integration_type` (handler id), `single_match`, `single_match_per_content`, `full_word`, `boundary_exceptions`, `case_sensitive`, `per_term_options`, `term_synonyms`, `synonyms_field`, `match_all_synonyms`, `exclude_self_reference`, `view_mode`, `json_term_cache`, `ignore_tags`.
- Built-in handler ids: `default` (jQuery UI dialog), `custom_js`, `link`. Submodules add `abbr`, `tippy`.
- Service: `term_glossary.manager` (`Drupal\term_glossary\Service\TermGlossaryManager`, interface `TermGlossaryManagerInterface`). Plugin manager: `plugin.manager.term_glossary.term_glossary_handler`. Logger: `logger.channel.term_glossary`.
- Plugin type: `TermGlossaryHandler` (dir `Plugin/TermGlossaryHandler`, base `TermGlossaryHandlerBase`, interface `TermGlossaryHandlerInterface`, annotation `Drupal\term_glossary\Annotation\TermGlossaryHandler`, discovery-alter `term_glossary_handler_info`).
- Block: `glossary_alphabetical_bock` (theme hook `glossary_alphabetical_block`, template `glossary-alphabetical-block.html.twig`).
- Routes: `…apiSearch_per_letter` `/glossary-search-letter/{letter}`, `…apiSearch_per_term` `/glossary-search-term?t=`, `…get_term_by_id` `/glossary-get-term-by-id/{tid}` (all `access content`); config form `/admin/config/glossary`.
- Alter hooks: `hook_term_glossary_alter_results`, `hook_term_glossary_alter_result`, `hook_term_glossary_term_data_alter`, `hook_term_glossary_term_match_alter` (see `term_glossary.api.php`).
- Formatters that expose the "Enable term glossary" toggle: `text_default`, `text_trimmed`, `string`.
