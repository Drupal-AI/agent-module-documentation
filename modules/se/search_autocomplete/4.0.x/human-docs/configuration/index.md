# Configuration

All of Search Autocomplete's behaviour lives in **autocompletion configuration**
entities. Manage them at **Configuration → Search and metadata → Search
Autocomplete** (`/admin/config/search/search_autocomplete`), which lists every
configuration with **Add**, **Edit**, and **Delete** links.

## The shipped configurations

Three configurations are enabled when you install the module, so common search
fields work straight away:

- **search_block** — the core search block. Suggests matching node titles.
- **search_form_content** — the content search form. Suggests matching words.
- **search_form_users** — the user search form. Suggests usernames.

You can edit these or add your own. Each is backed by an optional View that
produces the suggestions.

## Fields on an autocompletion configuration

When you add or edit a configuration you'll set:

- **Label** and **machine name** — how you identify the configuration.
- **Selector** — the **CSS selector** of the input field you want to autocomplete,
  for example `#edit-keys`. (The search‑block configuration leaves this empty
  because it targets the block specially.)
- **Enabled** (status) — whether this autocompletion is active.
- **Minimum characters** (`minChar`) — how many characters someone must type
  before suggestions appear. Raise it (say to 3) to avoid querying on every
  keystroke.
- **Maximum suggestions** (`maxSuggestions`) — the largest number of suggestions
  shown in the dropdown.
- **Auto submit** — submit the form automatically when a suggestion is chosen.
- **Auto redirect** — send the visitor straight to the chosen suggestion's page.
- **No‑results message** — a custom label, value, and optional link shown when
  nothing matches. The placeholder `[search-phrase]` is replaced with what the
  visitor typed, so you can show "No results found for [search‑phrase]".
- **More‑results entry** — a custom "View all results for [search‑phrase]" label,
  value, and link that points at your full search results page.
- **Source** — where suggestions come from. Either a **callback URL**, or a View
  written as `view_id::display_id` (the module resolves it to the view's path and
  its exposed filters at render time).
- **Theme** — the CSS file used to style the suggestion dropdown, for example
  `basic.css`.
- **Editable / Deletable** — whether this configuration can be edited or deleted
  from the UI. Use these to lock down a configuration you don't want changed.

### Using a View as the suggestion source

Point the **source** at `view_id::display_id` to drive suggestions from any View.
The module also provides Views plugins (an autocompletion callback display, a row
plugin, and a serializer style) so you can build a dedicated JSON suggestion
endpoint from a View when you need full control over the results.

## The admin helper

There is one module‑wide setting, **admin helper**
(`search_autocomplete.settings:admin_helper`), off by default. When you turn it on,
an in‑page helper tool becomes available that lets you build a configuration by
clicking directly on a field on your site, rather than hand‑writing its CSS
selector.

## Permissions

- **Administer search autocomplete** (`administer search autocomplete`) — access to
  the admin UI and the add/edit/delete forms. This is the permission that manages
  configurations.
- **Use search autocomplete** (`use search autocomplete`) — lets a role actually
  get suggestions on the configured fields on the front end.

Grant them at **People → Permissions**, or with Drush:

```bash
drush role:perm:add authenticated 'use search autocomplete'
drush role:perm:add content_editor 'administer search autocomplete'
```

Whether a specific configuration can be edited or deleted is further governed by
its own **Editable** / **Deletable** flags.
