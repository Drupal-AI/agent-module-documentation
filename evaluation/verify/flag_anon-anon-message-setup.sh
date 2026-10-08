#!/usr/bin/env bash
# Introspection SETUP: create a Flag "flaganon_eval" and enable Flag Anonymous on it with a
# known message, so an inspecting agent can read back which flag shows an anon CTA and its
# message. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\flag\Entity\Flag; if(!\Drupal::entityTypeManager()->getStorage("flag")->load("flaganon_eval")){ Flag::create(["id"=>"flaganon_eval","label"=>"Save to favorites","entity_type"=>"node","bundles"=>["article"],"flag_type"=>"entity:node","link_type"=>"reload","global"=>FALSE])->save(); }
  $f = \Drupal::entityTypeManager()->getStorage("flag")->load("flaganon_eval");
  $f->setThirdPartySetting("flag_anon","enabled",1);
  $f->setThirdPartySetting("flag_anon","message","@login or @register to save this to your favorites");
  $f->setThirdPartySetting("flag_anon","login_label","Sign in");
  $f->setThirdPartySetting("flag_anon","register_label","Join");
  $f->save();
' >/dev/null 2>&1
echo "setup: flag flaganon_eval has flag_anon.enabled=1 with a favorites message"
