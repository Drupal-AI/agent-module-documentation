<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — settings, form route, view modes

## Global settings form
Route `forward.settings`, path `/admin/config/user-interface/forward`, form `Form\SettingsForm`,
permission `administer forward` (`restrict access: true`). Writes config `forward.settings`
(schema `config/schema/forward.schema.yml`).

## Config `forward.settings` (key entries)
| Key | Default | Meaning |
|---|---|---|
| `forward_form_title` | `Forward this [forward:entity-type]…` | Page/section title (tokenised). |
| `forward_form_instructions` | tokenised text | Blurb above the form. |
| `forward_form_confirmation` | tokenised text | Message shown after sending. |
| `forward_max_recipients` | `1` | Max recipient addresses per send. >1 turns the recipient field into a textarea. |
| `forward_personal_message` | `1` | 0=off, 1=optional, 2=required personal message field. |
| `forward_personal_message_filter` | `false` | Allow limited HTML (`forward_personal_message_tags`) in the message. |
| `forward_personal_message_tags` | `p,br,em,strong,cite,code,ul,ol,li,dl,dt,dd` | Allowed tags when filter on. |
| `forward_form_allow_plain_text` | `false` | Offer HTML/plain-text choice to sender. |
| `forward_form_display_page`/`_subject`/`_body` | `false` | Show a preview of link/subject/body on the form. |
| `forward_email_subject` | `[forward:sender-name] has forwarded…` | Email subject (tokenised). |
| `forward_email_message` | tokenised | Email header line. |
| `forward_email_footer` | `''` | Email footer. |
| `forward_email_logo` | `''` | Path to a logo in the email. |
| `forward_email_from_address` | (unset → site mail) | From/envelope address. |
| `forward_filter_format_html` / `_plain_text` | `''` | Filter format applied to the rendered body (e.g. Pathologic for link fixing). |
| `forward_bypass_access_control` | `0` | If 1, render as the current (logged-in) user instead of switching to anonymous. |
| `forward_flood_control_limit` | `10` | Max sends per hour (per `forward.send` flood event). |
| `forward_flood_control_error` | message | Shown when the limit is hit. |
| `forward_form_noindex` | `true` | Add noindex to the forward page. |

```bash
ddev drush cset forward.settings forward_max_recipients 5 -y
```

## The Forward form
Route `forward.form` = `/forward/{entity_type}/{entity}`; requires `access forward` **and**
`_entity_access: entity.view` on the target entity. Fields: your email, your name, recipient(s),
optional personal message, optional format select. On submit the entity is rendered (first matching of
the `forward`, `teaser`, `full` view modes) as the **anonymous** user (unless
`forward_bypass_access_control`), tokens are replaced, the optional filter format is applied, and the
mail is sent per recipient. `Reply-To` is set from the sender name/email (encoded via Symfony
`UnstructuredHeader`). Sends are logged and flood-registered.

## View mode
Create a `forward` view mode on the entity's *Manage display* to control exactly what is emailed;
otherwise `teaser`/`full` is used.

## Displaying the entry point
Use the field formatters (see [../api/api.md](../api/api.md)): `forward_link` for a link, `forward_form`
for the inline form, on the entity's Manage display.
