#!/usr/bin/env bash
# Introspection SETUP: write and enable a throwaway module that provides ONE social_api
# Network plugin (id eval_probe_network, type social_auth), so the agent must inspect the
# live plugin.network.manager to name the registered network. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
M=web/modules/custom/social_api_eval_probe
mkdir -p "$M/src/Plugin/Network"
cat > "$M/social_api_eval_probe.info.yml" <<'YML'
name: Social API Eval Probe
type: module
description: 'Throwaway module registering one social_api Network plugin for evaluation.'
core_version_requirement: ^10 || ^11
package: Testing
dependencies:
  - social_api:social_api
YML
cat > "$M/src/Plugin/Network/EvalProbeNetwork.php" <<'PHP'
<?php

namespace Drupal\social_api_eval_probe\Plugin\Network;

use Drupal\social_api\Plugin\NetworkBase;

/**
 * Probe network plugin used by the social_api evaluation suite.
 *
 * @Network(
 *   id = "eval_probe_network",
 *   socialNetwork = @Translation("Eval Probe"),
 *   type = "social_auth",
 *   className = "\stdClass"
 * )
 */
class EvalProbeNetwork extends NetworkBase {

  /**
   * {@inheritdoc}
   */
  protected function initSdk(): mixed {
    return new \stdClass();
  }

}
PHP
drush en social_api_eval_probe -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: social_api_eval_probe enabled, Network plugin eval_probe_network registered"
