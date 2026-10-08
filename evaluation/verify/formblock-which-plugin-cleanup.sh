#!/usr/bin/env bash
# Introspection CLEANUP: remove the block instance and the contact form created by setup.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\contact\Entity\ContactForm;
  use Drupal\block\Entity\Block;
  if ($b = Block::load("formblock_fb_mystery")) { $b->delete(); }
  if ($c = ContactForm::load("formblock_support")) { $c->delete(); }
' >/dev/null 2>&1
echo "cleanup: formblock_fb_mystery block and formblock_support contact form removed"
