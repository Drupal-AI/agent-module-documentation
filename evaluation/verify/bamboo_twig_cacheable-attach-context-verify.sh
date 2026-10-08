#!/usr/bin/env bash
# PASS when rendering the agent template bubbles the cache context 'user.permissions'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = DRUPAL_ROOT."/sites/default/files/bamboo_twig_cacheable_attach_context.html.twig";
  if (!is_file($f)) { print "FAIL no-template\n"; }
  else {
    try {
      $tpl = \Drupal::service("twig")->createTemplate(file_get_contents($f));
      $renderer = \Drupal::service("renderer");
      $ctx = new \Drupal\Core\Render\RenderContext();
      $renderer->executeInRenderContext($ctx, function() use ($tpl){ return $tpl->render([]); });
      $contexts = $ctx->isEmpty() ? [] : $ctx->pop()->getCacheContexts();
      $ok = in_array("user.permissions", $contexts, TRUE);
      print ($ok?"PASS":"FAIL")." contexts=".implode(",", $contexts)."\n";
    } catch (\Throwable $e){ print "FAIL render-error: ".$e->getMessage()."\n"; }
  }
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
