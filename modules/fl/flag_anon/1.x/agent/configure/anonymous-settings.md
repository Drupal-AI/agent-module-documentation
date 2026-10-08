# Enable and configure Flag Anonymous on a flag

There is **no configure route** (`configure: null`). You configure it per flag in the
**"Anonymous settings"** section that `flag_anon_form_flag_form_alter()` adds to the flag
edit form (`/admin/structure/flags/manage/<flag_id>`), or directly in the flag config entity.

## Where it is stored

Config entity: `flag.flag.<flag_id>`, under `third_party_settings.flag_anon` (schema id
`flag.flag.*.third_party.flag_anon`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled` | integer | 0 | Master switch — show the anon message for this flag. |
| `label_display` | string | `original` | `original` = keep flag label, show message in a popin on click; `custom` = replace the label with the message. |
| `popin_title` | label | `Attention` | Title of the popin (only when `label_display: original`). Blank = no title. |
| `message` | label | `@login or @register to use this flag.` | The CTA text; `@login` / `@register` become links. |
| `login_label` | label | `Login` | Text of the `@login` link. |
| `register_label` | label | `Register` | Text of the `@register` link. |
| `popup` | integer | 0 | Open login/register forms in a modal dialog (`core/drupal.dialog.ajax`). |
| `popup_login` | string | `{"width": "auto"}` | JSON for the login link's `data-dialog-options`. |
| `popup_register` | string | `{"width": "auto"}` | JSON for the register link's `data-dialog-options`. |

**Important:** the entity builder (`flag_anon_form_flag_form_builder()`) only writes these
settings when `enabled` is truthy; when you disable it, every `flag_anon` third-party setting
is unset from the flag.

**Precondition:** the anonymous role must NOT have flag/unflag permission for the flag —
otherwise the anonymous user is "allowed" and sees the normal link, not the CTA. Remove it at
`/admin/people/permissions#module-flag`.

## Via the UI

1. Go to **Structure → Flags** (`/admin/structure/flags`), edit a flag.
2. Open **Anonymous settings**, tick "Show this flag to anonymous users even if they don't
   have permission to use it."
3. Choose Label display, edit the Message (use `@login` / `@register`), set link labels, and
   optionally enable the popup with dialog-options JSON.
4. Save flag.

## Via drush (scriptable)

```bash
drush php:eval '
  $flag = \Drupal::entityTypeManager()->getStorage("flag")->load("bookmark");
  $flag->setThirdPartySetting("flag_anon", "enabled", 1);
  $flag->setThirdPartySetting("flag_anon", "label_display", "custom");
  $flag->setThirdPartySetting("flag_anon", "message", "@login or @register to bookmark this.");
  $flag->setThirdPartySetting("flag_anon", "login_label", "Sign in");
  $flag->setThirdPartySetting("flag_anon", "register_label", "Join");
  $flag->save();
'
# Read back:
drush cget flag.flag.bookmark third_party_settings
```

Disable by unsetting the settings (or `setThirdPartySetting('flag_anon','enabled',0)` then
re-saving through the form, which strips them).
