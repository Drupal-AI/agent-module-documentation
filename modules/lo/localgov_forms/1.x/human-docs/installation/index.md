# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The following modules, which Composer pulls in as dependencies:
  - **Webform** (`webform`) and **Webform UI** (`webform_ui`) — the form engine and
    its editing interface.
  - Core's **Inline Form Errors** (`inline_form_errors`).
  - **Geocoder** (`geocoder`) — needed by the address-lookup component (you also need
    a Geocoder *provider*, see below).

This module is part of the **LocalGov Drupal** distribution.

> **Heads-up before installing:** on first install LocalGov Forms updates
> `webform.settings` with public-sector defaults. If you want to keep your existing
> Webform configuration, set `$settings['localgov_forms_skip_webform_config'] = TRUE;`
> in `settings.php` before enabling the module, then remove it afterwards.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_forms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies —
including Webform and Geocoder — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_forms -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_forms -y
```

## Submodules — enable only what you need

LocalGov Forms ships several optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Date** | `localgov_forms_date` | An accessible date input field based on the GDS Date Input pattern. |
| **Decision Tree** | `localgov_forms_decision_tree` | A decision-tree helper for guiding users through branching questions. |
| **Feedback Form** | `localgov_forms_feedback_form` | A ready-made feedback form. |
| **LTS** | `localgov_forms_lts` | Long-term-support helpers for the module. |
| **Liberty Create integration (example)** | `localgov_forms_example_liberty_create_integration` | An example integration showing how to connect forms to an external system. |

For example, to add the accessible date field:

```bash
drush en localgov_forms_date -y
```

## Address lookup — configure a Geocoder provider

The address-lookup element needs a Geocoder *provider* to resolve addresses. UK
councils typically install **LocalGov Geo** and the **OS Places Geocoder Provider**
plugin (free to UK councils); once present, the *LocalGov OS Places* backend becomes
selectable on the address-lookup element's configuration form. Sites outside the UK
will need a different provider. For automated tests the Nominatim provider is used.

## Verify it worked

Go to **Structure → Webforms** (`/admin/structure/webform`), create or edit a form,
and add an element — you should see the extra LocalGov components (such as the GDS
date field, once its submodule is enabled) in the element picker, and new forms should
already carry the public-sector defaults (Ajax, submit-once, and so on).
