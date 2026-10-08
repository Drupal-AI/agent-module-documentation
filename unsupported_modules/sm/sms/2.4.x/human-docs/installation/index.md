# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **PHP 8.3 or newer** (`php: >=8.3`) — a hard requirement.
- The **Dynamic Entity Reference** module (`drupal/dynamic_entity_reference`, `^3 || ^4`) —
  used so a phone-number verification can point at any entity type. Composer pulls it in.
- Core's **Telephone** and **System** modules (Telephone provides the phone-number field type).
- *Optional:* the **Token** module improves the token-selection UI on SMS message forms.

## Install with Composer

Note that the Composer project name differs from the module's machine name — the project is
**`smsframework`**, while the module you enable is **`sms`**:

```bash
composer require drupal/smsframework -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Dynamic Entity Reference and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smsframework -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sms -y
```

Drupal enables Telephone, System, and Dynamic Entity Reference automatically as dependencies.
A default **Log** gateway is installed and set as the fallback, so the framework is functional
(for testing) right away.

## Submodules — enable what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **SMS Blast** | `sms_blast` | Send a bulk "blast" to all users with a verified phone number. |
| **SMS Devel** | `sms_devel` | A developer form for testing sending and receiving messages. |
| **SMS Send to Phone** | `sms_sendtophone` | Send a node, or highlighted text, to a phone via a link/filter. |
| **SMS User** | `sms_user` | User integration: SMS-driven account registration, per-user active-hours delays, and more. |

```bash
drush en sms_blast sms_devel sms_sendtophone sms_user -y
```

## Next steps

The Log gateway lets you build and test everything without a real provider. To send real
texts, install a gateway provider module for your chosen SMS company, then create a gateway
that selects it and enter your credentials — see [Configuration](../configuration/index.md).
