# Form File Usage — manual setup guide

**Form File Usage** (`form_file_usage`) is a developer tool that **automatically
keeps track of files uploaded through custom forms** — the ones you build with the
Form API rather than through entity fields. It marks those files **permanent** and
records their **file usage**, so Drupal knows they're in use and cron won't delete
them as orphaned temporary files.

It exists to fix a well‑known pitfall. When you use a `managed_file` element (a
file upload) or a `text_format` element (a CKEditor field with inline images) in a
**custom** form — a configuration form, a block plugin, a custom submission —
Drupal saves the uploaded files as *temporary*. Unlike entity fields, custom Form
API elements don't bind files to a storage context, so core never learns they're
being used, and cron eventually deletes them. The traditional fix is tedious
boilerplate in `submitForm()` using the file‑usage service (plus manual HTML
parsing to find CKEditor image UUIDs). Form File Usage automates all of that.

It works by **state synchronization**: instead of tracking historical form values,
it cross‑references the current form inputs against the live `file_usage` records
in the database. Newly added files are promoted to permanent and their usage
registered; when a file is removed and nothing else references it, the module
demotes it back to temporary so cron can safely reclaim the space. It understands
CKEditor 5 inline images (via `data-entity-uuid`) and can auto‑detect the
configuration name for forms extending `ConfigFormBase`.

This is a developer/file‑management utility with **no content or access role** and
no settings form — you switch it on per element (or call its service directly), as
shown below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires core File).

There is **no configuration page** for this module — it's a developer API. How you
apply it is described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it from code, on the custom forms and
plugins that accept file uploads.

## How to use it

There are three ways to apply it, depending on your form:

**1. Configuration forms (automatic).** Add `'#track_file_usage' => TRUE` to your
`managed_file` or `text_format` element. For forms extending `ConfigFormBase`, the
module auto‑detects the configuration object name:

```php
$form['promo_text'] = [
  '#type' => 'text_format',
  '#title' => $this->t('Promo text'),
  '#default_value' => $config->get('promo_text.value'),
  '#format' => $config->get('promo_text.format') ?? 'full_html',
  '#track_file_usage' => TRUE,
];
```

**2. Custom storage (State API, custom tables).** If your form doesn't use
`ConfigFormBase`, name the tracking context explicitly with
`'#file_usage_config'`:

```php
$form['badge_image'] = [
  '#type' => 'managed_file',
  '#title' => $this->t('Badge Image'),
  '#default_value' => $config->get('badge_image'),
  '#file_usage_config' => 'my_module.custom_storage_key',
];
```

**3. Inside plugins (manual API).** For files embedded in block plugins, Layout
Builder, Commerce panes, or custom entities, call the service directly from your
submit method. Always pass the value (even when empty) so removed files are cleaned
up:

```php
$text_value = $form_state->getValue(['my_text_element', 'value']) ?? '';
\Drupal::service('form_file_usage.manager')->syncUsage(
  $text_value,
  'text_format',
  'my_module',
  'block:' . $this->getDerivativeId() . ':my_text_element'
);
```

Once applied, files uploaded through those forms are retained instead of being
garbage‑collected, and are released again when they're no longer referenced.
