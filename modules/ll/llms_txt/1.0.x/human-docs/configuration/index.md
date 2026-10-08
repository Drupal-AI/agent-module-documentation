# Configuration

The `/llms.txt` file is built from two sources, combined in this order: the
**config body** first, then your published **sections**. You edit both from the
admin, and both require the *Administer /llms.txt configuration* permission.

## 1. The config body

1. Log in as a user with the **Administer /llms.txt configuration** permission.
2. Go to **Content → llms.txt**, or navigate directly to
   `/admin/content/llms-txt`.
3. Edit the content field and save.

This is a single block of Markdown that becomes the top of the file. It supports
**tokens**, so you can pull in dynamic values:

- Core tokens such as `[site:name]` and `[site:slogan]` (the shipped default is a
  `# [site:name]` heading followed by `[site:slogan]`).
- The module's **menu tokens**: `[llms_txt_markdown_menu:<menu>]` renders a whole
  menu as a nested Markdown link list — for example
  `[llms_txt_markdown_menu:main]` for the main navigation, or `:footer`. Each
  item becomes `- [Title](absolute-url)`, up to three levels deep, access-checked
  so visitors only see links they may reach. This is the easiest way to hand AI
  agents a map of your site.
- If **markdownify_views** is installed, `llms_txt_views` tokens render any View
  display tagged `llms_txt_section` as Markdown.

Because this body lives in configuration, it is exportable and deployable with
configuration management — keep the generic, site-wide text here.

## 2. Sections

Sections are small content entities appended after the config body, each rendered
as a `## Title` heading followed by its Markdown body. Manage them at
**`/admin/content/llms-txt/sections`**:

- **Add** a section at `/admin/content/llms-txt/add-section`.
- Each section has a **Title** (required — it becomes the `## ` heading), a
  **Content** Markdown body (write Markdown, avoid raw HTML), a **Weight** that
  sets the order (lower weights appear first), and a **published** flag.
- Only **published** sections appear in `/llms.txt`; unpublish a section to hide
  it temporarily without deleting it.
- Edit, delete, and reorder sections from the collection page; a bulk-delete
  action is provided.

Because sections live in the database rather than in config, they are the right
place for environment-specific content (for example a staging-only notice) that
you do not want in your exported configuration.

## How it all comes together

When someone requests `/llms.txt`, the module replaces the tokens in the config
body, then appends each published section (in weight order) as a `## Title` block,
and serves the result as `text/markdown`. The output is render-cached and
invalidates correctly whenever you edit the config or a section, so changes show
up without a manual cache clear.
