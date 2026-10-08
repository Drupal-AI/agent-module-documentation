#!/usr/bin/env bash
# Introspection SETUP: create a dedicated contact form entity (formblock_support) and place
# a Form block "FB Mystery Form" that uses the formblock_contact plugin pointed at it.
# The agent must read the live block config to name the plugin and the targeted contact form.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\contact\Entity\ContactForm;
  use Drupal\block\Entity\Block;
  if (!ContactForm::load("formblock_support")) {
    ContactForm::create([
      "id" => "formblock_support",
      "label" => "FB Support",
      "recipients" => ["support@example.com"],
      "reply" => "",
      "weight" => 0,
      "message" => "Your message has been sent.",
    ])->save();
  }
  if ($b = Block::load("formblock_fb_mystery")) { $b->delete(); }
  Block::create([
    "id" => "formblock_fb_mystery",
    "theme" => "olivero",
    "region" => "footer_top",
    "plugin" => "formblock_contact",
    "weight" => 10,
    "status" => TRUE,
    "settings" => [
      "id" => "formblock_contact",
      "label" => "FB Mystery Form",
      "label_display" => "visible",
      "provider" => "contact",
      "contact_form" => "formblock_support",
    ],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
echo "setup: block.block.formblock_fb_mystery = formblock_contact -> contact form formblock_support"
