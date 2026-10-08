# Configure title rules

Config object **`node_title_validation.settings`**, single key `node_title_validation_config`.
UI: route `node_title_validation.admin_form` → `/admin/config/content/node-title-validation`
(permission `node title validation admin control`). The form renders one fieldset per node type.

## Config shape

```yaml
node_title_validation_config:
  content_types:
    article:                 # keyed by node bundle machine name
      exclude: "!,@,#,spam"  # comma-separated blocked characters/words (string)
      comma: false           # also block the ',' character
      min: 10                # min title length in characters (int, nullable)
      max: 120               # max title length in characters (int, nullable)
      min-wc: 2              # min word count (int, nullable)
      max-wc: 12             # max word count (int, nullable)
      unique: true           # reject a title already used by another node of THIS type
    page:
      ...
  unique: false              # "unique for all content types" toggle (see caveat)
```

Only content types that have at least one non-empty rule need an entry; a missing key means "no
rule". Empty/zero-ish values are treated as "not set" by the validator (`if ($config_value)`), so
`min: 0` effectively disables the min rule.

## Rule semantics

| Key | Effect |
|---|---|
| `min` / `max` | Character length bounds (`mb_strlen`). |
| `min-wc` / `max-wc` | Word-count bounds (split on single spaces). |
| `exclude` | Blocklist. Single-character entries match anywhere in the title; multi-character entries match whole space-separated words. |
| `comma` | When true, adds `,` to the blocklist even if `exclude` omits it. |
| `unique` | Rejects saving if another node **of the same type** already has this exact title. |

Form-level validation also enforces `min <= max` and `min-wc <= max-wc`.

## Read / write with drush

```bash
drush cget node_title_validation.settings

# Set Article rules programmatically:
drush php:eval '
  \Drupal::configFactory()->getEditable("node_title_validation.settings")
    ->set("node_title_validation_config.content_types.article", [
      "exclude" => "spam,test", "comma" => FALSE,
      "min" => 10, "max" => 120, "min-wc" => NULL, "max-wc" => NULL, "unique" => TRUE,
    ])->save();
'
```

There is no cache to clear for the rules to take effect; the validator reads config live. (The
*constraint attachment* itself is cached in entity field definitions, but that is installed once
when the module is enabled.)

## Caveat: global `unique`

The top-level `node_title_validation_config.unique` ("Unique node title for all content types") is
saved by the form but the validator never uses it — its uniqueness query is always
`loadByProperties(['title' => ..., 'type' => <this node's type>])`. To enforce uniqueness, set the
**per-type** `unique` flag on each content type you care about.
