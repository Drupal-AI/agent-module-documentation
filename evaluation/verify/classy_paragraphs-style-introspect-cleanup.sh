#!/usr/bin/env bash
# MEDIUM cleanup: remove the eval_card style created by the setup script.
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("classy_paragraphs_style")->load("eval_card")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: classy_paragraphs_style eval_card removed"
