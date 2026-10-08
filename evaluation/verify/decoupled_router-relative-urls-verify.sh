#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) live-state verification for decoupled_router.
# Confirms the agent configured decoupled_router to return RELATIVE resolved URLs
# (absolute_resolved_urls = false). We create a throwaway Article + alias, run the
# real resolver via its PathTranslatorEvent, assert the response `resolved` value is
# site-relative (starts with "/", not "http"), then delete the throwaway node.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  use Drupal\decoupled_router\PathTranslatorEvent;
  use Symfony\Component\HttpFoundation\Request;
  use Symfony\Component\HttpKernel\HttpKernelInterface;
  $setting = \Drupal::config("decoupled_router.settings")->get("absolute_resolved_urls");
  $alias = "/dr-relerify-" . substr(md5(microtime()), 0, 6);
  $node = \Drupal\node\Entity\Node::create(["type" => "article", "title" => "DR Rel Verify", "status" => 1]);
  $node->save();
  \Drupal::entityTypeManager()->getStorage("path_alias")->create([
    "path" => "/node/" . $node->id(), "alias" => $alias,
  ])->save();
  \Drupal::service("path_alias.manager")->cacheClear();
  $event = new PathTranslatorEvent(
    \Drupal::service("http_kernel"),
    Request::create("/router/translate-path?path=" . $alias),
    HttpKernelInterface::MAIN_REQUEST,
    $alias
  );
  \Drupal::service("event_dispatcher")->dispatch($event, PathTranslatorEvent::TRANSLATE);
  $data = json_decode($event->getResponse()->getContent(), TRUE);
  $resolved = $data["resolved"] ?? "";
  foreach (\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["alias" => $alias]) as $a) { $a->delete(); }
  $node->delete();
  $relative = ($resolved !== "" && $resolved[0] === "/" && strpos($resolved, "http") !== 0);
  $ok = ($setting === FALSE && $relative);
  print ($ok ? "PASS" : "FAIL")
    . " setting=" . var_export($setting, TRUE)
    . " resolved=" . $resolved . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
