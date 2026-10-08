# How CVA wires into Twig

CVA has no config; it changes three things in the container/runtime so `html_cva` works
inside Drupal's sandboxed Twig. Useful when debugging why the function is (or isn't) available.

## 1. The Twig extension — `Drupal\cva\Twig\CvaTwigExtension`

Registered in `cva.services.yml` with the `twig.extension` tag. It instantiates
`Twig\Extra\Html\HtmlExtension` and re-exports **only** its `html_cva` function (filters the
rest out), so no other `twig/html-extra` helpers are added implicitly.

```yaml
# cva.services.yml
services:
  cva.twig_extension:
    class: Drupal\cva\Twig\CvaTwigExtension
    tags:
      - { name: twig.extension }
```

## 2. Decorated Twig environment — `Drupal\cva\Twig\CvaTwigEnvironment`

`Drupal\cva\CvaServiceProvider::alter()` rewrites the `twig` service definition's class to
`CvaTwigEnvironment` (a subclass of core's `TwigEnvironment`). On construction it reaches into
the already-registered `SandboxExtension` (via reflection) and replaces its policy object with
`CvaSandboxPolicy`. Verify which class is live:

```bash
drush php:eval 'echo get_class(\Drupal::service("twig"));'
# Drupal\cva\Twig\CvaTwigEnvironment
```

## 3. Sandbox policy — `Drupal\cva\Twig\CvaSandboxPolicy`

Extends core's `Drupal\Core\Template\TwigSandboxPolicy` and adds
`Twig\Extra\Html\Cva` to `allowed_classes`. Without this, Drupal's Twig sandbox would throw a
`SecurityError` when a template calls `.apply()` on the object returned by `html_cva`.

```bash
# Confirm the Cva class is whitelisted on the live policy:
drush php:eval '
  $s = \Drupal::service("twig")->getExtension(\Twig\Extension\SandboxExtension::class);
  $rp = new \ReflectionProperty($s, "policy"); $rp->setAccessible(true); $pol = $rp->getValue($s);
  $ra = new \ReflectionProperty(\Drupal\Core\Template\TwigSandboxPolicy::class, "allowed_classes");
  $ra->setAccessible(true);
  echo get_class($pol), " cva=", isset($ra->getValue($pol)["Twig\\Extra\\Html\\Cva"]) ? "yes" : "no";
'
# Drupal\cva\Twig\CvaSandboxPolicy cva=yes
```

## Gotcha

Changes to the service definition and sandbox only take effect after a container/cache rebuild
(`drush cr`). If `html_cva` is "unknown function" or `.apply()` throws a sandbox `SecurityError`,
rebuild caches and confirm the module is enabled.
