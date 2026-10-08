<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA CrowdSec events & tokens

One ECA event plugin (`@EcaEvent(id = "crowdsec", deriver = CrowdSecEventDeriver)`, class
`Drupal\eca_crowdsec\Plugin\ECA\Event\CrowdSecEvent`) with six derivatives.

| ECA event plugin id | Label | CrowdSec event name | Event class |
|---|---|---|---|
| `crowdsec:scenariolist` | Scenario list | `crowdsec.scenario.list_build` | `ScenarioList` |
| `crowdsec:signalscenariolist` | Signal scenario list | `crowdsec.signal.scenario.list_build` | `SignalScenarioList` |
| `crowdsec:blocked` | IP blocked | `crowdsec.ip.blocked` | `IpBlocked` |
| `crowdsec:banned` | IP banned | `crowdsec.ip.banned` | `IpBanned` |
| `crowdsec:unbanned` | IP unbanned | `crowdsec.ip.unbanned` | `IpUnBanned` |
| `crowdsec:signalled` | IP signalled | `crowdsec.ip.signalled` | `IpSignalled` |

(These map to the constants in `Drupal\crowdsec\Event\CrowdSecEvents`.)

## Tokens exposed to ECA (`buildEventData()`)

| Token | Available on | Value |
|---|---|---|
| `crowdsec_ip` | the four IP events (`IpBaseEvent`) | the IP address (`$event->getIp()`) |
| `crowdsec_scenario` | `crowdsec:signalled` (`IpSignalled`) | the scenario the IP was signalled for |
| `crowdsec_scenario_list` | the two list events (`ScenarioList`) | the array of scenarios (by reference) |

## Using it

Build an ECA model whose event is one of the `crowdsec:*` ids and attach conditions/actions. In an
`eca` config entity the event component's `plugin` is e.g. `crowdsec:banned`:

```php
\Drupal\eca\Entity\Eca::create([
  'id' => 'ban_notify', 'label' => 'Notify on ban', 'modeller' => 'fallback',
  'status' => TRUE, 'version' => '1.0.0',
  'events' => ['e1' => ['plugin' => 'crowdsec:banned', 'label' => 'On IP banned', 'configuration' => [], 'successors' => []]],
  'conditions' => [], 'gateways' => [], 'actions' => [],
])->save();
```

The available derivatives are discoverable at runtime from the ECA event plugin manager:
`\Drupal::service('plugin.manager.eca.event')->getDefinitions()` (filter ids starting `crowdsec:`).
