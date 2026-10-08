<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CrowdSec events, services & hooks

## Events (`Drupal\crowdsec\Event\CrowdSecEvents`)

| Constant | Event name | Dispatched when | Event class |
|---|---|---|---|
| `SCENARIO_LIST_BUILD` | `crowdsec.scenario.list_build` | the subscribe-scenario list is built | `ScenarioList` (mutable `&getScenarios()`) |
| `SIGNAL_SCENARIO_LIST_BUILD` | `crowdsec.signal.scenario.list_build` | the signal-scenario list is built | `SignalScenarioList` |
| `IP_BLOCKED` | `crowdsec.ip.blocked` | a request from an IP is blocked (403) | `IpBlocked` (`getIp()`) |
| `IP_BANNED` | `crowdsec.ip.banned` | an IP is banned | `IpBanned` |
| `IP_UNBANNED` | `crowdsec.ip.unbanned` | an IP is un-banned | `IpUnBanned` |
| `IP_SIGNALLED` | `crowdsec.ip.signalled` | an IP is signalled upstream | `IpSignalled` (`getIp()`, `getScenario()`) |

The two list events pass the scenarios array **by reference**, so a subscriber can add/remove
available scenarios. IP events extend `IpBaseEvent` (`getIp()`). These events are what the bundled
**eca_crowdsec** submodule surfaces to ECA.

## Key services

| Service | Class | Role |
|---|---|---|
| `crowdsec.client` | `Client` | talks to the CrowdSec API; `refresh()`, `verifyIp()`, `watcher()` |
| `crowdsec.buffer` | `Buffer` | batches signals; `bufferSignal()`, `push()` |
| `crowdsec.signals` | `Signals` | builds `signalScenarios()` / `scenarios()` option lists (fires the list events) |
| `crowdsec.middleware` | `Middleware` | HTTP middleware (priority 250) that enforces remediation (403) |
| `crowdsec.ban` | `Ban` | ban helper |
| `plugin.manager.crowdsec_scenario` | `ScenarioPluginManager` | scenario/ban plugin manager |

`Signals::validSignalScenarios()` / `validScenarios()` are the schema `Choice` callbacks that
validate the `signal_scenarios` / `scenarios` config values.

## Hooks & cron (`Drupal\crowdsec\Hook\CrowdsecHooks`)

- `hook_cron()` → `Buffer::push()` + `Client::refresh()`.
- `hook_form_ban_ip_form_alter()` → when an admin bans an IP via core Ban, also signals it through the
  `core-ban` scenario plugin.
- `hook_config_schema_info_alter()` → dynamically adds each scenario plugin's settings schema under
  `crowdsec.settings` → `plugins.<id>`.
- `hook_crowdsec_scenario_info_alter()` — alter discovered scenario plugin definitions.
