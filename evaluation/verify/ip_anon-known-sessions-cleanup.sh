#!/usr/bin/env bash
# Introspection CLEANUP: restore ip_anon shipped defaults (policy 0, all periods -1).
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("ip_anon.settings");$c->set("policy",0);foreach(["period_sessions","period_comment_field_data","period_watchdog","period_commerce_order","period_login_history","period_simple_access_log","period_tether_stats_activity_log","period_visitors","period_votingapi_vote","period_webform_submission"] as $k){$c->set($k,-1);}$c->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ip_anon.settings restored to defaults"
