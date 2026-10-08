#!/usr/bin/env bash
# Introspection SETUP: install a KNOWN redirect so an inspecting agent can read it back.
# Creates a redirect from source path `eval-intro-src` to `node/1` (stored uri
# internal:/node/1) with a KNOWN status code 302. Idempotent: deletes any prior
# eval-intro-src redirect first. Mirrors pathauto-article-pattern-setup.sh but operates
# on redirect storage. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("redirect");
  foreach ($storage->loadByProperties(["redirect_source__path" => "eval-intro-src"]) as $r) { $r->delete(); }
  $r = $storage->create([]);
  $r->setSource("eval-intro-src");
  $r->setRedirect("node/1");
  $r->setStatusCode(302);
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: redirect eval-intro-src installed (-> internal:/node/1, status 302)"
