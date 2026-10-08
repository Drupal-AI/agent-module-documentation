#!/usr/bin/env bash
# Introspection SETUP: create follow button set rrssb_follow with twitter username 'acmecorp'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rrssb\Entity\RRSSBButtonSet;
  if ($s = RRSSBButtonSet::load("rrssb_follow")) { $s->delete(); }
  RRSSBButtonSet::create([
    "id" => "rrssb_follow", "label" => "Follow Us", "follow" => 1,
    "chosen" => [
      "twitter" => ["enabled" => TRUE, "weight" => -17, "username" => "acmecorp"],
      "facebook" => ["enabled" => TRUE, "weight" => -19, "username" => "acmecorp"],
    ],
  ])->save();
' >/dev/null 2>&1
echo "setup: rrssb.button_set.rrssb_follow follow=1 twitter username=acmecorp"
