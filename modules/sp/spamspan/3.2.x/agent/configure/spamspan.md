# Configure SpamSpan

SpamSpan has **no dedicated settings form**. The `configure` route in `spamspan.info.yml`
is core's `filter.admin_overview` (`/admin/config/content/formats`). You configure it by
adding its filter to a text format.

## Enable the filter on a text format

1. Go to **Admin > Configuration > Content authoring > Text formats and editors**
   (`/admin/config/content/formats`), edit a format (e.g. Full HTML).
2. Under **Enabled filters**, check **"SpamSpan email address encoding filter"**.
3. Set the **filter processing order** so SpamSpan runs after filters that generate HTML
   (e.g. after "Convert URLs into links"), so it can catch generated `mailto:` links.
4. Configure its options under **Filter settings** (see below), then Save.

Filter plugin: `filter_spamspan`, type `TYPE_TRANSFORM_IRREVERSIBLE`. It obfuscates
bare addresses, `mailto:` links, and optional `address[url|text]` syntax, and attaches the
`spamspan/obfuscate` JS library (plus `spamspan/atsign` CSS when the graphic option is on).

## Filter settings (defaults from the plugin annotation)

| Setting key | Type | Default | Meaning |
|---|---|---|---|
| `spamspan_at` | string | `" [at] "` | Text shown in place of `@` when JS is off. |
| `spamspan_use_graphic` | bool | `FALSE` | Use an image for `@` (adds `spamspan/atsign` CSS); overrides `spamspan_at`. |
| `spamspan_dot_enable` | bool | `FALSE` | Also replace `.` in the address. |
| `spamspan_dot` | string | `" [dot] "` | Text shown in place of `.` when `spamspan_dot_enable` is on. |
| `spamspan_use_form` | bool | `FALSE` | Link to a contact form instead of exposing `mailto:`. |
| `spamspan_form_pattern` | string | `<a href="%url?goto=%email">%displaytext</a>` | Markup for form mode; tokens `%url`, `%email` (base64+urlencoded), `%displaytext`. |
| `spamspan_form_default_url` | string | `"contact"` | Form URL when none given in `addr[url]`. |
| `spamspan_form_default_displaytext` | string (label) | `"contact form"` | Link text when none given. |

In-content override syntax when `spamspan_use_form` is on:
`user@example.com[mycontactform|Contact me using this form]`.

Config schema types: `filter_settings.filter_spamspan` and
`field.formatter.settings.email_spamspan`, both mapping to `spamspan_plugin_settings`
(`config/schema/spamspan.schema.yml`).

## Email field formatter (`email_spamspan`)

For core **Email** fields, at **Manage display** choose the **"Email SpamSpan"** formatter.
It exposes the same 8 settings as the filter (shared `SpamspanSettingsFormTrait`) and
obfuscates the field value via the `spamspan` service, attaching `spamspan/obfuscate`.

## Rendered output shape

`me@example.com` →
`<span class="spamspan"><span class="u">me</span> [at] <span class="d">example.com</span></span>`
— reassembled into a real `mailto:` link by JS in the browser.

## Test / preview page

`/admin/config/content/formats/spamspan` (route `spamspan.test`, form
`SpamspanTestForm`, requires core permission **`administer filters`**) lets you paste text
and preview the obfuscation. It also appears as a task/tab under the Text formats page.

## Drush config

No SpamSpan-specific Drush commands. Settings live inside each format's config
(`filter.format.<id>.yml`, `filters.filter_spamspan.settings`) and each formatter's display
config, so `drush config:export` / `config:import` handle them like any core config.
