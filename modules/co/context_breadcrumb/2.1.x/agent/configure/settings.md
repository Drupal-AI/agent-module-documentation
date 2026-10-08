# Configuring Context Breadcrumb

## Global settings form

`\Drupal\context_breadcrumb\Form\ContextBreadcrumbSettingsForm` at
`/admin/config/user-interface/context-breadcrumb` (route `context_breadcrumb.settings_form`, permission
`administer context breadcrumb`). Config object `context_breadcrumb.settings`.

| Key | Default | Effect |
|---|---|---|
| `enable_json_ld` | `false` | When true, emit a Schema.org `BreadcrumbList` as `application/ld+json` on non-admin pages. |

```bash
ddev drush cset context_breadcrumb.settings enable_json_ld true -y
```

## Defining breadcrumbs (the real work is in Context)

Breadcrumbs are not stored in the settings config — they live on a **Context** entity's
`context_breadcrumb` reaction:

1. Go to *Structure → Context* (`/admin/structure/context`), add or edit a context.
2. Add conditions to control where it applies (path, role, the `taxonomy_vocabulary` condition this
   module provides, etc.).
3. Add the **Breadcrumb** reaction. It shows a draggable table of up to 9 rows, each with:
   - **Title** (textarea) and **URL** (textarea).
   - **Token** (select: None / Yes) — set to Yes when the title or URL contains a token; validation
     enforces this.
   - **Weight** — ordering.
   - **Cache query args** — newline-separated query args to vary the breadcrumb cache on (`!all` to
     cache on everything).
4. Save the context.

### URL/title rules (validation)

- If title is set, URL is required (and vice-versa the token must be chosen).
- Non-token URLs must be `<front>`, `<nolink>`, an absolute `http(s)://…`, or start with `/`.

### Tokens

Supported token types: `node`, `user`, `term`, `vocabulary`. Special taxonomy token
`[term_hierarchy]` builds a trail from a term's ancestors; it accepts a field pointer such as
`[term_hierarchy:node:field_category]`. A token browser link is shown on the form when the Token module
is enabled.

The active context's reaction is applied by `ContextBreadcrumbBuilder` (a `breadcrumb_builder` tagged
at priority 9999, so it overrides core and most other breadcrumb builders).
