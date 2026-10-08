# Configuration

The `/llms.txt` file is built from two parts you manage separately: a **config body**
(exportable, tokenised, for content identical across environments) and **sections**
(database entities, for per-site content). This page walks through both, plus the
Markdown-menu tokens and the permissions that gate access.

## Who can edit it

The admin screens are gated by two permissions, so you can delegate section editing
without handing over the whole file:

- **Administer /llms.txt configuration** (`administer llms.txt configuration`) —
  full access, including the config body form.
- **Administer /llms.txt sections** (`administer llms.txt sections`, new in 1.1.x) —
  a delegated permission that grants only create/edit/delete/collection access to
  sections, *without* the config body. Grant this to a content team.

Assign these at **People → Permissions** (`/admin/people/permissions`).

## Author the config body

1. Go to **Content → llms.txt** (`/admin/content/llms-txt`).
2. Edit the **content** field. This is the top matter of your llms.txt — typically a
   title and a short description of what the site offers. It is stored as Drupal
   configuration (`llms_txt.settings.content`), so it is exported with your config
   and deploys the same to every environment.
3. **Use tokens** for anything that should vary by environment or draw on site data
   — for example `[site:name]` and `[site:slogan]`, or the Markdown-menu tokens
   described below. Keeping this body generic-with-tokens is the recommended
   practice, so it stays deployable.
4. Save.

## Manage sections

Sections are for content that is specific to one site or environment and should
**not** be synchronized through configuration management.

1. Go to **Content → llms.txt → Sections** (`/admin/content/llms-txt/sections`).
2. Add a section. Each has a **title** and a **content** body in Markdown.
3. Set a **weight** to control the order — sections are appended after the config
   body and rendered in weight order as `## Title` blocks.
4. **Unpublish** a section to temporarily remove it from the output without deleting
   it.

Because sections live in the database, they never end up in your exported config —
ideal for per-environment notices (for example a staging vs production banner) or
site-specific additions that can't be expressed as tokens.

## Embed a menu as Markdown

The module adds a token type that renders any Drupal menu as a nested Markdown link
list — a convenient way to hand crawlers a map of your key pages. Insert a token
like:

```
[llms_txt_markdown_menu:main]
```

for the Main navigation menu, or swap `main` for another menu's machine name (for
example `footer`). The list is access-checked, uses absolute URLs, and renders up to
three levels deep. You can place these tokens in the config body.

If the optional **markdownify_views** module is enabled, additional `llms_txt_views`
tokens become available to render Views output (tagged for llms.txt) as Markdown.

## Caching

The `/llms.txt` output is render-cached with proper invalidation, so authoring
changes are reflected without stale output, and the endpoint stays fast under
crawler traffic. On a multilingual site a path processor keeps `/llms.txt` at the
site root without a language prefix.
