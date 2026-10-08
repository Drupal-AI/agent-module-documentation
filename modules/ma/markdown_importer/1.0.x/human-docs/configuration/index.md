# Configuration

Markdown Importer is driven entirely from a single import form. There is nothing to
switch on first — you fill in the form and run the import.

## Open the import form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Import Markdown**, or navigate directly to
   `/admin/config/services/import-markdown`.

## Run an import, field by field

- **Repository URL** — the address of the public repository that holds your
  Markdown files. It must be publicly accessible; private repositories are not
  supported in this version.
- **Platform** — choose **GitHub**, **GitLab**, or **Private‑hosted Git repository**
  so the module knows how to fetch files. If the URL or platform is invalid, the
  form reports the error rather than importing.
- **Content type** — the Drupal content type that imported Markdown becomes. Each
  Markdown file is created as a node of this type.
- **Target field** — the field on that content type where the converted content is
  stored (for example **Body**). This list updates via AJAX to match the content
  type you picked, so only compatible fields are offered.

Click **Import Markdown** to start. The module scans the repository recursively —
including subdirectories — for `.md` files, converts each one to HTML with
CommonMark, and creates the nodes.

## How the content is converted

Conversion uses secure defaults: raw HTML in the source is stripped
(`html_input: strip`) and unsafe links are disallowed (`allow_unsafe_links:
false`). As a result, Markdown files that rely on embedded HTML or custom tags may
not render those parts unless the parser is explicitly configured to allow them.

## Advanced (for developers)

- Customise the CommonMark parser settings — for example to enable heading
  permalinks or custom attributes — with the `hook_markdown_importer_config_modify()`
  hook in a custom module.
- Use the **`MarkdownProcessor`** service to run imports programmatically.
