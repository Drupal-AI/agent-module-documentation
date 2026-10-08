<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Basic Firewall Drush commands

Provided by `Drupal\basic_firewall\Drush\Commands\BasicFirewallCommands`.

- `drush basic-firewall:rebuild` (alias `bfw:rebuild`) — regenerate the compiled configuration file from current config. Run after importing config or if the compiled file was deleted.
- `drush basic-firewall:status` (alias `bfw:status`) — report firewall runtime state as an Item/Value table (enabled flag, compiled-file presence, library capabilities, etc.).
- `drush basic-firewall:rules` (alias `bfw:rules`) — list configured rules with fields id, label, type, response, weight, enabled.
