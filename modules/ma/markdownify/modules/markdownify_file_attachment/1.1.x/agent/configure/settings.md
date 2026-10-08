# Configure Markdownify File Attachment

Config object: **`markdownify_file_attachment.settings`** (schema in
`config/schema/markdownify_file_attachment.schema.yml`). Settings form
`markdownify_file_attachment.settings` at **`/admin/config/services/markdownify/file-attachment`**,
gated by the core **`administer site configuration`** permission.

## Keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `allowed_extensions` | sequence of strings | `[txt, yml, yaml, wsdl, json]` | file extensions whose **contents** are embedded inline in Markdown |
| `max_file_embed_size` | bytes (string like `'1 MB'`) | `1 MB` | files larger than this are linked, not inlined (also capped at PHP upload max) |

The form stores `allowed_extensions` as a newline-split, trimmed list and
`max_file_embed_size` as the raw string you type (schema type `bytes`, so `'2 MB'`, `524288`,
etc. all work — read it back with `Drupal\Component\Utility\Bytes::toNumber()`).

## Read / set via drush

```bash
drush cget markdownify_file_attachment.settings allowed_extensions
drush cget markdownify_file_attachment.settings max_file_embed_size

# add csv + md to the inline-able types:
drush php:eval '$c=\Drupal::configFactory()->getEditable("markdownify_file_attachment.settings");
$e=$c->get("allowed_extensions"); $e=array_values(array_unique(array_merge($e,["csv","md"])));
$c->set("allowed_extensions",$e)->save();'

# raise the inline size cap to 2 MB:
drush cset markdownify_file_attachment.settings max_file_embed_size "2 MB" -y
```

## Behaviour

There is nothing to enable per field: enabling the module makes **every** `file`-type field
on a supported entity render through the `md_file_attachment_file_embed` formatter during
Markdown generation (via `hook_markdownify_entity_build_alter`). A referenced file is inlined
only when its extension is in `allowed_extensions` **and** its size ≤ `max_file_embed_size`;
otherwise the Markdown shows just the filename, extension and absolute URL. See
[plugins/formatter.md](../plugins/formatter.md).
