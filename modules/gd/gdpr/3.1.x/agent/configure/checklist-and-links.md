<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The GDPR checklist and Content links

## Checklist (the `configure` route)

`gdpr` implements `hook_checklistapi_checklist_info()` to define a checklist `gdpr_checklist`
at `/admin/config/gdpr/checklist` (route `checklistapi.checklists.gdpr_checklist` — the
module's `configure` route). The items are grouped into: *Getting Started* (responsibility
agreement, recommended reading), *Policies* (cookie policy), *Content related suggestions*
(privacy policy existence/publish/menu), *Site feature related suggestions* (tracking, social
media, module data collection, role permissions), *Configuration* (allow account cancel,
allow data removal) and *Beyond website management* (legal adviser, enable GDPR submodules,
breach notice, logging responsibility).

Progress is stored by the Checklist API (module `checklistapi`), not by `gdpr`; the checklist
also lists which recommended/tracking/social modules are enabled vs missing, and its
percentage appears on the Status Report (`hook_requirements()`).

## Content links (config `gdpr.content_mapping`)

Form `Drupal\gdpr\Form\ContentLinksForm` at `/admin/config/gdpr/content-links`
(route `gdpr.content_links_form`, permission `administer site configuration`) records the URL
of four standard pages, **per language**, so the checklist can show whether each is
configured.

- Config object: **`gdpr.content_mapping`**, key **`links`**.
- Shape: `links.<langcode>.<key>` where `<key>` ∈
  `privacy_policy`, `terms_of_use`, `about_us`, `impressum`
  (labels from `ContentLinksForm::requiredContentList()`).
- Values are stored as URIs: user-entered paths become `internal:/path`, full URLs are kept
  as-is (`ContentLinksForm` maps displayable strings ⇄ URIs).

```yaml
# config: gdpr.content_mapping
links:
  en:
    privacy_policy: 'internal:/privacy-policy'
    terms_of_use: ''
    about_us: ''
    impressum: ''
```

Set programmatically:
```php
\Drupal::configFactory()->getEditable('gdpr.content_mapping')
  ->set('links', ['en' => ['privacy_policy' => 'internal:/privacy-policy']])
  ->save();
```

Read it back with `\Drupal::config('gdpr.content_mapping')->get('links')`.

There is no config schema shipped for this object and no other settings form in the base
module (submodule settings live in their own modules).
