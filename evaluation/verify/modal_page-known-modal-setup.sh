#!/usr/bin/env bash
# Introspection SETUP (modal_page M1): create a modal 'mp_known' that shows on /node/* pages at
# large size. The agent must inspect the live modal config entity to report which pages it
# targets. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\modal_page\Entity\Modal;
  if (!Modal::load("mp_known")) {
    Modal::create(["id"=>"mp_known","label"=>"Known Modal","body"=>["value"=>"<p>Hi</p>","format"=>"basic_html"],
      "pages"=>"/node/*","type"=>"page","modal_size"=>"modal-lg","auto_open"=>TRUE,"published"=>TRUE,"roles"=>[]])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: modal mp_known targets pages /node/* (size modal-lg)"
