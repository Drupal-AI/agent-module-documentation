#!/usr/bin/env bash
# Execution VERIFY: PASS when an UNPUBLISHED node titled 'U404 Hard Draft' exists AND the
# unpublished_404 subscriber converts an anonymous 403 for it into a 404 (NotFoundHttpException).
# Tests the module's real behavior directly (robust to unrelated error-page rendering issues).
# FAILs if the node is missing or published. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\unpublished_404\EventSubscriber\NotFound;
  use Drupal\Core\Session\AccountProxy;
  use Drupal\Core\Session\AnonymousUserSession;
  use Symfony\Component\HttpFoundation\Request;
  use Symfony\Component\HttpKernel\Event\ExceptionEvent;
  use Symfony\Component\HttpKernel\HttpKernelInterface;
  use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;
  use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
  $ns = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "U404 Hard Draft"]);
  if (!$ns) { print "FAIL node-missing"; return; }
  $n = reset($ns);
  if ($n->isPublished()) { print "FAIL node-published nid=".$n->id(); return; }
  $proxy = new AccountProxy(\Drupal::service("event_dispatcher"));
  $proxy->setAccount(new AnonymousUserSession());
  $sub = new NotFound($proxy);
  $req = Request::create("/node/".$n->id());
  $req->attributes->set("node", $n);
  $event = new ExceptionEvent(\Drupal::service("http_kernel"), $req, HttpKernelInterface::MAIN_REQUEST, new AccessDeniedHttpException());
  $sub->on403($event);
  $t = $event->getThrowable();
  print (($t instanceof NotFoundHttpException) ? "PASS" : "FAIL") . " nid=".$n->id()." throwable=".get_class($t);
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
