# Models & configuration

## Models
A model is an `eca` config entity (`src/Entity/Eca.php`, `#[ConfigEntityType(id: 'eca',
config_prefix: 'eca')]`, storage `EcaStorage`). Each model holds ordered **events**,
**conditions**, and **actions** plus their `configuration`. Because they are config, models
export/import with `drush config:export` / `config:import` and deploy like any other config
(`eca.eca.*.yml`).

## Where you edit them
ECA Core has no UI. Install **eca_ui** (+ a modeler such as `bpmn_io`) — models are then managed
at `/admin/config/workflow/eca` (route/owner provided through `modeler_api`, see
`modules/ui/src/Plugin/ModelerApiModelOwner/Eca.php`). Settings form (`eca_ui` `Settings.php`)
writes config `eca.settings`.

## Config schema
Provided: `config/schema/eca.schema.yml` and `config/schema/eca.data_types.schema.yml`.

## After changing models/plugins
Rebuild ECA's event subscribers so new triggers take effect:
`drush eca:subscriber:rebuild` (also runs on cache rebuild). See
[../drush/commands.md](../drush/commands.md).

## Tokens
ECA passes data between steps via Drupal tokens; actions read/write named tokens (see
`src/Token`). Scheduled triggers use cron expressions (`dragonmantank/cron-expression`).
