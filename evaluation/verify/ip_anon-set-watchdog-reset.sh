#!/usr/bin/env bash
# Execution RESET/CLEANUP: restore ip_anon defaults so verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("ip_anon.settings");$c->set("policy",0);foreach(["period_sessions","period_comment_field_data","period_watchdog","period_commerce_order","period_login_history","period_simple_access_log","period_tether_stats_activity_log","period_visitors","period_votingapi_vote","period_webform_submission"] as $k){$c->set($k,-1);}$c->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ip_anon.settings defaults (policy 0, period_watchdog -1)"
