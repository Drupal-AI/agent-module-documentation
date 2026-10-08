# Configure exposed view modes + icons (per block content type)

There is **no module settings page**. All configuration is done per **block content type** and is
stored as third-party settings on that config entity — so it exports with config and is deployable.

## Where in the UI

Edit a block type at `admin/structure/block-content/manage/<bundle>` (Structure → Block types).
`BlockContentTypeEditForm::alterForm()` (`src/BlockContentTypeEditForm.php:12`) adds a **"View mode
icons"** details section (`#tree` = TRUE) containing one nested details per candidate view mode. The
candidates are `entity_display.repository:getViewModeOptionsByBundle('block_content', <bundle>)` (via
`ViewModeSelectorHelper::getViewModesForBundle()`). Each mode offers three inputs:

| Field | `#type` | Meaning |
|---|---|---|
| **Enabled** | checkbox | Show this view mode as a choice in the Layout Builder inline-block picker. Unchecked ⇒ omitted from the picker. |
| **Icon path** | textfield | Relative path (server-relative / stream wrapper URI) to the icon rendered next to the radio. |
| **Icon alt** | textfield | Alt text for that icon. |

Saving runs the appended submit callback `BlockContentTypeEditForm::saveForm()`
(`src/BlockContentTypeEditForm.php:74`), which writes:

```php
$blockContentType->setThirdPartySetting(
  'layoutbuilder_extras_view_mode_selector',
  'view_modes',
  $viewModesSettings, // keyed by view-mode machine name
);
$blockContentType->save();
```

## Stored data shape

Third-party settings provider `layoutbuilder_extras_view_mode_selector`, key `view_modes`. It is a
map keyed by view-mode machine name; each entry has:

- `view_mode_machine_name` (string — set to the map key)
- `view_mode_enabled` (bool)
- `view_mode_icon` (string — relative icon path)
- `view_mode_icon_alt` (string)

Note: `saveForm()` writes an entry for **every** candidate view mode (enabled or not), so absence of
a key means the whole block type was never configured, while `view_mode_enabled: false` means it was
configured and deliberately hidden.

## In exported config (`block_content.type.<bundle>.yml`)

```yaml
langcode: en
status: true
id: basic
label: Basic block
revision: 1
description: ''
third_party_settings:
  layoutbuilder_extras_view_mode_selector:
    view_modes:
      full:
        view_mode_machine_name: full
        view_mode_enabled: true
        view_mode_icon: 'public://vm-icons/full.svg'
        view_mode_icon_alt: 'Full width'
      teaser:
        view_mode_machine_name: teaser
        view_mode_enabled: false
        view_mode_icon: ''
        view_mode_icon_alt: ''
```

## Set it programmatically

```php
$type = \Drupal::entityTypeManager()->getStorage('block_content_type')->load('basic');
$type->setThirdPartySetting('layoutbuilder_extras_view_mode_selector', 'view_modes', [
  'full' => [
    'view_mode_machine_name' => 'full',
    'view_mode_enabled' => TRUE,
    'view_mode_icon' => 'public://vm-icons/full.svg',
    'view_mode_icon_alt' => 'Full width',
  ],
  'teaser' => [
    'view_mode_machine_name' => 'teaser',
    'view_mode_enabled' => FALSE,
    'view_mode_icon' => '',
    'view_mode_icon_alt' => '',
  ],
]);
$type->save();
```

## How it surfaces to editors

When an inline block of that bundle is added/edited in Layout Builder, the swapped block class
(`LayoutBuilderExtrasInlineBlock::blockForm()`, see [api/internals.md](../api/internals.md)) reads
these settings and, **only if any `view_modes` settings exist**, rewrites the `view_mode` element:
`#type` becomes `radios`, only entries with `view_mode_enabled` = TRUE remain, and each option label
is the rendered icon (`#theme => 'image'`, `#uri` = the icon path, `#alt` = the alt text) plus a
visually-hidden machine-name span. If a block type has no settings, the core select is left
untouched.
