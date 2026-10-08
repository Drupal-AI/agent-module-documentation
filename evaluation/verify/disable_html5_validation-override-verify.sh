#!/usr/bin/env bash
# Execution VERIFY: PASS when the built user_login_form has NO novalidate attribute (the agent's
# override removed it) AND the article node form still HAS novalidate (global effect intact).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $login = \Drupal::formBuilder()->getForm("Drupal\user\Form\UserLoginForm");
  $login_nv = $login["#attributes"]["novalidate"] ?? NULL;
  $article = NULL;
  if (\Drupal\node\Entity\NodeType::load("article")) {
    $node = \Drupal\node\Entity\Node::create(["type" => "article", "title" => "probe"]);
    $af = \Drupal::service("entity.form_builder")->getForm($node, "default");
    $article = $af["#attributes"]["novalidate"] ?? NULL;
  }
  $ok = ($login_nv === NULL) && ($article === "novalidate");
  print (($ok) ? "PASS" : "FAIL") . " login_novalidate=" . var_export($login_nv, TRUE) . " article_novalidate=" . var_export($article, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
