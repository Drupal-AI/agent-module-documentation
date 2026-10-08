# Configure Devel Accessibility

Single settings form at route **`devel_a11y.settings`** →
`/admin/config/development/devel/a11y`, form `\Drupal\devel_a11y\Form\Settings`
(a `ConfigFormBase`, form id `devel_a11y_settings_form`), gated by permission
**`access devel information`** (Devel's own permission — the module defines none).
It appears as a tab and a menu link under Devel's settings (`devel.admin_settings`)
via `devel_a11y.links.task.yml` / `devel_a11y.links.menu.yml`. `configure` in
`info.yml` points here.

## Config object `devel_a11y.settings`

Three booleans, each wired to a checkbox with `#config_target`. Defaults (from
`config/install/devel_a11y.settings.yml`) are **all TRUE**.

| Config key | Form checkbox | Effect when on |
|---|---|---|
| `aural.announce.log` | Log announcements (ARIA live regions) | Attaches lib `devel_a11y/announce.log`; every `Drupal.announce()` call is echoed to the browser console. |
| `keyboard.tabbingmanager.log` | Log tabbing manager | Attaches lib `devel_a11y/tabbingmanager.log`; logs each tabbing-constraint activate/deactivate to the console. |
| `keyboard.tabbingmanager.visualize` | Visualize tabbing manager | Attaches lib `devel_a11y/tabbingmanager.visualize`; pulses/outlines the elements the tabbing manager currently allows. |

Config schema `config/schema/devel_a11y.schema.yml` types the object as a
`config_object` with `constraints: FullyValidatable`; all three leaves are
`type: boolean`.

## Set it with Drush / PHP

```bash
drush cget devel_a11y.settings
drush cset devel_a11y.settings keyboard.tabbingmanager.visualize false -y
```

```php
\Drupal::configFactory()
  ->getEditable('devel_a11y.settings')
  ->set('aural.announce.log', TRUE)
  ->set('keyboard.tabbingmanager.log', TRUE)
  ->set('keyboard.tabbingmanager.visualize', FALSE)
  ->save();
```

## What happens at runtime

`\Drupal\devel_a11y\Hook\Attachments::pageAttachments()`
(`#[Hook('page_attachments')]`) runs on every page. It adds the
`user.permissions` cache context, then **returns early unless the current user
has `access devel information`** — so the aids are attached only for developers,
never for anonymous or ordinary users. For a permitted user it attaches whichever
of the three libraries the matching config key has enabled. See
[../theme/libraries.md](../theme/libraries.md) for what each library's JS/CSS does.
