# Configure Wordfilter

## 1. Create a Wordfilter configuration

- UI: *Configuration → Content authoring → Wordfilter configurations*
  (`entity.wordfilter_configuration.collection`, `/admin/config/wordfilter_configuration`).
- Add a configuration; choose the **Implementation** (process): **Direct substitution** (`default`)
  or **Token substitution** (`token`).
- Add one or more **items**, each with:
  - **Words to filter** — comma/newline-separated list (stored as `", "`-joined string).
  - **Substitution text** — what matches are replaced with (optional; empty removes the word).
- Config entity: `wordfilter.wordfilter_configuration.<id>` (schema `wordfilter.schema.yml`) →
  `process_id`, `items[]` (`delta`, `filter_words`, `substitute`).

## 2. Apply it — three ways

**A. Text-format filter** (`/admin/config/content/formats`):
enable **"Apply filtering of words"** (filter id `wordfilter`) on a text format, then in its
settings pick the **Active Wordfilter configurations**. Stored as `filters.wordfilter.settings.active_wordfilter_configs`.
The filter is `TYPE_TRANSFORM_IRREVERSIBLE` and adds cache tag `config:wordfilter_configuration_list`.

**B. Node / comment base fields** (title/body, subject):
on a content type (`/admin/structure/types`) or comment type (`/admin/structure/comment`) edit
form, a *Display settings → Active Wordfilter configurations* select is added
(`wordfilter_add_display_options_to_entity_form`). Stored as the type's third-party setting
`wordfilter.active_wordfilter_configs`. At render:
- `hook_entity_display_build_alter` filters node `title`/`body` and comment `subject`/`comment_body`.
- `template_preprocess_comment` filters the comment subject/title link.

**C. In code** — render a string through a format that has the filter enabled:
```php
$out = [
  '#type' => 'processed_text',
  '#text' => $raw_string,
  '#format' => 'plain_text', // a format with the wordfilter filter enabled
];
```

## Permissions (`wordfilter.permissions.yml`)

| Permission | Restricted? | Gates |
|---|---|---|
| `administer wordfilter configurations` | **yes** (`restrict access: true`) | full CRUD on all configurations; also grants create access |
| `access wordfilter configurations page` | no | view the configurations overview page |
| `administer wordfilter configuration <id>` | no (dynamic per config, `WordfilterPermissions`) | view/edit/delete that single configuration |

`WordfilterConfigurationAccessControlHandler` allows an operation if the user has the global
restricted permission or the matching per-config permission; **create** requires the global
restricted permission.

## Output-safety note (not a vulnerability)

Both process plugins pass every filter word and the substitution string through
`Xss::filterAdmin()` before building the regex/replacing (`WordfilterProcessBase::prepareWordsForRegex`,
`DefaultWordfilterProcess`, `TokenWordfilterProcess`), so `<script>`/event-handler/XSS vectors in a
substitution are stripped even though admin-allowed HTML tags survive. The node-title render path
prints via autoescaped Twig (`{{ filtered|nl2br }}`); body uses `processed_text`. The token process
runs `token->replace()` after the Xss filter. The only actors who can set substitution text hold
either the restricted global permission or a per-config `administer wordfilter configuration <id>`
permission — treat granting the per-config permission as granting admin-filtered-HTML authoring on
those fields.
