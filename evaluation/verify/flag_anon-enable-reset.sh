#!/usr/bin/env bash
# Execution RESET: ensure the Flag "flaganon_eval" exists but with Flag Anonymous NOT enabled
# (all flag_anon third-party settings removed), so verify FAILS until the agent enables it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\flag\Entity\Flag; if(!\Drupal::entityTypeManager()->getStorage("flag")->load("flaganon_eval")){ Flag::create(["id"=>"flaganon_eval","label"=>"Save to favorites","entity_type"=>"node","bundles"=>["article"],"flag_type"=>"entity:node","link_type"=>"reload","global"=>FALSE])->save(); }
  $f = \Drupal::entityTypeManager()->getStorage("flag")->load("flaganon_eval");
  foreach (array_keys($f->getThirdPartySettings("flag_anon")) as $k) { $f->unsetThirdPartySetting("flag_anon", $k); }
  $f->save();
' >/dev/null 2>&1
echo "reset: flag flaganon_eval present, flag_anon disabled"
