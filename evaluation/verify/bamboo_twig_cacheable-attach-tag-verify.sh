#!/usr/bin/env bash
# PASS when rendering the agent template bubbles the cache tag 'node:99' into the render context
# (i.e. it called bamboo_attach_cacheable_metadata with that tag).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = DRUPAL_ROOT."/sites/default/files/bamboo_twig_cacheable_attach_tag.html.twig";
  if (!is_file($f)) { print "FAIL no-template\n"; }
  else {
    try {
      $tpl = \Drupal::service("twig")->createTemplate(file_get_contents($f));
      $renderer = \Drupal::service("renderer");
      $ctx = new \Drupal\Core\Render\RenderContext();
      $renderer->executeInRenderContext($ctx, function() use ($tpl){ return $tpl->render([]); });
      $tags = $ctx->isEmpty() ? [] : $ctx->pop()->getCacheTags();
      $ok = in_array("node:99", $tags, TRUE);
      print ($ok?"PASS":"FAIL")." tags=".implode(",", $tags)."\n";
    } catch (\Throwable $e){ print "FAIL render-error: ".$e->getMessage()."\n"; }
  }
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
