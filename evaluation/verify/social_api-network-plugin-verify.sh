#!/usr/bin/env bash
# Execution VERIFY: PASS when plugin.network.manager knows a Network plugin with id
# social_api_eval_net whose definition has type "social_auth" and whose class is a subclass
# of Drupal\social_api\Plugin\NetworkBase. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $manager = \Drupal::service("plugin.network.manager");
  $has = $manager->hasDefinition("social_api_eval_net");
  $def = $has ? $manager->getDefinition("social_api_eval_net") : [];
  $type = $def["type"] ?? "none";
  $class = $def["class"] ?? "none";
  $isBase = $class !== "none" && class_exists($class)
    && is_subclass_of($class, "Drupal\\social_api\\Plugin\\NetworkBase");
  $ok = $has && ($type === "social_auth") && $isBase;
  print ($ok ? "PASS" : "FAIL") . " definition=" . ($has ? "yes" : "no")
    . " type=" . $type . " class=" . $class
    . " extends_NetworkBase=" . ($isBase ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
