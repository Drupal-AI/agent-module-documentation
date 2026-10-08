# Configure the paste filter

There is **no dedicated settings form and no `configure` route** in `.info.yml`. The paste
filter is configured **per text format**, inside the CKEditor 5 plugin settings.

## Enable it (UI)

1. Go to **Admin → Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit (or add) a format.
2. Set its **Text editor** to **CKEditor 5**.
3. Under **CKEditor 5 plugin settings**, open the **Paste filter** vertical tab.
4. Check **Filter pasted content** (this is the `enabled` flag; off by default).
5. Optionally add / edit / reorder / remove filters (see below).
6. **Save configuration** at the bottom of the form.

The plugin does nothing until `enabled` is checked, and the help text + filter table only
appear once it is enabled (`#access` is gated on `enabled`).

## Where config lives

Stored on the **editor entity** (`editor.editor.{format}`), not a standalone config object,
under `settings.plugins.ckeditor5_paste_filter_pasteFilter`:

```yaml
settings:
  plugins:
    ckeditor5_paste_filter_pasteFilter:
      enabled: true
      filters:
        - { enabled: true,  weight: 1, search: 'Hello',  replace: 'World' }
        - { enabled: false, weight: 2, search: 'Before', replace: 'After' }
```

Schema: `config/schema/ckeditor5_paste_filter.schema.yml`
(`ckeditor5.plugin.ckeditor5_paste_filter_pasteFilter`). Each filter row is a mapping of
`enabled` (bool), `weight` (int), `search` (text), `replace` (text). Because it is part of the
editor config it **exports/deploys** with `drush config:export` alongside the text format.

## Each filter

- **search** — a JavaScript regular expression, entered **without delimiters**. It is compiled
  with flags `gimsu` (global, ignoreCase, multiline, dotAll, unicode). Special chars matched
  literally must be escaped, e.g. a closing paragraph tag is `<\/p>`.
- **replace** — the replacement string, may be empty (to delete matches), and may reference
  capture groups: `$1`, `$2`, …
- **enabled** — per-row toggle; disabled rows are kept in config but skipped at runtime.
- **weight** — run order (lower first); set by drag-and-drop in the table.

## Managing filters in the table

- **Add** a rule: click **Add another filter** (AJAX-adds a blank row).
- **Reorder**: drag rows — `weight` determines execution order.
- **Disable**: uncheck a row's Enabled box (kept in config, not applied).
- **Remove**: empty **both** the search and replace fields; the row is dropped on save.
  (Rows with a replacement but an empty search fail validation.)

## Default filters (Word / Google Docs cleanup)

When first enabled the plugin seeds ~14 filters (`defaultConfiguration()`), applied in this
order, that strip common office-suite cruft:

| search (regex) | replace | removes |
|---|---|---|
| `<o:p><\/o:p>` | `` | Word office `<o:p>` tags |
| `(<[^>]*) (style="[^"]*")` | `$1` | inline `style` attributes |
| `(<[^>]*) (face="[^"]*")` | `$1` | `face` attributes |
| `(<[^>]*) (class="[^"]*")` | `$1` | `class` attributes |
| `(<[^>]*) (valign="[^"]*")` | `$1` | `valign` attributes |
| `<font[^>]*>` / `<\/font>` | `` | `<font>` wrappers |
| `<span[^>]*>` / `<\/span>` | `` | `<span>` wrappers |
| `<p>&nbsp;<\/p>` | `` | `&nbsp;`-only paragraphs |
| `<p><\/p>`, `<b><\/b>`, `<i><\/i>` | `` | empty tags |
| `<a name="OLE_LINK[^"]*">(.*?)<\/a>` | `$1` | Word `OLE_LINK` anchors (keeps text) |

You can delete or edit any of these to fit your own filtering requirements.
