# Configuration

Setting up Content Guide is two steps: tell it where your Markdown guide files
live, then attach a guide to each field that needs one.

## 1. Set the base document path

1. Log in as a user with the **Administer content guide** permission (a site
   builder role, kept restricted).
2. Go to **Configuration → Content authoring → Content Guide**
   (`/admin/config/content/content_guide`).
3. Set the **base document path** — the directory (relative to the Drupal root)
   under which your Markdown guide files live. Keeping your guides here means you
   can version them as Markdown in the repository alongside the rest of your site.

## 2. Attach a guide to a field

1. Go to the entity's **Manage form display**
   (**Structure → Content types → *(your type)* → Manage form display**).
2. Open the widget's **third-party settings** (the cog/settings area for that
   widget) and set the guide's **document path**.
   - An **autocomplete** lists the `.md` files found under your configured base
     path, so you can pick the right file without typing the whole path.
3. Choose how the guidance appears — as a **tooltip** or as an additional
   **description** beside the field.

The widget then attaches JavaScript that fetches and renders the guide when the
form loads. Coverage isn't limited to plain fields: event subscribers extend it to
**Paragraphs**, **Media**, and **entity-reference** widgets, and the
`cg_field_group` submodule wires guides into Field Group.

## Localized guidance

If a language-specific variant of a document exists — `name.{langcode}.md`
alongside `name.md` — it is served automatically for that interface language, so
you can localize your authoring guidance.

## Reuse and links

- The same guide document can be reused across multiple fields.
- Internal links inside a guide are resolved to site URLs, and the rendered output
  is filtered through Drupal's admin XSS filter (`Xss::filterAdmin`).

## Permissions

- **Administer content guide** — who may configure the base path and attach guides.
  Keep this restricted to site builders.
- **Use content guide** — who may see rendered guidance while authoring.
