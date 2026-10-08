#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) live-state verification for decoupled_router.
# Confirms that decoupled_router actually RESOLVES the path /dr-resolved-page to a
# viewable node. We invoke the module's real resolver by dispatching its
# PathTranslatorEvent (the same event the /router/translate-path controller fires)
# and inspect the JSON response. Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
#   200  — a route was matched and an entity resolved
#   type=node, isExternal=false, resolved path ends with /dr-resolved-page
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  use Drupal\decoupled_router\PathTranslatorEvent;
  use Symfony\Component\HttpFoundation\Request;
  use Symfony\Component\HttpKernel\HttpKernelInterface;
  $path = "/dr-resolved-page";
  $event = new PathTranslatorEvent(
    \Drupal::service("http_kernel"),
    Request::create("/router/translate-path?path=" . $path),
    HttpKernelInterface::MAIN_REQUEST,
    $path
  );
  \Drupal::service("event_dispatcher")->dispatch($event, PathTranslatorEvent::TRANSLATE);
  $resp = $event->getResponse();
  $code = $resp->getStatusCode();
  $data = json_decode($resp->getContent(), TRUE);
  $type = $data["entity"]["type"] ?? "";
  $ext  = !empty($data["isExternal"]);
  $resolved = $data["resolved"] ?? "";
  $ok = ($code === 200 && $type === "node" && !$ext
         && substr($resolved, -strlen($path)) === $path);
  print ($ok ? "PASS" : "FAIL")
    . " status=" . $code . " type=" . $type
    . " isExternal=" . ($ext ? 1 : 0) . " resolved=" . $resolved . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
