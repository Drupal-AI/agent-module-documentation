# The Twig extension & rendering from PHP

## What is registered

`twig_vardumper.services.yml` registers one service, tagged `twig.extension`:

```yaml
services:
  twig_vardumper.twig_extension:
    class: Drupal\twig_vardumper\TwigExtension
    arguments: []
    tags:
      - { name: twig.extension }
```

`Drupal\twig_vardumper\TwigExtension::getFunctions()` returns two `TwigFunction`s — `dump` and
`vardumper` — both bound to the same `drupalDump()` method with options
`is_safe: ['html']`, `needs_context: TRUE`, `needs_environment: TRUE`, `is_variadic: TRUE`.
`getName()` returns `twig_vardumper`.

`drupalDump(Environment $env, array $context, array $args = [])`:
1. returns `FALSE` immediately if `!$env->isDebug()`;
2. otherwise `VarDumper::dump()`s each value in `$args` (or the whole `$context` if none),
   buffering with `ob_start()` / `ob_get_clean()` and returning the captured HTML.

## Dependency

Requires the `symfony/var-dumper` library (`^5|^6|^7`), declared in the module's
`composer.json`. `twig_vardumper.install`'s `hook_requirements()` blocks install if
`\Symfony\Component\VarDumper\VarDumper` is not found. Drupal core already ships var-dumper, so
normally nothing extra is needed.

## Inspect the live extension

```bash
drush php:eval '$e = \Drupal::service("twig")->getExtension("Drupal\\twig_vardumper\\TwigExtension");
foreach ($e->getFunctions() as $f) { echo $f->getName(), "\n"; }'
# dump
# vardumper
```

## Render a dump programmatically (tests / verification)

Because output depends on `$env->isDebug()`, force debug on the twig service first — this is
in-process only (it does **not** change `twig.config` or persist), so it is the clean way to
exercise the functions from a script:

```bash
drush php:eval '
  $t = \Drupal::service("twig");
  $t->enableDebug();                       // required: else the functions return FALSE
  $out = $t->renderInline("{{ dump(\"HELLO\") }}");
  echo (strpos($out, "HELLO") !== false && strpos($out, "sf-dump") !== false) ? "ok\n" : "empty\n";
'
```

`renderInline()` uses the shared `twig` service, so both `dump` and `vardumper` are available.
The rendered HTML wraps the value in the Symfony `sf-dump` markup (e.g.
`<pre class=sf-dump …><span class=sf-dump-str …>HELLO</span></pre>` plus a one-time `<script>`/
`<style>` asset block on the first dump per request).
