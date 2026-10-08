#!/usr/bin/env bash
# Introspection CLEANUP: remove the cse_feedback contact form.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\contact\Entity\ContactForm; if ($f = ContactForm::load("cse_feedback")) { $f->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: contact form cse_feedback removed"
